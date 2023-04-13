PImage photo;

void setup() {
  size(600, 600);
  photo = loadImage("yao.gif");
}

void draw() {
  image(photo, 0, 0);
  //tint(0, 0, 255);
  //image(photo, 0, 0);
}
