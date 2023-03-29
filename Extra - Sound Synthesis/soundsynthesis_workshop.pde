import processing.sound.*;
int amount = 50;
SinOsc[] sine = new SinOsc[amount];
Env[] envelope = new Env[amount];
float[] x = new float[amount];
float[] y = new float[amount];
float[] size = new float[amount];
float[] speed = new float[amount];
float[] freq = new float[amount];
void setup() {
  size(360, 640);
  
  for(int i=0; i<amount; i++) {
    sine[i] = new SinOsc(this);
    envelope[i] = new Env(this);
  
    x[i] = random(width);
    y[i] = random(height, height * 2);
    size[i] = random(10, 50);
    speed[i] = map(size[i], 10, 50, 1, 5);
    freq[i] = map(size[i], 10, 50, 2000, 100);
  }
  
}
void draw() {
  background(255);
  fill(0,0,255);
  rect(0, 80, width, height); 
  
  for(int i=0; i<amount; i++) {
    noStroke();
    fill(255, 120);
    circle(x[i], y[i], size[i]);
    
    y[i] -= speed[i];
  
  
    if(y[i] < 80+(size[i]/2)) {
      sine[i].freq(freq[i]);
      sine[i].play();  
      envelope[i].play(sine[i], 0.0005, 0.05, 0.2, 0.001);
      
      x[i] = random(width);
      y[i] = random(height, height * 2);
      size[i] = random(10, 50);
      speed[i] = map(size[i], 10, 50, 1, 5);
      freq[i] = map(size[i], 10, 50, 2000, 100);
    }
  }
}
