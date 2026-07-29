# Dependency source revisions

This file records the exact source represented by every dependency directory.
Update the corresponding entry in the same commit that imports or updates a
source tree.

| Dependency | Directory | Version | Revision | Official source | License | Required by | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| zlib | `zlib` | `1.3.2` | `da607da739fa6047df13e66a2af6b8bec7c2a498` | https://github.com/madler/zlib | Zlib | Core compression, PNG, TIFF, curl | Upstream examples, tests, contributed tools, and generated documentation omitted. |
| Independent JPEG Group JPEG | `jpeg` | `10` | `sha256:8b9eaa13242690ebd03e1728ab1edf97a81a78ed6e83624d493655f31ac95ab5` | https://www.ijg.org/files/jpegsrc.v10.tar.gz | IJG | Image decoding, TIFF | Complete official source archive; Cocos generates `jconfig.h` out of tree. |
| libpng | `png` | `1.6.58` | `3061454d980de7d53608f594194cfac722721d2a` | https://github.com/pnggroup/libpng | libpng-2.0 | PNG image decoding | Tests, examples, contributed tools, CI files, and generated manuals omitted. |
