import processing.sound.*;

// declare a SoundFile object
SoundFile sound;

void setup() {
  size(640, 480);
  // create the instance and load its data from a file
  sound = new SoundFile(this, "cello-f2.aif");
}

void draw() {
  background(0);
}

void mouseClicked() {
  // when the mouse is clicked, use mouseX to determine the pitch
  // toward left is lower pitched, toward the right is higher pitched
  float pitch = map(mouseX, 0, width, 0.1, 5);
  // use mouseY to determine the volume
  // toward the top is louder volume, toward the bottom is softer volume
  float vol = map(mouseY, 0, height, 1, 0);
  // set the playback rate for the soundfile
  sound.rate(pitch);
  // set the amplitude for the soundfile
  sound.amp(vol);
  // play the sound once, with pitch and amplitude
  sound.play();

  // can also be written with parameters for the play() method
  // sound.play(pitch, vol);
}
