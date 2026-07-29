add_library(ext_convertUTF STATIC "${COCOS_EXTERNAL_ROOT}/ConvertUTF/ConvertUTF.c" "${COCOS_EXTERNAL_ROOT}/ConvertUTF/ConvertUTFWrapper.cpp")
target_include_directories(ext_convertUTF PUBLIC "${COCOS_EXTERNAL_ROOT}/ConvertUTF")
