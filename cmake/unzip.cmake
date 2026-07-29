add_library(ext_unzip STATIC "${COCOS_EXTERNAL_ROOT}/unzip/ioapi.cpp" "${COCOS_EXTERNAL_ROOT}/unzip/unzip.cpp" "${COCOS_EXTERNAL_ROOT}/unzip/ioapi_mem.cpp")
target_include_directories(ext_unzip PUBLIC "${COCOS_EXTERNAL_ROOT}/unzip")
target_link_libraries(ext_unzip PRIVATE zlibstatic)
