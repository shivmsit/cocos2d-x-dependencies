# Build the official libpng source locally.  libpng's CMake configuration is
# retained upstream; this file only selects the Cocos dependency graph.
set(png_source_dir "${COCOS_EXTERNAL_ROOT}/png")

if(NOT TARGET zlibstatic)
  message(FATAL_ERROR "libpng requires the source-built zlib target")
endif()

# libpng calls find_package(ZLIB).  Resolve it to the zlib built by this
# CMake invocation, never to a host SDK or package-manager installation.
set(png_cmake_module_dir "${CMAKE_CURRENT_LIST_DIR}/png")
list(PREPEND CMAKE_MODULE_PATH "${png_cmake_module_dir}")

set(PNG_SHARED OFF CACHE BOOL "" FORCE)
set(PNG_STATIC ON CACHE BOOL "" FORCE)
set(PNG_FRAMEWORK OFF CACHE BOOL "" FORCE)
set(PNG_TESTS OFF CACHE BOOL "" FORCE)
set(PNG_TOOLS OFF CACHE BOOL "" FORCE)
set(SKIP_INSTALL_ALL ON CACHE BOOL "" FORCE)

add_subdirectory("${png_source_dir}" "${CMAKE_CURRENT_BINARY_DIR}/png")

list(REMOVE_ITEM CMAKE_MODULE_PATH "${png_cmake_module_dir}")

set_target_properties(png_static PROPERTIES FOLDER "External")
add_library(ext_png ALIAS png_static)

unset(png_cmake_module_dir)
unset(png_source_dir)
