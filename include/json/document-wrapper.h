#pragma once

// Keep Cocos2d-x's long-standing include entry point. The GCC 4.9 ARM
// workaround is retained for projects that still target that toolchain.
#include <rapidjson/rapidjson.h>

#if defined(__arm__) && defined(RAPIDJSON_GNUC) && RAPIDJSON_GNUC >= RAPIDJSON_VERSION_CODE(4,9,0) && RAPIDJSON_GNUC < RAPIDJSON_VERSION_CODE(5,0,0)
    #pragma GCC optimize ("O1")
#endif
#include <rapidjson/document.h>
#if defined(__arm__) && defined(RAPIDJSON_GNUC) && RAPIDJSON_GNUC >= RAPIDJSON_VERSION_CODE(4,9,0) && RAPIDJSON_GNUC < RAPIDJSON_VERSION_CODE(5,0,0)
    #pragma GCC reset_options
#endif
