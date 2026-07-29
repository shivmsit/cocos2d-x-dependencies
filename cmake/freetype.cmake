set(lib_name freetype)
set(target_name ext_${lib_name})
set(freetype_source_dir "${COCOS_EXTERNAL_ROOT}/freetype")

include("${CMAKE_CURRENT_LIST_DIR}/CocosExternalConfig.cmake")

if(NOT TARGET zlibstatic)
  message(FATAL_ERROR "FreeType requires the source-built zlib target")
endif()

# FreeType must use the zlib migrated with Cocos, never a host SDK copy.
# Its upstream CMake calls find_package(ZLIB), so shadow CMake's system module
# with the small resolver checked in next to this integration layer.
set(freetype_cmake_module_dir "${CMAKE_CURRENT_LIST_DIR}/freetype")
list(PREPEND CMAKE_MODULE_PATH "${freetype_cmake_module_dir}")

# Keep the first source-built font profile deliberately small and portable.
# PNG bitmap fonts, bzip2 fonts, WOFF2/Brotli, and HarfBuzz are optional
# features that will be enabled only after their source dependencies migrate.
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(FT_REQUIRE_ZLIB ON CACHE BOOL "" FORCE)
set(FT_DISABLE_BZIP2 ON CACHE BOOL "" FORCE)
set(FT_DISABLE_PNG ON CACHE BOOL "" FORCE)
set(FT_DISABLE_HARFBUZZ ON CACHE BOOL "" FORCE)
set(FT_DISABLE_BROTLI ON CACHE BOOL "" FORCE)
set(SKIP_INSTALL_ALL ON CACHE BOOL "" FORCE)

add_subdirectory("${freetype_source_dir}" "${CMAKE_CURRENT_BINARY_DIR}/freetype")

list(REMOVE_ITEM CMAKE_MODULE_PATH "${freetype_cmake_module_dir}")

set_target_properties(freetype PROPERTIES FOLDER "External")
add_library(${target_name} ALIAS freetype)

unset(freetype_source_dir)
unset(freetype_cmake_module_dir)
