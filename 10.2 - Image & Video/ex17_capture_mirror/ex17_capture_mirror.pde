import processing.video.*; 

String[] cameras = Capture.list();
Capture cam;

void setup() { 
  size(1280, 480); 

  cam = new Capture(this, cameras[0]);

  // If this doesn't work, try one of the following lines instead:
  //cam = new Capture(this, cameras[0], 30);                         // for all OS
  //cam = new Capture(this, "pipeline:avfvideosrc device-index=0");  // for macOS (try different indices too)
  //cam = new Capture(this, "pipeline:kvvideosrc device-index=0");   // for Windows (try different indices too)

  cam.start();
} 

void draw() { 
  if (cam.available()) { 
    cam.read();
  } 
  
  scale(-1, 1);
  image(cam, -640, 0);
  scale(-1, 1);
  image(cam, 640, 0);
}
