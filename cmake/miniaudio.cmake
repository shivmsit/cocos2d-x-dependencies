# Copyright (c) 2026 Shivpratap Chauhan <shivmsit@gmail.com>
# SPDX-License-Identifier: MIT

set(lib_name miniaudio)
set(target_name ext_${lib_name})
set(miniaudio_source_dir "${COCOS_EXTERNAL_ROOT}/miniaudio")

find_package(Threads REQUIRED)

add_library(${target_name} STATIC
    "${miniaudio_source_dir}/miniaudio.c"
)

target_include_directories(${target_name} PUBLIC
    "${miniaudio_source_dir}"
)

target_link_libraries(${target_name} PUBLIC
    Threads::Threads
    ${CMAKE_DL_LIBS}
    m
)
