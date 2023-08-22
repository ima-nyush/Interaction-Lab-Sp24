PImage photo;

void setup() {
  size(600, 600);
  photo = loadImage("yao.gif");
}

void draw() {
  image(photo, 0, 0);
  filter(INVERT);

  //filter(BLUR);
  //filter(BLUR, 6);
  //filter(GRAY);
  //filter(THRESHOLD);
}
