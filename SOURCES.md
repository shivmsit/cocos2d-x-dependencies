# Dependency source revisions

This file records the exact source represented by every dependency directory.
Update the corresponding entry in the same commit that imports or updates a
source tree.

| Dependency | Directory | Version | Revision | Official source | License | Required by | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| zlib | `zlib` | `1.3.2` | `da607da739fa6047df13e66a2af6b8bec7c2a498` | https://github.com/madler/zlib | Zlib | Core compression, PNG, TIFF, curl | Upstream examples, tests, contributed tools, and generated documentation omitted. |
| Independent JPEG Group JPEG | `jpeg` | `10` | `sha256:8b9eaa13242690ebd03e1728ab1edf97a81a78ed6e83624d493655f31ac95ab5` | https://www.ijg.org/files/jpegsrc.v10.tar.gz | IJG | Image decoding, TIFF | Complete official source archive; Cocos generates `jconfig.h` out of tree. |
| libpng | `png` | `1.6.58` | `3061454d980de7d53608f594194cfac722721d2a` | https://github.com/pnggroup/libpng | libpng-2.0 | PNG image decoding | Tests, examples, contributed tools, CI files, and generated manuals omitted. |
| FreeType | `freetype` | `2.14.3` | `0a0221a1347e2f1e07c395263540026e9a0aa7c7` | https://gitlab.freedesktop.org/freetype/freetype | FreeType | Font rendering | Documentation, development helpers, tests, and optional subprojects omitted. |
| GLFW | `glfw` | `3.4` | `7b6aead9fb88b3623e3b3725ebb42670cbe4c579` | https://github.com/glfw/glfw | Zlib | Desktop window, input, and OpenGL context support | Examples, tests, documentation, CI files, and development-only dependencies omitted. |
| libwebp | `webp` | `1.6.0` | `4fa21912338357f89e4fd51cf2368325b59e9bd9` | https://chromium.googlesource.com/webm/libwebp | BSD-3-Clause | WebP image decoding | Tests, tools, examples, JavaScript builds, Gradle files, and generated documentation omitted. |
| libtiff | `tiff` | `4.7.2` | `d01a94be176f5f6a87f7ee1c0b32e65416aa2b4d` | https://gitlab.com/libtiff/libtiff | libtiff | TIFF image decoding | Tests, command-line tools, contributed code, archives, and generated documentation omitted. |
| Bullet | `bullet` | `3.25` | `2c204c49e56ed15ec5fcfa71d199ab6d6570b3f5` | https://github.com/bulletphysics/bullet3 | Zlib | 3D physics | Examples, data, documentation, tests, Bullet 3 extras, and generated build trees omitted; Cocos uses the Bullet 2 API. |
| Box2D | `Box2D` | `3.1.1` | `8c661469c9507d3ad6fbd2fea3f1aa71669c2fe3` | https://github.com/erincatto/box2d | MIT | Optional 2D physics | Samples, benchmarks, tests, documentation, and CI files omitted. |
| Chipmunk2D | `chipmunk` | `7.0.3` | `87340c216bf97554dc552371bbdecf283f7c540e` | https://github.com/slembcke/Chipmunk2D | MIT | Optional 2D physics | Demos, documentation, tests, IDE projects, Objective-C bindings, and release tools omitted; Cocos portability guard applied in a follow-up commit. |
| Recast Navigation | `recast` | `1.6.0` | `6dc1667f580357e8a2154c28b7867bea7e8ad3a7` | https://github.com/recastnavigation/recastnavigation | Zlib | Navigation meshes and crowds | Demo, tests, generated documentation, and CI files omitted; Cocos off-mesh animation accessor applied in a follow-up commit. |
| FastLZ | `fastlz` | Recast `1.6.0` snapshot | `6dc1667f580357e8a2154c28b7867bea7e8ad3a7` | https://github.com/recastnavigation/recastnavigation/tree/v1.6.0/RecastDemo/Contrib/fastlz | MIT | Bundle3D compression | Preserved from the Recast 1.6.0 FastLZ contribution. |
| RapidJSON | `json` | `main` snapshot | `24b5e7a8b27f42fa16b96fc70aade9106cf7102f` | https://github.com/Tencent/rapidjson | MIT | JSON parsing and serialization | Tests, examples, generated documentation, binaries, and CI assets omitted. |
| tinyxml2 | `tinyxml2` | `main` snapshot | `8224e427b655b83dae5e2298f1e6919523a78737` | https://github.com/leethomason/tinyxml2 | Zlib | XML parsing | Tests, examples, images, contributed files, and generated documentation omitted. |
| tinydir | `tinydir` | `master` snapshot | `a4a2db51af5fd5146eb1d7bcc72610c7bfa28ebb` | https://github.com/cxong/tinydir | BSD-2-Clause | Windows directory traversal | Tests and samples omitted. |
| xxHash | `xxhash` | `0.8.3` | `e626a72bc2321cd320e953a0ccf1584cad60f363` | https://github.com/Cyan4973/xxHash | BSD-2-Clause | Fast hashing | Tests, command-line tools, fuzzing assets, and generated documentation omitted. |
| Clipper2 | `clipper` | `main` snapshot | `f9c5eb6e14a59f6f5d65fbfb3564519a561cf4fd` | https://github.com/AngusJohnson/Clipper2 | BSL-1.0 | Polygon clipping and triangulation | Official C++ library, license, and README retained; other language ports, examples, benchmarks, and tests omitted. |
| OpenSSL | `openssl` | `4.0.1` | `1e963a8680ec78ad2072792c7a1a71f3c530bd2e` | https://github.com/openssl/openssl | Apache-2.0 | TLS and cryptography | Tests, fuzzers, demos, generated documentation, and CI files omitted; source and Configure support retained for macOS and Android. |
| curl | `curl` | `8.21.0` | `68720b4837284335b2d63cb358f8f6ce65f5bc55` | https://github.com/curl/curl | curl | HTTP transfer support | Tests, IDE projects, generated documentation, and CI files omitted; command-line client source retained as upstream build metadata. |
| libuv | `uv` | `1.52.1` | `1cfa32ff59c076ffb6ed735bbc8c18361558661f` | https://github.com/libuv/libuv | MIT | WebSocket event loop | Tests, images, generated documentation, and CI files omitted. |
