add_library(ext_poly2tri STATIC "${COCOS_EXTERNAL_ROOT}/poly2tri/common/shapes.cc" "${COCOS_EXTERNAL_ROOT}/poly2tri/sweep/sweep.cc" "${COCOS_EXTERNAL_ROOT}/poly2tri/sweep/sweep_context.cc" "${COCOS_EXTERNAL_ROOT}/poly2tri/sweep/cdt.cc" "${COCOS_EXTERNAL_ROOT}/poly2tri/sweep/advancing_front.cc")
target_include_directories(ext_poly2tri
    PUBLIC "${COCOS_EXTERNAL_ROOT}/poly2tri")
