# FreeType's upstream CMake invokes find_package(ZLIB).  Resolve it to the
# zlib built in this same Cocos build instead of consulting the host SDK.
if(NOT TARGET zlibstatic)
  message(FATAL_ERROR "Cocos FreeType requires the zlibstatic target")
endif()

if(NOT TARGET ZLIB::ZLIB)
  add_library(ZLIB::ZLIB ALIAS zlibstatic)
endif()

set(ZLIB_FOUND TRUE)
set(ZLIB_VERSION_STRING "1.3.2")
set(ZLIB_LIBRARIES ZLIB::ZLIB)
