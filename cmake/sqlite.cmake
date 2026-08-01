# Copyright (c) 2026 Shivpratap Chauhan <shivmsit@gmail.com>
# SPDX-License-Identifier: MIT

set(target_name ext_sqlite)
set(sqlite_source_dir "${COCOS_EXTERNAL_ROOT}/sqlite")

add_library(${target_name} STATIC
    "${sqlite_source_dir}/sqlite3.c"
)

target_include_directories(${target_name} PUBLIC
    "${sqlite_source_dir}"
)

target_compile_definitions(${target_name} PRIVATE
    SQLITE_OMIT_LOAD_EXTENSION
)

if(NOT WIN32)
    find_package(Threads REQUIRED)
    target_link_libraries(${target_name} PUBLIC
        Threads::Threads
        ${CMAKE_DL_LIBS}
    )
endif()

set_target_properties(${target_name} PROPERTIES FOLDER "External")
