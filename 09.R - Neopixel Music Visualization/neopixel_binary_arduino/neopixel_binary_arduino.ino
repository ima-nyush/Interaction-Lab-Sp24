/**
 * This Arduino sketch receives pixel data from Processing in a very
 * efficient way (as "binary data") and sends it to a NeoPixel strip
 * You'll need to have the FastLED library installed, and a NeoPixel
 * strip connected to pin 3.
 * IMA at NYU Shanghai, Spring 2023
 */

#include <FastLED.h>

int NUM_LEDS = 60;   // How many LEDs in your strip?
int DATA_PIN = 3;    // Which pin is connected to the strip's DIN?

CRGB leds[NUM_LEDS];
int next_led = 0;    // 0..NUM_LEDS-1
int next_col = 0;    // 0..2
byte next_rgb[3];    // temporary storage for next color

void setup() {
  Serial.begin(115200);
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
  FastLED.setBrightness(10);  // external 5V needed for full brightness
  leds[0] = CRGB::Red;
  FastLED.show();
  delay(1000);
  leds[0] = CRGB::Black;
  FastLED.show();
}

void loop() {
  while (Serial.available()) {
    char in = Serial.read();
    if (in & 0x80) {
      // synchronization: now comes the first color of the first LED
      next_led = 0;
      next_col = 0;
    }
    if (next_led < NUM_LEDS) {
      next_rgb[next_col] = in << 1;
      next_col++;
      if (next_col == 3) {
        leds[next_led] = CRGB(next_rgb[0], next_rgb[1], next_rgb[2]);
        next_led++;
        next_col = 0;
      }
    }
    if (next_led == NUM_LEDS) {
      FastLED.show();
      next_led++;
    }
  }
}
