import processing.serial.*;
import processing.sound.*;

Serial serialPort;
SoundFile sound;

int NUM_LEDS = 60;                    // How many LEDs in your strip?
color[] strip = new color[NUM_LEDS];  // array of one color for each pixel

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
      strip[i] = color(255, 0, 0);     // turn a pixel on
    } else {
      strip[i] = color(0);             // or off
    }
  }

  // example for a different mode

  if (sound.position() > 5 && sound.position() < 7) {
    for (int i=0; i < NUM_LEDS; i++) {
      strip[i] = lerpColor(color(255, 0, 0), color(0, 0, 255), map(sound.position(), 5, 7, 0, 1));
    }
  }

  sendColors();                        // send the array of colors to Arduino
}



// the helper function below sends the colors
// in the "strip" array to a connected Arduino
// running the "neopixel_binary_arduino" sketch

void sendColors() {
  byte[] out = new byte[NUM_LEDS*3];
  for (int i=0; i < NUM_LEDS; i++) {
    out[i*3]   = (byte)(floor(red(strip[i])) >> 1);
    if (i == 0) {
      out[0] |= 1 << 7;
    }
    out[i*3+1] = (byte)(floor(green(strip[i])) >> 1);
    out[i*3+2] = (byte)(floor(blue(strip[i])) >> 1);
  }
  serialPort.write(out);
}
