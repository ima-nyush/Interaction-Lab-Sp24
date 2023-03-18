import processing.sound.*;

// declare three SoundFile objects
SoundFile kick;
SoundFile snare;
SoundFile hihat;

void setup() {
  size(640, 480);
  // create the objects and load sounds into them
  kick = new SoundFile(this, "kick.wav");
  snare = new SoundFile(this, "snare.wav");
  hihat = new SoundFile(this, "hihat.aif");
}

void draw() {
  background(0);
}

void keyPressed() {
  // when a key is pressed, use a switch statement
  // to determine which key was pressed
  // and play the appropriate sound file and set a background color
  switch(key) {
  case 'k':
    kick.play();
    background(255, 0, 0);
    break;
  case 's':
    snare.play();
    background(0, 255, 0);
    break;
  case 'h':
    hihat.play();
    background(0, 0, 255);
    break;
  }
}
