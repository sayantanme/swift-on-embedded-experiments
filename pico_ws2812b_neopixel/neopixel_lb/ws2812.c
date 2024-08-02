

#include <stdio.h>
#include <stdlib.h>

#include "pico/stdlib.h"
#include "hardware/pio.h"
#include "hardware/clocks.h"
#include "ws2812.pio.h"
#include "ws2812.h"

#define IS_RGBW false
#define NUM_PIXELS 60
#define RED 0
#define GREEN 1
#define BLUE 2

uint8_t pixelBuffer[NUM_PIXELS][3];
uint8_t totalNumberOfPixels = NUM_PIXELS;
float brightnessVal = 0.5;

void put_pixel(uint32_t pixel_grb) {
    pio_sm_put_blocking(pio0, 0, pixel_grb << 8u);
}

uint32_t urgb_u32(uint8_t r, uint8_t g, uint8_t b) {
    return
            ((uint32_t) (r) << 8) |
            ((uint32_t) (g) << 16) |
            (uint32_t) (b);
}

void setupWS2812B(uint8_t numberOfPixels, uint pin, float freq, float brightness) {
    printf("WS2812 Smoke Test, using pin %d", pin);
    // todo get free sm
    PIO pio = pio0;
    int sm = 0;
    brightnessVal = brightness;
    totalNumberOfPixels = numberOfPixels;
    uint offset = pio_add_program(pio, &ws2812_program);

    ws2812_program_init(pio, sm, offset, pin, freq, IS_RGBW);

    for(uint8_t i = 0 ; i < numberOfPixels; i++) {
        pixelBuffer[i][RED] = 0;
        pixelBuffer[i][GREEN] = 0;
        pixelBuffer[i][BLUE] = 0;
    }
}

void pixelFill(uint8_t red, uint8_t green, uint8_t blue, bool autoshow) {
    for(uint8_t i = 0; i < totalNumberOfPixels; i++) {
        pixelBuffer[i][RED] = red;
        pixelBuffer[i][GREEN] = green;
        pixelBuffer[i][BLUE] = blue;

    }

    if (autoshow) {
        show();
    }
}

void pixelSetValue( uint8_t pixel, uint8_t red, uint8_t green, uint8_t blue, bool autoshow) {
    for(uint8_t i = 0; i < totalNumberOfPixels; i++) {
        pixelBuffer[pixel][RED] = red;
        pixelBuffer[pixel][GREEN] = green;
        pixelBuffer[pixel][BLUE] = blue;
    }

    if (autoshow) {
        show();
    }
}

void clear(bool autoshow) {
    for(uint8_t i = 0; i < totalNumberOfPixels; i++) {
        pixelBuffer[i][RED] = 0;
        pixelBuffer[i][GREEN] = 0;
        pixelBuffer[i][BLUE] = 0;
    }

    if (autoshow) {
        show();
    }
}

void show() {
    for(uint8_t i = 0 ; i < totalNumberOfPixels; i++) {
        put_pixel(urgb_u32(
            pixelBuffer[i][RED] * brightnessVal,
            pixelBuffer[i][GREEN] * brightnessVal,
            pixelBuffer[i][BLUE] * brightnessVal
        ));
        // printf("in i %d: color: R: %d, G: %d, B: %d \n", i, pixelBuffer[i][RED], 
        //         pixelBuffer[i][GREEN], pixelBuffer[i][BLUE]);
        sleep_ms(0.01);
     }
}
