set(lib_name glfw3)
set(target_name ext_${lib_name})
set(glfw_source_dir "${COCOS_EXTERNAL_ROOT}/glfw")

include("${CMAKE_CURRENT_LIST_DIR}/CocosExternalConfig.cmake")

if(IOS OR ANDROID)
  message(FATAL_ERROR "GLFW is not used on iOS or Android")
endif()

# GLFW 3.4 is vendored in src/ and built from source.  Disable every GLFW
# consumer/install target: Cocos only needs the static window/input library.
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(GLFW_LIBRARY_TYPE STATIC CACHE STRING "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_INSTALL OFF CACHE BOOL "" FORCE)

# Keep the previous desktop coverage.  Wayland is disabled for now because the
# old Cocos desktop backend is X11-based; it can be enabled in a later Linux
# migration together with runtime platform selection.
if(MACOSX)
  set(GLFW_BUILD_COCOA ON CACHE BOOL "" FORCE)
elseif(WINDOWS)
  set(GLFW_BUILD_WIN32 ON CACHE BOOL "" FORCE)
elseif(LINUX)
  set(GLFW_BUILD_X11 ON CACHE BOOL "" FORCE)
  set(GLFW_BUILD_WAYLAND OFF CACHE BOOL "" FORCE)
endif()

add_subdirectory("${glfw_source_dir}" "${CMAKE_CURRENT_BINARY_DIR}/glfw")

# Cocos 3.17 historically includes <glfw3.h> and <glfw3native.h>, whereas
# upstream GLFW exposes them as <GLFW/glfw3.h>.  Export both include layouts
# during the transition; this avoids touching platform code in this migration.
target_include_directories(glfw INTERFACE "${glfw_source_dir}/include/GLFW")
set_target_properties(glfw PROPERTIES FOLDER "External")
add_library(${target_name} ALIAS glfw)

unset(glfw_source_dir)
