add_library(neopixel_lb INTERFACE)
target_sources(neopixel_lb INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/ws2812.c)

# invoke pio_asm to assemble the state machine programs
#
pico_generate_pio_header(neopixel_lb ${CMAKE_CURRENT_LIST_DIR}/ws2812.pio)

pico_enable_stdio_usb(neopixel_lb 1)

target_link_libraries(neopixel_lb INTERFACE
        pico_stdlib
        hardware_pio
        )

# add the `binary` directory so that the generated headers are included in the project
#
target_include_directories(neopixel_lb INTERFACE
	${CMAKE_CURRENT_SOURCE_DIR}
	${CMAKE_CURRENT_BINARY_DIR}
	)
