import processing.sound.*;

SoundFile sample;
Amplitude analysis;

void setup() {
  size(640, 480);
 
  // load and play a sound file in a loop
  sample = new SoundFile(this, "beat.aiff");
  sample.loop();

  // create the Amplitude analysis object
  analysis = new Amplitude(this);
  // analyze the playing sound file
  analysis.input(sample);
}

void draw() {
  println(analysis.analyze());
  background(125, 255, 125);
  noStroke();
  fill(255, 0, 150);

  // analyze the audio for its volume level
  float volume = analysis.analyze();

  // volume is a number between 0.0 and 1.0
  // map the volume value to a useful scale
  float diameter = map(volume, 0, 1, 0, width);
  // draw a circle based on the microphone amplitude (volume)
  circle(width/2, height/2, diameter);
}
