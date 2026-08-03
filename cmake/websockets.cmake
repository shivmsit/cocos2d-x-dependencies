# libwebsockets probes generated OpenSSL headers, so configure it at build
# time after the engine-owned OpenSSL and libuv static archives are ready.
if(WIN32)
    set(LWS_WITH_SHARED OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_STATIC ON CACHE BOOL "" FORCE)
    set(LWS_WITHOUT_TESTAPPS ON CACHE BOOL "" FORCE)
    set(LWS_WITHOUT_EXTENSIONS ON CACHE BOOL "" FORCE)
    # Schannel's backend provides both client and server entry points in the
    # same source files, so keep server symbols enabled even though Cocos only
    # creates client connections.
    set(LWS_WITHOUT_SERVER OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_SSL ON CACHE BOOL "" FORCE)
    set(LWS_WITH_SCHANNEL ON CACHE BOOL "" FORCE)
    set(LWS_WITH_LIBUV OFF CACHE BOOL "" FORCE)
    set(LWS_ROLE_H1 ON CACHE BOOL "" FORCE)
    set(LWS_ROLE_WS ON CACHE BOOL "" FORCE)
    set(LWS_ROLE_H2 OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_HTTP2 OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_HTTP3 OFF CACHE BOOL "" FORCE)
    set(LWS_ROLE_MQTT OFF CACHE BOOL "" FORCE)
    set(LWS_ROLE_QUIC OFF CACHE BOOL "" FORCE)
    set(LWS_ROLE_RAW_FILE OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_SECURE_STREAMS OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_UPNG OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_JPEG OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_DLO OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_GZINFLATE OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_ZLIB OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_CGI OFF CACHE BOOL "" FORCE)
    set(LWS_WITH_SPAWN OFF CACHE BOOL "" FORCE)
    set(DISABLE_WERROR ON CACHE BOOL "" FORCE)

    add_subdirectory("${COCOS_EXTERNAL_ROOT}/websockets"
                     "${CMAKE_CURRENT_BINARY_DIR}/websockets")
    set_target_properties(websockets PROPERTIES FOLDER "External")

    add_library(ext_websockets INTERFACE)
    target_link_libraries(ext_websockets INTERFACE websockets)
    target_include_directories(ext_websockets INTERFACE
        "${COCOS_EXTERNAL_ROOT}/websockets/include"
        "${CMAKE_CURRENT_BINARY_DIR}/websockets")
    return()
endif()

include(ExternalProject)
set(_cocos_lws_binary_dir "${CMAKE_CURRENT_BINARY_DIR}/websockets")
set(_cocos_lws_archive "${_cocos_lws_binary_dir}/build/lib/libwebsockets.a")
set(_cocos_lws_cmake_args
    "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
    -DCMAKE_NO_SYSTEM_FROM_IMPORTED=ON
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
elseif(IOS)
    list(APPEND _cocos_lws_cmake_args
        -DCMAKE_SYSTEM_NAME=iOS
        "-DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}"
        "-DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}"
        "-DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}"
    )
endif()
set(_cocos_lws_generator_args)
if(IOS)
    set(_cocos_lws_generator_args CMAKE_GENERATOR "Unix Makefiles")
endif()
ExternalProject_Add(cocos_websockets
    DEPENDS cocos_openssl uv_a
    SOURCE_DIR "${COCOS_EXTERNAL_ROOT}/websockets"
    BINARY_DIR "${_cocos_lws_binary_dir}/build"
    ${_cocos_lws_generator_args}
    CMAKE_ARGS ${_cocos_lws_cmake_args}
    INSTALL_COMMAND ""
    BUILD_BYPRODUCTS "${_cocos_lws_archive}"
)
set(_cocos_lws_link_libraries
    OpenSSL::SSL OpenSSL::Crypto ext_uv
)
if(APPLE)
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
