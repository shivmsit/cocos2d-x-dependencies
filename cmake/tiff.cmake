# Build only libtiff's runtime library from pinned upstream source.  Its
# Deflate and JPEG codecs bind to Cocos' source-built zlib and IJG JPEG
# targets through the local Find modules.
set(_tiff_cmake_module_path "${CMAKE_MODULE_PATH}")
list(PREPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/tiff")

set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(tiff-static ON CACHE BOOL "" FORCE)
set(tiff-cxx OFF CACHE BOOL "" FORCE)
set(tiff-tools OFF CACHE BOOL "" FORCE)
set(tiff-tests OFF CACHE BOOL "" FORCE)
set(tiff-contrib OFF CACHE BOOL "" FORCE)
set(tiff-docs OFF CACHE BOOL "" FORCE)
set(tiff-install OFF CACHE BOOL "" FORCE)
set(zlib ON CACHE BOOL "" FORCE)
set(libdeflate OFF CACHE BOOL "" FORCE)
set(pixarlog ON CACHE BOOL "" FORCE)
set(jpeg ON CACHE BOOL "" FORCE)
set(jpeg-prefer-standard ON CACHE BOOL "" FORCE)
set(old-jpeg OFF CACHE BOOL "" FORCE)
set(jpeg12 OFF CACHE BOOL "" FORCE)
# The Cocos IJG JPEG target is an 8-bit build.  Do not let libtiff's probe
# pick up a host libjpeg-turbo header exposing its optional 12-bit API.
set(HAVE_JPEGTURBO_DUAL_MODE_8 OFF CACHE BOOL "" FORCE)
set(HAVE_JPEGTURBO_DUAL_MODE_12 OFF CACHE BOOL "" FORCE)
set(HAVE_JPEGTURBO_DUAL_MODE_8_12 OFF CACHE BOOL "" FORCE)
set(jbig OFF CACHE BOOL "" FORCE)
set(lerc OFF CACHE BOOL "" FORCE)
set(lzma OFF CACHE BOOL "" FORCE)
set(zstd OFF CACHE BOOL "" FORCE)
set(webp OFF CACHE BOOL "" FORCE)

add_subdirectory("${COCOS_EXTERNAL_ROOT}/tiff"
                 "${CMAKE_CURRENT_BINARY_DIR}/tiff")
set(CMAKE_MODULE_PATH "${_tiff_cmake_module_path}")
unset(_tiff_cmake_module_path)

add_library(ext_tiff INTERFACE)
target_link_libraries(ext_tiff INTERFACE TIFF::tiff)
target_include_directories(ext_tiff INTERFACE
    "${COCOS_EXTERNAL_ROOT}/tiff/libtiff"
    "${CMAKE_CURRENT_BINARY_DIR}/tiff/libtiff"
)
