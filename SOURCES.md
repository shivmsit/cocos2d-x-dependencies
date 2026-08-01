# Dependency Sources

This manifest identifies the source and version of every library in this
repository. Revision links point to the exact imported commit; abbreviated
hashes are shown to keep the page readable.

The [source policy](README.md#source-policy) explains what is
retained from original projects and which development-only files are removed.

## Graphics, fonts and image formats

| Dependency | Project source | Imported version | Used for | License |
| --- | --- | --- | --- | --- |
| [GLFW](glfw/) | [glfw/glfw](https://github.com/glfw/glfw) | [3.4 · `7b6aead9fb88`](https://github.com/glfw/glfw/tree/7b6aead9fb88b3623e3b3725ebb42670cbe4c579) | Desktop windows, input and OpenGL contexts | Zlib |
| [GLEW](glew/) | [nigels-com/glew](https://github.com/nigels-com/glew) | [2.3.1 source release](https://github.com/nigels-com/glew/releases/tag/glew-2.3.1) | Windows OpenGL function loading | Modified BSD, MIT |
| [FreeType](freetype/) | [freetype/freetype](https://gitlab.freedesktop.org/freetype/freetype) | [2.14.3 · `0a0221a1347e`](https://gitlab.freedesktop.org/freetype/freetype/-/tree/0a0221a1347e2f1e07c395263540026e9a0aa7c7) | Font rendering | FreeType |
| [IJG JPEG](jpeg/) | [Independent JPEG Group](https://www.ijg.org/) | [10 source archive](https://www.ijg.org/files/jpegsrc.v10.tar.gz) | JPEG decoding and TIFF support | IJG |
| [libpng](png/) | [pnggroup/libpng](https://github.com/pnggroup/libpng) | [1.6.58 · `3061454d980d`](https://github.com/pnggroup/libpng/tree/3061454d980de7d53608f594194cfac722721d2a) | PNG decoding | libpng-2.0 |
| [libwebp](webp/) | [WebM libwebp](https://chromium.googlesource.com/webm/libwebp) | [1.6.0 · `4fa219123383`](https://chromium.googlesource.com/webm/libwebp/+/4fa21912338357f89e4fd51cf2368325b59e9bd9) | WebP decoding | BSD-3-Clause |
| [libtiff](tiff/) | [libtiff/libtiff](https://gitlab.com/libtiff/libtiff) | [4.7.2 · `d01a94be176f`](https://gitlab.com/libtiff/libtiff/-/tree/d01a94be176f5f6a87f7ee1c0b32e65416aa2b4d) | TIFF decoding | libtiff |
| [GLSL Optimizer](glsl-optimizer/) | [cocos2d/glsl-optimizer](https://github.com/cocos2d/glsl-optimizer) | [`23f7d591a575`](https://github.com/cocos2d/glsl-optimizer/tree/23f7d591a57599883cf08840be0057974dd08afe) | GLSL-to-Metal shader translation | MIT |

## Compression and core utilities

| Dependency | Project source | Imported version | Used for | License |
| --- | --- | --- | --- | --- |
| [zlib](zlib/) | [madler/zlib](https://github.com/madler/zlib) | [1.3.2 · `da607da739fa`](https://github.com/madler/zlib/tree/da607da739fa6047df13e66a2af6b8bec7c2a498) | Core compression, PNG, TIFF and curl | Zlib |
| [xxHash](xxhash/) | [Cyan4973/xxHash](https://github.com/Cyan4973/xxHash) | [0.8.3 · `e626a72bc232`](https://github.com/Cyan4973/xxHash/tree/e626a72bc2321cd320e953a0ccf1584cad60f363) | Fast hashing | BSD-2-Clause |
| [tinydir](tinydir/) | [cxong/tinydir](https://github.com/cxong/tinydir) | [`a4a2db51af5f`](https://github.com/cxong/tinydir/tree/a4a2db51af5fd5146eb1d7bcc72610c7bfa28ebb) | Windows directory traversal | BSD-2-Clause |
| [ConvertUTF](ConvertUTF/) | [Cocos2d-x dependency bundle](https://github.com/cocos2d/cocos2d-x) | 3.17 snapshot | UTF conversion | UIUC / Unicode notice |
| [edtaa3func](edtaa3func/) | [Cocos2d-x dependency bundle](https://github.com/cocos2d/cocos2d-x) | 3.17 snapshot | Signed-distance-field font generation | MIT |
| [MD5](md5/) | [Cocos2d-x dependency bundle](https://github.com/cocos2d/cocos2d-x) | 3.17 snapshot | Utility hashes | Aladdin permissive |
| [minizip unzip](unzip/) | [Cocos2d-x dependency bundle](https://github.com/cocos2d/cocos2d-x) | 3.17 snapshot | ZIP file support | Zlib |
| [xxtea](xxtea/) | [Cocos2d-x dependency bundle](https://github.com/cocos2d/cocos2d-x) | 3.17 snapshot | Optional XXTEA encryption | Custom permissive |

## Physics, geometry and navigation

| Dependency | Project source | Imported version | Used for | License |
| --- | --- | --- | --- | --- |
| [Box2D](Box2D/) | [erincatto/box2d](https://github.com/erincatto/box2d) | [3.1.1 · `8c661469c950`](https://github.com/erincatto/box2d/tree/8c661469c9507d3ad6fbd2fea3f1aa71669c2fe3) | Optional 2D physics | MIT |
| [Chipmunk2D](chipmunk/) | [slembcke/Chipmunk2D](https://github.com/slembcke/Chipmunk2D) | [7.0.3 · `87340c216bf9`](https://github.com/slembcke/Chipmunk2D/tree/87340c216bf97554dc552371bbdecf283f7c540e) | Optional 2D physics | MIT |
| [Bullet](bullet/) | [bulletphysics/bullet3](https://github.com/bulletphysics/bullet3) | [3.25 · `2c204c49e56e`](https://github.com/bulletphysics/bullet3/tree/2c204c49e56ed15ec5fcfa71d199ab6d6570b3f5) | 3D physics through the Bullet 2 API | Zlib |
| [Recast Navigation](recast/) | [recastnavigation/recastnavigation](https://github.com/recastnavigation/recastnavigation) | [1.6.0 · `6dc1667f5803`](https://github.com/recastnavigation/recastnavigation/tree/6dc1667f580357e8a2154c28b7867bea7e8ad3a7) | Navigation meshes and crowds | Zlib |
| [FastLZ](fastlz/) | [Recast contribution](https://github.com/recastnavigation/recastnavigation) | [1.6.0 snapshot](https://github.com/recastnavigation/recastnavigation/tree/6dc1667f580357e8a2154c28b7867bea7e8ad3a7/RecastDemo/Contrib/fastlz) | Bundle3D compression | MIT |
| [Clipper2](clipper/) | [AngusJohnson/Clipper2](https://github.com/AngusJohnson/Clipper2) | [`f9c5eb6e14a5`](https://github.com/AngusJohnson/Clipper2/tree/f9c5eb6e14a59f6f5d65fbfb3564519a561cf4fd) | Polygon clipping and triangulation | BSL-1.0 |
| [poly2tri](poly2tri/) | [Cocos2d-x dependency bundle](https://github.com/cocos2d/cocos2d-x) | 3.17 snapshot | Polygon triangulation | BSD-3-Clause |

## Networking and security

| Dependency | Project source | Imported version | Used for | License |
| --- | --- | --- | --- | --- |
| [OpenSSL](openssl/) | [openssl/openssl](https://github.com/openssl/openssl) | [4.0.1 · `1e963a8680ec`](https://github.com/openssl/openssl/tree/1e963a8680ec78ad2072792c7a1a71f3c530bd2e) | TLS and cryptography | Apache-2.0 |
| [curl](curl/) | [curl/curl](https://github.com/curl/curl) | [8.21.0 · `68720b483728`](https://github.com/curl/curl/tree/68720b4837284335b2d63cb358f8f6ce65f5bc55) | HTTP transfer support | curl |
| [libuv](uv/) | [libuv/libuv](https://github.com/libuv/libuv) | [1.52.1 · `1cfa32ff59c0`](https://github.com/libuv/libuv/tree/1cfa32ff59c076ffb6ed735bbc8c18361558661f) | WebSocket event loop | MIT |
| [libwebsockets](websockets/) | [warmcat/libwebsockets](https://github.com/warmcat/libwebsockets) | [`fd1e670ea3f2`](https://github.com/warmcat/libwebsockets/tree/fd1e670ea3f20859592c5ea2321560e1d37444c0) | WebSocket client support | MIT |

## Audio

| Dependency | Project source | Imported version | Used for | License |
| --- | --- | --- | --- | --- |
| [miniaudio](miniaudio/) | [mackron/miniaudio](https://github.com/mackron/miniaudio) | [0.11.25 · `9634bedb5b5a`](https://github.com/mackron/miniaudio/tree/9634bedb5b5a2ca38c1ee7108a9358a4e233f14d) | Desktop audio playback and decoding | Public Domain or MIT-0 |
| [stb_vorbis](stb/) | [nothings/stb](https://github.com/nothings/stb) | [`31c1ad374564`](https://github.com/nothings/stb/tree/31c1ad37456438565541f4919958214b6e762fb4) | Ogg Vorbis decoding for miniaudio | Public Domain or MIT |

## Data formats and Lua runtime

| Dependency | Project source | Imported version | Used for | License |
| --- | --- | --- | --- | --- |
| [RapidJSON](json/) | [Tencent/rapidjson](https://github.com/Tencent/rapidjson) | [`24b5e7a8b27f`](https://github.com/Tencent/rapidjson/tree/24b5e7a8b27f42fa16b96fc70aade9106cf7102f) | JSON parsing and serialization | MIT |
| [tinyxml2](tinyxml2/) | [leethomason/tinyxml2](https://github.com/leethomason/tinyxml2) | [`8224e427b655`](https://github.com/leethomason/tinyxml2/tree/8224e427b655b83dae5e2298f1e6919523a78737) | XML parsing | Zlib |
| [FlatBuffers](flatbuffers/) | [google/flatbuffers](https://github.com/google/flatbuffers) | Cocos-compatible 1.0.0 snapshot | Cocos Studio binary data | Apache-2.0 |
| [LuaJIT](luajit/) | [LuaJIT/LuaJIT](https://github.com/LuaJIT/LuaJIT) | [2.1 rolling · `2460b3ff93a1`](https://github.com/LuaJIT/LuaJIT/tree/2460b3ff93a1c955de3d62cfc825de7d68dc272e) | Lua 5.1-compatible runtime and JIT | MIT |
| [tolua++](tolua/) | [LuaDist/toluapp](https://github.com/LuaDist/toluapp) | [1.0.93 · `9feb31ab8b97`](https://github.com/LuaDist/toluapp/tree/9feb31ab8b97eda9561846508ee9e3a2caff8da7) | C++ Lua bindings | MIT |
| [LuaSocket](luasocket/) | [lunarmodules/luasocket](https://github.com/lunarmodules/luasocket) | [3.0-rc1 · `22cd5833fcc0`](https://github.com/lunarmodules/luasocket/tree/22cd5833fcc0e272f26004a79c8545e959ba406b) | Lua networking | MIT |

## Android components

| Dependency | Project source | Imported version | Used for | License |
| --- | --- | --- | --- | --- |
| [PacketVideo MP3 decoder](android-specific/pvmp3dec/) | [Android Open Source Project](https://android.googlesource.com/platform/external/opencore/) | Cocos-compatible OpenCORE snapshot | Android MP3 decoding | Apache-2.0 |
| [Tremolo](android-specific/tremolo/) | [Xiph Tremolo](https://wiki.xiph.org/Tremolo) | 0.07 with Android fixes | Android Ogg Vorbis decoding | BSD |
| Android CPU features | [Android NDK](https://github.com/android/ndk) | Selected NDK release | Android CPU feature detection | Apache-2.0 |

The CPU-features wrapper compiles the implementation supplied by the selected
Android NDK. Its source is not duplicated in this repository.

## Important integration notes

* The GLEW 2.3.1 source archive is verified with SHA-256
  `b64790f94b926acd7e8f84c5d6000a86cb43967bd1e688b03089079799c9e889`.
* The IJG JPEG 10 archive is verified with SHA-256
  `8b9eaa13242690ebd03e1728ab1edf97a81a78ed6e83624d493655f31ac95ab5`.
* Box2D's reusable car and donut components are retained because Cocos2d-x
  builds them as part of `cpp-tests`; the standalone Box2D sample application
  and its large data set are omitted.
* OpenSSL keeps the documentation and build metadata parsed by `Configure`,
  even though documentation, demos, fuzzers, tests and applications are not
  built.
* Chipmunk2D, Recast, RapidJSON, tolua++ and LuaSocket have small
  Cocos2d-x-specific compatibility commits after their original source import.
* FlatBuffers remains at the historical Cocos-compatible revision because
  generated Cocos Studio headers depend on that API.
* ConvertUTF, edtaa3func, MD5, poly2tri, minizip unzip, xxtea and the Android
  audio decoders are preserved from the final Cocos2d-x 3.17 dependency
  bundle when a suitable modern replacement was not part of this release.

Update this manifest in the same commit that imports or changes a dependency
revision.
