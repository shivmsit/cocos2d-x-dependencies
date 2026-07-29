set(LIBUV_BUILD_SHARED OFF CACHE BOOL "" FORCE)
set(LIBUV_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(LIBUV_BUILD_BENCH OFF CACHE BOOL "" FORCE)
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
add_subdirectory("${COCOS_EXTERNAL_ROOT}/uv" "${CMAKE_CURRENT_BINARY_DIR}/uv")

add_library(ext_uv INTERFACE)
target_link_libraries(ext_uv INTERFACE uv_a)
target_include_directories(ext_uv INTERFACE "${COCOS_EXTERNAL_ROOT}/uv/include")
