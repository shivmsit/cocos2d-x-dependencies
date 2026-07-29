# Cocos2d-x dependency sources

This repository contains the pinned third-party source trees and CMake
integration used by the maintained Cocos2d-x engine.

The engine checks out this repository as its `external/` submodule. Normal
engine, application, and prebuilt-library builds use these local sources and
do not download dependencies while configuring or compiling.

Each dependency keeps its upstream license and notices. Exact source
revisions, supported feature groups, and Cocos2d-x-specific adjustments are
recorded in [SOURCES.md](SOURCES.md).

Release tags correspond to the Cocos2d-x release whose dependency set was
validated, for example `cocos2d-x-3.18.0`.
