import processing.video.*;

String[] cameras = Capture.list();
Capture cam;

void setup() {
  size(640, 480);
  printArray(cameras);

  cam = new Capture(this, 640, 480, cameras[0]);

  // If this doesn't work, try one of the following lines instead:
  //cam = new Capture(this, 640, 480, cameras[0], 30);                         // for all OS
  //cam = new Capture(this, 640, 480, "pipeline:avfvideosrc device-index=0");  // for macOS (try different indices too)
  //cam = new Capture(this, 640, 480, "pipeline:kvvideosrc device-index=0");   // for Windows (try different indices too)

  cam.start();
}

void draw() {
  if (cam.available()) {
    cam.read();
  }

  image(cam, 0, 0);
}
