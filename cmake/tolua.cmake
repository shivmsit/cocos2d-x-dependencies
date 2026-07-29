set(_cocos_tolua_source_dir "${COCOS_EXTERNAL_ROOT}/tolua")

add_library(ext_tolua STATIC
    "${_cocos_tolua_source_dir}/tolua_event.c"
    "${_cocos_tolua_source_dir}/tolua_is.c"
    "${_cocos_tolua_source_dir}/tolua_map.c"
    "${_cocos_tolua_source_dir}/tolua_push.c"
    "${_cocos_tolua_source_dir}/tolua_to.c"
)

target_include_directories(ext_tolua PUBLIC "${_cocos_tolua_source_dir}")
target_link_libraries(ext_tolua PRIVATE ext_luajit)

set_target_properties(ext_tolua PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    FOLDER "External"
)

unset(_cocos_tolua_source_dir)
