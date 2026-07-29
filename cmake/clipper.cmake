add_library(ext_clipper STATIC "${COCOS_EXTERNAL_ROOT}/clipper/src/clipper.engine.cpp" "${COCOS_EXTERNAL_ROOT}/clipper/src/clipper.offset.cpp" "${COCOS_EXTERNAL_ROOT}/clipper/src/clipper.rectclip.cpp" "${COCOS_EXTERNAL_ROOT}/clipper/src/clipper.triangulation.cpp")
target_include_directories(ext_clipper PUBLIC "${COCOS_EXTERNAL_ROOT}/clipper/include")
target_compile_features(ext_clipper PUBLIC cxx_std_17)
