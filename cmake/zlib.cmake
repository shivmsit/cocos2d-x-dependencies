set(lib_name zlib)
set(target_name ext_${lib_name})
set(zlib_source_dir "${COCOS_EXTERNAL_ROOT}/zlib")

include("${CMAKE_CURRENT_LIST_DIR}/CocosExternalConfig.cmake")

# Cocos links zlib statically.  Do not build zlib's tools, tests, shared
# library, or installation rules as part of an engine/prebuilt build.
set(ZLIB_BUILD_TESTING OFF CACHE BOOL "" FORCE)
set(ZLIB_BUILD_SHARED OFF CACHE BOOL "" FORCE)
set(ZLIB_BUILD_STATIC ON CACHE BOOL "" FORCE)
set(ZLIB_INSTALL OFF CACHE BOOL "" FORCE)

add_subdirectory("${zlib_source_dir}" "${CMAKE_CURRENT_BINARY_DIR}/zlib")

set_target_properties(zlibstatic PROPERTIES FOLDER "External")
add_library(${target_name} ALIAS zlibstatic)

unset(zlib_source_dir)
