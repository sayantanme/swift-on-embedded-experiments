#ifndef WS2812_H_   /* Include guard */
#define WS2812_H_

void setupWS2812B(uint8_t numberOfPixels, uint pin, float freq, float brightness);
void put_pixel(uint32_t pixel_grb);
uint32_t urgb_u32(uint8_t r, uint8_t g, uint8_t b);

void pixelFill(uint8_t red, uint8_t green, uint8_t blue, bool autoshow);
void pixelSetValue( uint8_t pixel, uint8_t red, uint8_t green, uint8_t blue, bool autoshow);

void show();
void clear(bool autoshow);

#endif