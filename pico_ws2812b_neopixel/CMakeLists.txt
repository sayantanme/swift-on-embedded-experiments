cmake_minimum_required(VERSION 3.13)
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(pico_ws2812b_neopixel)
pico_sdk_init()

execute_process(COMMAND xcrun -f swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)

add_executable(pico_ws2812b_neopixel)

##file(MAKE_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/Generated)
##pico_generate_pio_header(pico_ws2812b_neopixel ${CMAKE_CURRENT_LIST_DIR}/ws2812.pio)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    COMMAND
        ${SWIFTC}
        -target armv6m-none-none-eabi -Xcc -mfloat-abi=soft -Xcc -fshort-enums
        -Xfrontend -function-sections -enable-experimental-feature Embedded -wmo -parse-as-library
        $$\( echo '$<TARGET_PROPERTY:pico_ws2812b_neopixel,INCLUDE_DIRECTORIES>' | tr '\;' '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        $$\( echo '${CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES}'             | tr ' '  '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        -import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
        ${CMAKE_CURRENT_LIST_DIR}/LEDStrip.swift
        ${CMAKE_CURRENT_LIST_DIR}/Colors.swift
        -c -o ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    DEPENDS
        ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
        ${CMAKE_CURRENT_LIST_DIR}/LEDStrip.swift
        ${CMAKE_CURRENT_LIST_DIR}/Colors.swift
)
add_custom_target(pico_ws2812b_neopixel-swiftcode DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o)

pico_enable_stdio_usb(pico_ws2812b_neopixel 1)

add_subdirectory(neopixel_lb)

target_link_libraries(pico_ws2812b_neopixel
    pico_stdlib hardware_uart hardware_gpio hardware_pio neopixel_lb
    ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
)
add_dependencies(pico_ws2812b_neopixel pico_ws2812b_neopixel-swiftcode)
pico_add_extra_outputs(pico_ws2812b_neopixel)
