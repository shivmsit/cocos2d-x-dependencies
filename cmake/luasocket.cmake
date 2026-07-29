set(_cocos_luasocket_source_dir "${COCOS_EXTERNAL_ROOT}/luasocket")
set(_cocos_luasocket_sources
    buffer.c
    io.c
    timeout.c
    select.c
    udp.c
    mime.c
    tcp.c
    auxiliar.c
    inet.c
    luasocket.c
    luasocket_scripts.c
    except.c
    options.c
)

if(WINDOWS)
    list(APPEND _cocos_luasocket_sources wsocket.c)
else()
    list(APPEND _cocos_luasocket_sources unix.c usocket.c serial.c)
endif()

set(_cocos_luasocket_source_paths)
foreach(_cocos_luasocket_source IN LISTS _cocos_luasocket_sources)
    list(APPEND _cocos_luasocket_source_paths
        "${_cocos_luasocket_source_dir}/${_cocos_luasocket_source}")
endforeach()

add_library(ext_luasocket STATIC ${_cocos_luasocket_source_paths})

if(LINUX)
    target_compile_definitions(ext_luasocket PRIVATE _GNU_SOURCE)
endif()

target_include_directories(ext_luasocket INTERFACE
    "${COCOS_EXTERNAL_ROOT}")
target_link_libraries(ext_luasocket PRIVATE ext_luajit)

set_target_properties(ext_luasocket PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    FOLDER "External"
)

unset(_cocos_luasocket_source_dir)
unset(_cocos_luasocket_source)
unset(_cocos_luasocket_source_paths)
unset(_cocos_luasocket_sources)
