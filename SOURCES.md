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
