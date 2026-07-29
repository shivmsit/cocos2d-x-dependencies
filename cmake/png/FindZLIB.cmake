# libpng's upstream CMake calls find_package(ZLIB).  Keep it bound to Cocos'
# source-built zlib instead of accidentally selecting a host installation.
if(NOT TARGET zlibstatic)
  message(FATAL_ERROR "Cocos libpng requires the zlibstatic target")
endif()

if(NOT TARGET ZLIB::ZLIB)
  add_library(ZLIB::ZLIB ALIAS zlibstatic)
endif()

# zlibstatic's INTERFACE_INCLUDE_DIRECTORIES contains CMake generator
# expressions, which cannot be passed to libpng's configure-time probes.
get_filename_component(_cocos_external_dir "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)
set(_cocos_zlib_include_dir "${_cocos_external_dir}/zlib")
set(ZLIB_FOUND TRUE)
set(ZLIB_VERSION_STRING "1.3.2")
set(ZLIB_LIBRARIES ZLIB::ZLIB)
set(ZLIB_INCLUDE_DIR "${_cocos_zlib_include_dir}" CACHE PATH "" FORCE)
set(ZLIB_INCLUDE_DIRS "${_cocos_zlib_include_dir}")
unset(_cocos_zlib_include_dir)
unset(_cocos_external_dir)
