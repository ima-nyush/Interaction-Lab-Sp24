import processing.sound.*;

// declare a SoundFile object
SoundFile sound;

void setup() {
  size(640, 480);
  // create the instance and load its data from a file
  sound = new SoundFile(this, "Submarine.aiff");
  // play the sound on loop
  sound.loop();
}

void draw() {
  background(0);
}
