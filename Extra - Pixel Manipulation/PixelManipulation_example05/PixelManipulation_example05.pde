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
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0, width, height);
}
