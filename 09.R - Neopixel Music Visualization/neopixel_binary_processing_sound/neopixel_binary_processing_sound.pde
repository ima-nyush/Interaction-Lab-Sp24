import processing.serial.*;
import processing.sound.*;

Serial serialPort;
SoundFile sound;

int NUM_LEDS = 60;                   // How many LEDs in your strip?
color[] leds = new color[NUM_LEDS];  // array of one color for each pixel

void setup() {
  size(900, 600);
  frameRate(30);

  printArray(Serial.list());
  // put the name of the serial port your Arduino is connected
  // to in the line below - this should be the same as you're
  // using in the "Port" menu in the Arduino IDE
  serialPort = new Serial(this, "/dev/tty.usbmodem1101", 115200);

  println("Loading mp3...");
  sound = new SoundFile(this, "song.mp3");
  sound.loop();
}

void draw() {
  background(0);

  // to demonstrate how to control the Neopixel strips from Processing,
  // this will draw a simple progress bar - in sync with the playback
  // you want to build on that, but come up with your very own audio
  // visualization

  float progress = sound.position() / sound.duration();
  println(progress);                   // find out where we are in the song (0.0-1.0)

  for (int i=0; i < NUM_LEDS; i++) {   // loop through each pixel in the strip
    if (i < progress * NUM_LEDS) {     // based on where we are in the song
      leds[i] = color(255, 0, 0);      // turn a pixel to red
    } else {
      leds[i] = color(0, 0, 0);        // or to black
    }
  }


  // you can use sound.position() to create a different animation
  // for different parts of the song, e.g.

  // if (sound.position() < 5) {
  //
  // } else if (sound.position() < 10) {
  //
  // }

  sendColors();                        // send the array of colors to Arduino
}



// the helper function below sends the colors
// in the "leds" array to a connected Arduino
// running the "neopixel_binary_arduino" sketch

void sendColors() {
  byte[] out = new byte[NUM_LEDS*3];
  for (int i=0; i < NUM_LEDS; i++) {
    out[i*3]   = (byte)(floor(red(leds[i])) >> 1);
    if (i == 0) {
      out[0] |= 1 << 7;
    }
    out[i*3+1] = (byte)(floor(green(leds[i])) >> 1);
    out[i*3+2] = (byte)(floor(blue(leds[i])) >> 1);
  }
  serialPort.write(out);
}
