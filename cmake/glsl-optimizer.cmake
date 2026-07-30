# Copyright (c) 2026 Shivpratap Chauhan <shivmsit@gmail.com>
# SPDX-License-Identifier: MIT

set(glsl_optimizer_source_dir "${COCOS_EXTERNAL_ROOT}/glsl-optimizer")

file(GLOB glcpp_library_sources
    "${glsl_optimizer_source_dir}/src/glsl/glcpp/*.c"
    "${glsl_optimizer_source_dir}/src/util/*.c"
)

file(GLOB mesa_sources
    "${glsl_optimizer_source_dir}/src/mesa/program/*.c"
    "${glsl_optimizer_source_dir}/src/mesa/main/*.c"
)

file(GLOB glsl_optimizer_sources
    "${glsl_optimizer_source_dir}/src/glsl/*.cpp"
    "${glsl_optimizer_source_dir}/src/glsl/*.c"
)
list(REMOVE_ITEM glsl_optimizer_sources
    "${glsl_optimizer_source_dir}/src/glsl/main.cpp"
    "${glsl_optimizer_source_dir}/src/glsl/builtin_stubs.cpp"
)

add_library(ext_glcpp_library STATIC ${glcpp_library_sources})
add_library(ext_libmesa STATIC ${mesa_sources})
add_library(ext_glsl_optimizer STATIC ${glsl_optimizer_sources})

set(glsl_optimizer_private_includes
    "${glsl_optimizer_source_dir}/include"
    "${glsl_optimizer_source_dir}/src"
    "${glsl_optimizer_source_dir}/src/glsl"
    "${glsl_optimizer_source_dir}/src/mapi"
    "${glsl_optimizer_source_dir}/src/mesa"
)

target_include_directories(ext_glcpp_library PRIVATE
    ${glsl_optimizer_private_includes}
)
target_include_directories(ext_libmesa PRIVATE
    ${glsl_optimizer_private_includes}
)
target_include_directories(ext_glsl_optimizer
    PUBLIC
        "${glsl_optimizer_source_dir}/include"
        "${glsl_optimizer_source_dir}/src/glsl"
    PRIVATE ${glsl_optimizer_private_includes}
)

target_link_libraries(ext_glsl_optimizer PUBLIC
    ext_glcpp_library
    ext_libmesa
)

set_target_properties(
    ext_glcpp_library
    ext_libmesa
    ext_glsl_optimizer
    PROPERTIES FOLDER "External"
)

unset(glsl_optimizer_private_includes)
unset(glsl_optimizer_source_dir)
