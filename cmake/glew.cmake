# Copyright (c) 2026 Shivpratap Chauhan <shivmsit@gmail.com>
# SPDX-License-Identifier: MIT

add_library(glew STATIC
    "${COCOS_EXTERNAL_ROOT}/glew/src/glew.c"
)
target_compile_definitions(glew
    PUBLIC GLEW_STATIC
    PRIVATE WIN32_LEAN_AND_MEAN
)
target_include_directories(glew
    PUBLIC "${COCOS_EXTERNAL_ROOT}/glew/include"
)
target_link_libraries(glew PUBLIC opengl32)
set_target_properties(glew PROPERTIES FOLDER "External")

add_library(ext_glew ALIAS glew)
