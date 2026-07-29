# Cocos NavMesh uses FastLZ for Detour tile-cache compression.  The exact
# source is vendored from RecastNavigation v1.6.0's RecastDemo contribution.
add_library(ext_fastlz STATIC "${COCOS_EXTERNAL_ROOT}/fastlz/fastlz.c")
target_include_directories(ext_fastlz PUBLIC "${COCOS_EXTERNAL_ROOT}/fastlz")

set_target_properties(ext_fastlz PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    FOLDER "External"
)
