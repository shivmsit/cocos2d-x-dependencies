add_library(ext_xxhash STATIC "${COCOS_EXTERNAL_ROOT}/xxhash/xxhash.c")
target_include_directories(ext_xxhash PUBLIC "${COCOS_EXTERNAL_ROOT}/xxhash")
