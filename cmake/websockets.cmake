# libwebsockets probes generated OpenSSL headers, so configure it at build
# time after the engine-owned OpenSSL and libuv static archives are ready.
include(ExternalProject)
set(_cocos_lws_binary_dir "${CMAKE_CURRENT_BINARY_DIR}/websockets")
set(_cocos_lws_archive "${_cocos_lws_binary_dir}/build/lib/libwebsockets.a")
set(_cocos_lws_cmake_args
    "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
    "-DCMAKE_PREFIX_PATH=${COCOS_OPENSSL_STAGE_DIR}"
    "-DOPENSSL_ROOT_DIR=${COCOS_OPENSSL_STAGE_DIR}"
    "-DOPENSSL_INCLUDE_DIR=${COCOS_OPENSSL_STAGE_DIR}/include"
    "-DOPENSSL_CRYPTO_LIBRARY=${COCOS_OPENSSL_STAGE_DIR}/lib/libcrypto.a"
    "-DOPENSSL_SSL_LIBRARY=${COCOS_OPENSSL_STAGE_DIR}/lib/libssl.a"
    -DOPENSSL_USE_STATIC_LIBS=TRUE
    -DLWS_WITH_SHARED=OFF -DLWS_WITH_STATIC=ON
    -DLWS_WITHOUT_TESTAPPS=ON -DLWS_WITHOUT_EXTENSIONS=ON
    -DLWS_WITH_SSL=ON -DLWS_WITH_LIBUV=ON
    -DLWS_ROLE_H1=ON -DLWS_ROLE_WS=ON -DLWS_ROLE_H2=OFF
    -DLWS_ROLE_MQTT=OFF -DLWS_ROLE_QUIC=OFF -DLWS_ROLE_RAW_FILE=OFF
    -DLWS_WITH_HTTP2=OFF -DLWS_WITH_HTTP3=OFF -DLWS_WITHOUT_SERVER=ON
    "-DLWS_LIBUV_LIBRARIES=${CMAKE_CURRENT_BINARY_DIR}/uv/libuv.a"
    "-DLWS_LIBUV_INCLUDE_DIRS=${COCOS_EXTERNAL_ROOT}/uv/include"
)
if(MACOSX)
    list(APPEND _cocos_lws_cmake_args
        "-DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}"
    )
elseif(ANDROID)
    list(APPEND _cocos_lws_cmake_args
        "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}"
        "-DANDROID_ABI=${ANDROID_ABI}"
        "-DANDROID_PLATFORM=${ANDROID_PLATFORM}"
        "-DANDROID_STL=${ANDROID_STL}"
    )
endif()
ExternalProject_Add(cocos_websockets
    DEPENDS cocos_openssl uv_a
    SOURCE_DIR "${COCOS_EXTERNAL_ROOT}/websockets"
    BINARY_DIR "${_cocos_lws_binary_dir}/build"
    CMAKE_ARGS ${_cocos_lws_cmake_args}
    INSTALL_COMMAND ""
    BUILD_BYPRODUCTS "${_cocos_lws_archive}"
)
set(_cocos_lws_link_libraries
    OpenSSL::SSL OpenSSL::Crypto ext_uv
)
if(MACOSX)
    list(APPEND _cocos_lws_link_libraries
        "-framework Security"
        "-framework CoreFoundation"
    )
endif()
add_library(ext_websockets STATIC IMPORTED GLOBAL)
set_target_properties(ext_websockets PROPERTIES
    IMPORTED_LOCATION "${_cocos_lws_archive}"
    INTERFACE_INCLUDE_DIRECTORIES "${COCOS_EXTERNAL_ROOT}/websockets/include;${_cocos_lws_binary_dir}/build"
    INTERFACE_COMPILE_DEFINITIONS LWS_WITH_LIBUV
    INTERFACE_LINK_LIBRARIES "${_cocos_lws_link_libraries}"
)
add_dependencies(ext_websockets cocos_websockets)
add_dependencies(external cocos_websockets)
