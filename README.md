# Cocos2d-x Dependencies

This repository contains the third-party source code used by the maintained
Cocos2d-x 3.x engine. The engine includes it as the `external/` Git submodule
and pins the exact commit to use.

Dependencies are built with the engine toolchain. No precompiled dependency
archive or configuration-time download is required.

## Get the sources

Clone Cocos2d-x with its submodules:

```sh
git clone --recursive --branch v3.18 \
  https://github.com/shivmsit/cocos2d-x.git
```

For an existing checkout:

```sh
git submodule update --init --recursive
```

Most users do not need to clone or build this repository separately.

## Source policy

Sources come from the original projects and are pinned to documented releases
or commits. Required source, headers, build files and license notices are kept.
Upstream tests, examples, documentation, CI files and precompiled binaries may
be removed when Cocos2d-x does not use them.

Project links, exact revisions, licenses and Cocos2d-x usage are listed in
[SOURCES.md](SOURCES.md).

## Platform status

| Target | Dependency source build |
| --- | --- |
| macOS | Supported |
| Android with the NDK | Supported |
| Windows | Not tested |
| Linux | Not tested |
| iOS | Not tested |

CMake attempts to use the available source integrations on untested platforms
and skips integrations that are currently platform-specific.
