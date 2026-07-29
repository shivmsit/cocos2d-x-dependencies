# libwebp is built from the pinned upstream source in this directory.  Cocos
# only decodes WebP images, so leave command-line tools, mux/demux support and
# examples out of every platform prebuilt.
set(WEBP_BUILD_ANIM_UTILS OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_CWEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_DWEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_GIF2WEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_IMG2WEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_VWEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_WEBPINFO OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_LIBWEBPMUX OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_WEBPMUX OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_EXTRAS OFF CACHE BOOL "" FORCE)

add_subdirectory("${COCOS_EXTERNAL_ROOT}/webp"
                 "${CMAKE_CURRENT_BINARY_DIR}/webp")

# Cocos 3.17 historically includes WebP's public headers as <decode.h>,
# whereas upstream exports them below src/webp. Keep that include contract for
# engine code and prebuilt consumers without carrying copied platform headers.
add_library(ext_webp INTERFACE)
target_link_libraries(ext_webp INTERFACE webpdecoder)
target_include_directories(ext_webp INTERFACE
    "${COCOS_EXTERNAL_ROOT}/webp/src/webp"
)
