import processing.video.*; 
String[] cameras = Capture.list();
Capture cam;
void setup() { 
  size(640, 480); 
  cam = new Capture(this, cameras[0]);
  cam.start();
} 
void draw() {
  if ( cam.available() ) {
    cam.read();
    cam.loadPixels();
  }
  int rectSize = 15;
  int w = cam.width;
  int h = cam.height;
  for (int y = 0; y < h; y+=rectSize) {
    for (int x = 0; x < w; x+=rectSize) {
      int i =  x + y * w;
      fill( cam.pixels[i] );
      rect(x, y, rectSize, rectSize);
    }
  }
  cam.updatePixels();
}
