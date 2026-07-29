# OpenSSL uses its own Configure/make build system. Build a static copy from
# vendored source and expose normal CMake targets to the engine and games.
include(ExternalProject)

set(_cocos_openssl_source_dir "${COCOS_EXTERNAL_ROOT}/openssl")
set(_cocos_openssl_binary_dir "${CMAKE_CURRENT_BINARY_DIR}/openssl")
set(_cocos_openssl_stage_dir "${_cocos_openssl_binary_dir}/stage")

if(MACOSX)
    if(CMAKE_OSX_ARCHITECTURES)
        list(GET CMAKE_OSX_ARCHITECTURES 0 _cocos_openssl_arch)
    else()
        execute_process(COMMAND uname -m OUTPUT_VARIABLE _cocos_openssl_arch OUTPUT_STRIP_TRAILING_WHITESPACE)
    endif()
    if(_cocos_openssl_arch STREQUAL "arm64")
        set(_cocos_openssl_target darwin64-arm64-cc)
    elseif(_cocos_openssl_arch STREQUAL "x86_64")
        set(_cocos_openssl_target darwin64-x86_64-cc)
    else()
        message(FATAL_ERROR "OpenSSL 4 prebuilt does not support macOS architecture '${_cocos_openssl_arch}'")
    endif()
    set(_cocos_openssl_env
        "${CMAKE_COMMAND}" -E env
        "CC=${CMAKE_C_COMPILER}"
        "AR=${CMAKE_AR}"
        "RANLIB=${CMAKE_RANLIB}"
    )
    set(_cocos_openssl_platform_args)
elseif(ANDROID)
    if(ANDROID_ABI STREQUAL "armeabi-v7a")
        set(_cocos_openssl_target android-arm)
    elseif(ANDROID_ABI STREQUAL "arm64-v8a")
        set(_cocos_openssl_target android-arm64)
    elseif(ANDROID_ABI STREQUAL "x86")
        set(_cocos_openssl_target android-x86)
    elseif(ANDROID_ABI STREQUAL "x86_64")
        set(_cocos_openssl_target android-x86_64)
    else()
        message(FATAL_ERROR "OpenSSL 4 prebuilt does not support Android ABI '${ANDROID_ABI}'")
    endif()

    if(NOT CMAKE_ANDROID_NDK)
        message(FATAL_ERROR "CMAKE_ANDROID_NDK is required to build OpenSSL for Android")
    endif()
    if(NOT ANDROID_HOST_TAG)
        if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
            set(ANDROID_HOST_TAG darwin-x86_64)
        elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
            set(ANDROID_HOST_TAG linux-x86_64)
        elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
            set(ANDROID_HOST_TAG windows-x86_64)
        else()
            message(FATAL_ERROR "Unsupported Android NDK host '${CMAKE_HOST_SYSTEM_NAME}'")
        endif()
    endif()
    set(_cocos_openssl_toolchain_bin
        "${CMAKE_ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin")
    if(NOT IS_DIRECTORY "${_cocos_openssl_toolchain_bin}")
        message(FATAL_ERROR "Android NDK LLVM toolchain not found: ${_cocos_openssl_toolchain_bin}")
    endif()

    if(ANDROID_PLATFORM_LEVEL)
        set(_cocos_openssl_android_api "${ANDROID_PLATFORM_LEVEL}")
    else()
        string(REGEX REPLACE "^android-" "" _cocos_openssl_android_api "${ANDROID_PLATFORM}")
    endif()
    if(NOT _cocos_openssl_android_api MATCHES "^[0-9]+$")
        set(_cocos_openssl_android_api 23)
    endif()

    set(_cocos_openssl_env
        "${CMAKE_COMMAND}" -E env
        "ANDROID_NDK_ROOT=${CMAKE_ANDROID_NDK}"
        "CPPFLAGS=-Wno-macro-redefined"
        "PATH=${_cocos_openssl_toolchain_bin}:$ENV{PATH}"
    )
    # The static OpenSSL archives are ultimately linked into each Android
    # application's shared library, so every object (including generated
    # assembly) must be position-independent.
    set(_cocos_openssl_platform_args
        "-D__ANDROID_API__=${_cocos_openssl_android_api}"
        "-fPIC"
    )
else()
    message(FATAL_ERROR "The source-built OpenSSL wrapper currently supports macOS and Android only")
endif()

find_program(_cocos_openssl_perl perl REQUIRED)
find_program(_cocos_openssl_make NAMES gmake make REQUIRED NO_CMAKE_FIND_ROOT_PATH)
if(DEFINED ENV{CMAKE_BUILD_PARALLEL_LEVEL}
   AND "$ENV{CMAKE_BUILD_PARALLEL_LEVEL}" MATCHES "^[1-9][0-9]*$")
    set(_cocos_openssl_jobs "$ENV{CMAKE_BUILD_PARALLEL_LEVEL}")
else()
    include(ProcessorCount)
    ProcessorCount(_cocos_openssl_jobs)
    if(NOT _cocos_openssl_jobs)
        set(_cocos_openssl_jobs 1)
    elseif(_cocos_openssl_jobs GREATER 8)
        set(_cocos_openssl_jobs 8)
    endif()
endif()
ExternalProject_Add(cocos_openssl
    SOURCE_DIR "${_cocos_openssl_source_dir}"
    BINARY_DIR "${_cocos_openssl_binary_dir}/build"
    CONFIGURE_COMMAND ${_cocos_openssl_env}
        "${_cocos_openssl_perl}" "${_cocos_openssl_source_dir}/Configure" "${_cocos_openssl_target}"
        ${_cocos_openssl_platform_args}
        no-shared no-pinshared no-tests no-apps no-docs no-demos
        no-fuzz-afl no-fuzz-libfuzzer "--prefix=${_cocos_openssl_stage_dir}"
    BUILD_COMMAND ${_cocos_openssl_env} "${_cocos_openssl_make}" "-j${_cocos_openssl_jobs}" build_libs
    INSTALL_COMMAND ${_cocos_openssl_env} "${_cocos_openssl_make}" "-j${_cocos_openssl_jobs}" install_dev
    BUILD_BYPRODUCTS "${_cocos_openssl_stage_dir}/lib/libcrypto.a" "${_cocos_openssl_stage_dir}/lib/libssl.a"
)

add_library(OpenSSL::Crypto STATIC IMPORTED GLOBAL)
set_target_properties(OpenSSL::Crypto PROPERTIES IMPORTED_LOCATION "${_cocos_openssl_stage_dir}/lib/libcrypto.a" INTERFACE_INCLUDE_DIRECTORIES "${_cocos_openssl_stage_dir}/include")
if(ANDROID)
    set_property(TARGET OpenSSL::Crypto APPEND PROPERTY
        INTERFACE_LINK_LIBRARIES dl)
    # OpenSSL's arm64 assembly contains direct references between objects in
    # libcrypto.a. Keeping archive symbols local to the application's shared
    # library makes those references non-preemptible and preserves the
    # optimized assembly implementation.
    set_property(TARGET OpenSSL::Crypto APPEND PROPERTY
        INTERFACE_LINK_OPTIONS "LINKER:--exclude-libs,libcrypto.a")
endif()
add_dependencies(OpenSSL::Crypto cocos_openssl)
add_library(OpenSSL::SSL STATIC IMPORTED GLOBAL)
set_target_properties(OpenSSL::SSL PROPERTIES IMPORTED_LOCATION "${_cocos_openssl_stage_dir}/lib/libssl.a" INTERFACE_INCLUDE_DIRECTORIES "${_cocos_openssl_stage_dir}/include" INTERFACE_LINK_LIBRARIES OpenSSL::Crypto)
add_dependencies(OpenSSL::SSL cocos_openssl)

# Retain Cocos 3.17's target names for source-tree projects.
add_library(ext_crypto INTERFACE)
target_link_libraries(ext_crypto INTERFACE OpenSSL::Crypto)
add_library(ext_ssl INTERFACE)
target_link_libraries(ext_ssl INTERFACE OpenSSL::SSL)
set(COCOS_OPENSSL_STAGE_DIR "${_cocos_openssl_stage_dir}")
