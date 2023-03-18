import processing.sound.*;

// declare a SoundFile object
SoundFile sound;

int radius = 100;
// boolean to make sure the sound only plays once
boolean playSound = true;

void setup() {
  size(640, 480);
  // create the instance and load its data from a file
  sound = new SoundFile(this, "isthatyou.aiff");
}

void draw() {
  background(0);
  circle(width/2, height/2, radius*2);

  // when the mouse is over the circle
  if (dist(width/2, height/2, mouseX, mouseY) < radius) {
    // if the playSound boolean is set to true
    if (playSound == true) {
      // play the sound
      sound.play();
      // and prevent it from playing again by setting the boolean to false
      playSound = false;
    }
    fill(200, 0, 100);
  } else {
    // if the mouse is outside the circle, make the sound playable again
    // by setting the boolean to true
    playSound = true;
    fill(255);
  }
}
