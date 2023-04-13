import processing.video.*;
String[] cameras = Capture.list();
Capture cam;

void setup() {
  size(640, 480);
  background(0);  
  cam = new Capture(this, cameras[0]);
  cam.start();
}
void draw() {
  if ( cam.available() ) {
    cam.read();
    cam.loadPixels();
  }
  for (int y = 0; y < cam.height; y++) {
    for (int x = 0; x < cam.width; x++) {
      int index = x + y*cam.width;
      color pixelColor = cam.pixels[index];
      set(x, y, pixelColor);
    }
  }
  cam.updatePixels();
}
