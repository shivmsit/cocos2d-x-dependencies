# curl's CMake configuration probes OpenSSL headers. Run it as a build-time
# external project after OpenSSL has staged its generated headers and CMake
# package files; this also prevents host OpenSSL discovery.
include(ExternalProject)
set(_cocos_curl_binary_dir "${CMAKE_CURRENT_BINARY_DIR}/curl")
set(_cocos_curl_archive_name libcurl)
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(_cocos_curl_archive_name libcurl-d)
endif()
set(_cocos_curl_archive "${_cocos_curl_binary_dir}/build/lib/${_cocos_curl_archive_name}.a")
set(_cocos_curl_cmake_args
    "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
    "-DCMAKE_PREFIX_PATH=${COCOS_OPENSSL_STAGE_DIR}"
    "-DOPENSSL_ROOT_DIR=${COCOS_OPENSSL_STAGE_DIR}"
    "-DOPENSSL_INCLUDE_DIR=${COCOS_OPENSSL_STAGE_DIR}/include"
    "-DOPENSSL_CRYPTO_LIBRARY=${COCOS_OPENSSL_STAGE_DIR}/lib/libcrypto.a"
    "-DOPENSSL_SSL_LIBRARY=${COCOS_OPENSSL_STAGE_DIR}/lib/libssl.a"
    -DOPENSSL_USE_STATIC_LIBS=TRUE
    -DCMAKE_C_FLAGS=-DOPENSSL_NO_ENGINE
    "-DZLIB_LIBRARY=${CMAKE_CURRENT_BINARY_DIR}/zlib/libz.a"
    "-DZLIB_INCLUDE_DIR=${COCOS_EXTERNAL_ROOT}/zlib"
    -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DBUILD_STATIC_CURL=ON
    -DBUILD_LIBCURL_DOCS=OFF -DBUILD_MISC_DOCS=OFF
    -DBUILD_CURL_EXE=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF
    -DCURL_BUILD_TESTING=OFF -DCURL_DISABLE_INSTALL=ON
    -DCURL_ENABLE_SSL=ON -DCURL_USE_OPENSSL=ON -DCURL_ZLIB=ON
    -DCURL_BROTLI=OFF -DCURL_ZSTD=OFF -DUSE_NGHTTP2=OFF
    -DUSE_LIBIDN2=OFF -DCURL_USE_LIBPSL=OFF -DCURL_USE_GSSAPI=OFF
    -DCURL_DISABLE_LDAP=ON -DCURL_DISABLE_LDAPS=ON
    -DCURL_USE_LIBSSH2=OFF -DCURL_USE_LIBSSH=OFF
)
if(MACOSX)
    list(APPEND _cocos_curl_cmake_args
        "-DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}"
        "-DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}"
    )
elseif(ANDROID)
    list(APPEND _cocos_curl_cmake_args
        "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}"
        "-DANDROID_ABI=${ANDROID_ABI}"
        "-DANDROID_PLATFORM=${ANDROID_PLATFORM}"
        "-DANDROID_STL=${ANDROID_STL}"
    )
endif()
ExternalProject_Add(cocos_curl
    DEPENDS cocos_openssl zlibstatic
    SOURCE_DIR "${COCOS_EXTERNAL_ROOT}/curl"
    BINARY_DIR "${_cocos_curl_binary_dir}/build"
    CMAKE_ARGS ${_cocos_curl_cmake_args}
    INSTALL_COMMAND ""
    BUILD_BYPRODUCTS "${_cocos_curl_archive}"
)
set(_cocos_curl_link_libraries
    OpenSSL::SSL OpenSSL::Crypto zlibstatic
)
if(MACOSX)
    list(APPEND _cocos_curl_link_libraries
        "-framework SystemConfiguration"
        "-framework CoreFoundation"
        "-framework CoreServices"
    )
endif()
add_library(ext_curl STATIC IMPORTED GLOBAL)
set_target_properties(ext_curl PROPERTIES
    IMPORTED_LOCATION "${_cocos_curl_archive}"
    INTERFACE_INCLUDE_DIRECTORIES "${COCOS_EXTERNAL_ROOT}/curl/include"
    INTERFACE_LINK_LIBRARIES "${_cocos_curl_link_libraries}"
)
add_dependencies(ext_curl cocos_curl)
target_include_directories(ext_curl INTERFACE "${COCOS_EXTERNAL_ROOT}/curl/include")
add_dependencies(external cocos_openssl cocos_curl)
