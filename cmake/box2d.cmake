# Build Box2D from the vendored official v3 source. The public API is the
# upstream handle-based C API exposed by <box2d/box2d.h>.
set(BOX2D_SAMPLES OFF CACHE BOOL "" FORCE)
set(BOX2D_BENCHMARKS OFF CACHE BOOL "" FORCE)
set(BOX2D_DOCS OFF CACHE BOOL "" FORCE)
set(BOX2D_UNIT_TESTS OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)

add_subdirectory("${COCOS_EXTERNAL_ROOT}/Box2D" "${CMAKE_CURRENT_BINARY_DIR}/box2d")

add_library(ext_box2d INTERFACE)
target_link_libraries(ext_box2d INTERFACE box2d)
target_include_directories(ext_box2d INTERFACE
    "${COCOS_EXTERNAL_ROOT}/Box2D/include"
)
