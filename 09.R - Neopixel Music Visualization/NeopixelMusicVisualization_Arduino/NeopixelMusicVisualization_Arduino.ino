/* This is a code example for Arduino, to be used on Recitation 7
  You need to have  installed SerialRecord and FastLED libraries.
  It requires NeoPixel WS2812 at pin 3
  Interaction Lab
  IMA NYU Shanghai
  2022 Fall
*/
 
#include "SerialRecord.h"
#include <FastLED.h>

#define NUM_LEDS 60  // How many leds in your strip?
#define DATA_PIN 3   // Which pin are you connecting Arduino to Data In?
CRGB leds[NUM_LEDS];

// Change this number to the number of values you want to receive
SerialRecord reader(4);

void setup() {
 Serial.begin(9600);
 FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);  // Initialize 
 FastLED.setBrightness(10); // BEWARE: external power for full (255)
 //further info at https://learn.adafruit.com/adafruit-neopixel-uberguide/powering-neopixels
}


void loop() {
 if (reader.read()) {
   int n = reader[0];
   int r = reader[1];
   int g = reader[2];
   int b = reader[3];

   leds[reader[0]] = CRGB(reader[1], reader[2], reader[3]);  //  Prepare the color information using CRGB( Red, Green, Blue
   FastLED.show();  //  Pass the information of color to the LED
 }
}

