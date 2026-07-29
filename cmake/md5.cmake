add_library(ext_md5 STATIC "${COCOS_EXTERNAL_ROOT}/md5/md5.c")
target_include_directories(ext_md5 PUBLIC "${COCOS_EXTERNAL_ROOT}/md5")
