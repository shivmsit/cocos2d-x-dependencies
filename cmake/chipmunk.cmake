# Build Chipmunk from the vendored upstream source instead of importing a
# platform archive.  Cocos uses the static runtime only.
set(BUILD_DEMOS OFF CACHE BOOL "" FORCE)
set(INSTALL_DEMOS OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED OFF CACHE BOOL "" FORCE)
set(BUILD_STATIC ON CACHE BOOL "" FORCE)
set(INSTALL_STATIC OFF CACHE BOOL "" FORCE)
set(FORCE_CLANG_BLOCKS OFF CACHE BOOL "" FORCE)

add_subdirectory("${COCOS_EXTERNAL_ROOT}/chipmunk" "${CMAKE_CURRENT_BINARY_DIR}/chipmunk")

# Cocos2d-x 3.17's existing physics code and legacy Chipmunk archive use
# float-based cpVect values.  Upstream 7.0.3 otherwise auto-selects Cocoa
# CGPoint/double values on macOS, changing the ABI of Chipmunk APIs that pass
# vectors by value.  Keep the historical ABI across the engine and consumers.
target_compile_definitions(chipmunk_static PUBLIC
    CP_USE_CGTYPES=0
    CP_USE_DOUBLES=0
)

add_library(ext_chipmunk INTERFACE)
target_link_libraries(ext_chipmunk INTERFACE chipmunk_static)
target_include_directories(ext_chipmunk INTERFACE
    "${COCOS_EXTERNAL_ROOT}/chipmunk/include"
)
target_compile_definitions(ext_chipmunk INTERFACE
    CP_USE_CGTYPES=0
    CP_USE_DOUBLES=0
)
