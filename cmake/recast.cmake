# Build RecastNavigation's runtime modules from the vendored upstream source.
# Cocos NavMesh does not need the standalone demo, examples, or upstream unit
# tests as part of an engine build.
# RecastNavigation 1.6.0 predates CMake 4's minimum policy compatibility.
set(CMAKE_POLICY_VERSION_MINIMUM 3.5 CACHE STRING "" FORCE)
set(RECASTNAVIGATION_DEMO OFF CACHE BOOL "" FORCE)
set(RECASTNAVIGATION_TESTS OFF CACHE BOOL "" FORCE)
set(RECASTNAVIGATION_EXAMPLES OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)

add_subdirectory("${COCOS_EXTERNAL_ROOT}/recast" "${CMAKE_CURRENT_BINARY_DIR}/recast")

add_library(ext_recast INTERFACE)
target_link_libraries(ext_recast INTERFACE
    DebugUtils
    DetourCrowd
    DetourTileCache
    Detour
    Recast
    ext_fastlz
)
