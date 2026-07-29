# Build the vendored official LuaJIT source with its supported Makefile build.
# LuaJIT generates target-specific VM assembly and public version headers, so
# the build runs in a private copy instead of modifying external/luajit.

set(_cocos_luajit_source_dir "${COCOS_EXTERNAL_ROOT}/luajit")
set(_cocos_luajit_build_dir "${CMAKE_CURRENT_BINARY_DIR}/luajit-source")
set(_cocos_luajit_archive "${_cocos_luajit_build_dir}/src/libluajit.a")

find_program(_cocos_luajit_make
    NAMES gmake make
    REQUIRED
    NO_CMAKE_FIND_ROOT_PATH)

file(MAKE_DIRECTORY "${_cocos_luajit_build_dir}")
file(COPY "${_cocos_luajit_source_dir}/"
     DESTINATION "${_cocos_luajit_build_dir}")
file(GLOB_RECURSE _cocos_luajit_inputs
    "${_cocos_luajit_source_dir}/*")

find_program(_cocos_luajit_host_cc
    NAMES cc clang gcc
    NO_CMAKE_FIND_ROOT_PATH)
if(NOT _cocos_luajit_host_cc)
    message(FATAL_ERROR "LuaJIT requires a native host C compiler")
endif()

set(_cocos_luajit_environment)
set(_cocos_luajit_make_args
    "BUILDMODE=static"
    "HOST_CC=${_cocos_luajit_host_cc}"
)
set(_cocos_luajit_target_cflags "-fPIC")

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    string(APPEND _cocos_luajit_target_cflags " -g")
endif()

if(MACOSX)
    if(CMAKE_OSX_DEPLOYMENT_TARGET)
        set(_cocos_luajit_macos_target "${CMAKE_OSX_DEPLOYMENT_TARGET}")
    else()
        set(_cocos_luajit_macos_target "11.0")
    endif()

    list(APPEND _cocos_luajit_environment
        "MACOSX_DEPLOYMENT_TARGET=${_cocos_luajit_macos_target}")
    list(APPEND _cocos_luajit_make_args
        "CC=${CMAKE_C_COMPILER}"
        "TARGET_SYS=Darwin")

    if(CMAKE_OSX_ARCHITECTURES)
        list(LENGTH CMAKE_OSX_ARCHITECTURES _cocos_luajit_arch_count)
        if(NOT _cocos_luajit_arch_count EQUAL 1)
            message(FATAL_ERROR
                "LuaJIT requires one macOS architecture per build directory")
        endif()
        list(GET CMAKE_OSX_ARCHITECTURES 0 _cocos_luajit_arch)
        string(APPEND _cocos_luajit_target_cflags
            " -arch ${_cocos_luajit_arch}")
        list(APPEND _cocos_luajit_make_args
            "TARGET_LDFLAGS=-arch ${_cocos_luajit_arch}")
    endif()
elseif(ANDROID)
    if(ANDROID_ABI STREQUAL "arm64-v8a")
        set(_cocos_luajit_android_triple "aarch64-linux-android")
    elseif(ANDROID_ABI STREQUAL "armeabi-v7a")
        set(_cocos_luajit_android_triple "armv7a-linux-androideabi")
    elseif(ANDROID_ABI STREQUAL "x86")
        set(_cocos_luajit_android_triple "i686-linux-android")
    elseif(ANDROID_ABI STREQUAL "x86_64")
        set(_cocos_luajit_android_triple "x86_64-linux-android")
    else()
        message(FATAL_ERROR "LuaJIT does not support Android ABI '${ANDROID_ABI}'")
    endif()

    if(ANDROID_PLATFORM MATCHES "android-([0-9]+)")
        set(_cocos_luajit_android_api "${CMAKE_MATCH_1}")
    else()
        set(_cocos_luajit_android_api "24")
    endif()

    get_filename_component(_cocos_luajit_toolchain_bin
        "${CMAKE_C_COMPILER}" DIRECTORY)
    set(_cocos_luajit_target_cc
        "${_cocos_luajit_toolchain_bin}/${_cocos_luajit_android_triple}${_cocos_luajit_android_api}-clang")
    if(NOT EXISTS "${_cocos_luajit_target_cc}")
        message(FATAL_ERROR
            "LuaJIT Android compiler was not found: ${_cocos_luajit_target_cc}")
    endif()

    list(APPEND _cocos_luajit_make_args
        "TARGET_SYS=Linux"
        "TARGET_CC=${_cocos_luajit_target_cc}"
        "TARGET_LD=${_cocos_luajit_target_cc}"
        "TARGET_AR=${CMAKE_AR} rcus"
        "TARGET_STRIP=${CMAKE_STRIP}")
elseif(LINUX)
    list(APPEND _cocos_luajit_make_args
        "CC=${CMAKE_C_COMPILER}"
        "TARGET_SYS=Linux")
else()
    message(FATAL_ERROR
        "The source-built LuaJIT wrapper currently supports macOS, Android, "
        "and Linux")
endif()

list(APPEND _cocos_luajit_make_args
    "TARGET_CFLAGS=${_cocos_luajit_target_cflags}")

add_custom_command(
    OUTPUT
        "${_cocos_luajit_archive}"
        "${_cocos_luajit_build_dir}/src/luajit.h"
        "${_cocos_luajit_build_dir}/src/lua.hpp"
    COMMAND "${CMAKE_COMMAND}" -E copy_directory
        "${_cocos_luajit_source_dir}"
        "${_cocos_luajit_build_dir}"
    COMMAND "${CMAKE_COMMAND}" -E env
        ${_cocos_luajit_environment}
        "${_cocos_luajit_make}"
        -C "${_cocos_luajit_build_dir}/src"
        ${_cocos_luajit_make_args}
        libluajit.a
    DEPENDS ${_cocos_luajit_inputs}
    COMMENT "Building LuaJIT from vendored source"
    VERBATIM
)

add_custom_target(cocos_luajit
    DEPENDS
        "${_cocos_luajit_archive}"
        "${_cocos_luajit_build_dir}/src/luajit.h"
        "${_cocos_luajit_build_dir}/src/lua.hpp"
)

add_library(ext_luajit INTERFACE)
add_dependencies(ext_luajit cocos_luajit)
target_link_libraries(ext_luajit INTERFACE "${_cocos_luajit_archive}")
target_include_directories(ext_luajit INTERFACE
    "${_cocos_luajit_build_dir}/src")

unset(_cocos_luajit_source_dir)
unset(_cocos_luajit_build_dir)
unset(_cocos_luajit_archive)
unset(_cocos_luajit_inputs)
unset(_cocos_luajit_make)
unset(_cocos_luajit_host_cc)
unset(_cocos_luajit_environment)
unset(_cocos_luajit_make_args)
unset(_cocos_luajit_target_cflags)
unset(_cocos_luajit_macos_target)
unset(_cocos_luajit_arch_count)
unset(_cocos_luajit_arch)
unset(_cocos_luajit_android_triple)
unset(_cocos_luajit_android_api)
unset(_cocos_luajit_toolchain_bin)
unset(_cocos_luajit_target_cc)
