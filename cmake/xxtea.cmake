add_library(ext_xxtea STATIC "${COCOS_EXTERNAL_ROOT}/xxtea/xxtea.cpp")
target_include_directories(ext_xxtea PUBLIC "${COCOS_EXTERNAL_ROOT}/xxtea")
