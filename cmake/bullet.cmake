# Bullet is vendored in its upstream source layout.  Cocos uses the mature
# Bullet 2 collision/dynamics API; demos, Python bindings, Bullet 3/OpenCL and
# extras are deliberately not part of the engine dependency.
# Bullet 3.25 predates CMake 4.  Keep its upstream CMakeLists pristine while
# explicitly selecting the compatibility policy level required by CMake 4.
set(CMAKE_POLICY_VERSION_MINIMUM 3.5 CACHE STRING "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(USE_MSVC_RUNTIME_LIBRARY_DLL ON CACHE BOOL "" FORCE)
set(USE_DOUBLE_PRECISION OFF CACHE BOOL "" FORCE)
set(USE_GRAPHICAL_BENCHMARK OFF CACHE BOOL "" FORCE)
set(BULLET2_MULTITHREADING OFF CACHE BOOL "" FORCE)
set(BUILD_BULLET3 OFF CACHE BOOL "" FORCE)
set(BUILD_PYBULLET OFF CACHE BOOL "" FORCE)
set(BUILD_ENET OFF CACHE BOOL "" FORCE)
set(BUILD_CLSOCKET OFF CACHE BOOL "" FORCE)
set(BUILD_OPENGL3_DEMOS OFF CACHE BOOL "" FORCE)
set(BUILD_BULLET2_DEMOS OFF CACHE BOOL "" FORCE)
set(BUILD_EXTRAS OFF CACHE BOOL "" FORCE)
set(BUILD_UNIT_TESTS OFF CACHE BOOL "" FORCE)
set(INSTALL_LIBS OFF CACHE BOOL "" FORCE)

add_subdirectory("${COCOS_EXTERNAL_ROOT}/bullet" "${CMAKE_CURRENT_BINARY_DIR}/bullet")

add_library(ext_bullet INTERFACE)
target_link_libraries(ext_bullet INTERFACE BulletDynamics BulletCollision LinearMath)
target_include_directories(ext_bullet INTERFACE "${COCOS_EXTERNAL_ROOT}/bullet/src")
