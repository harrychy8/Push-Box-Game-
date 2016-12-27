// Harry's Block Class, used to draw the tiles in the background

class Block {

  // Data
  int x, y;
  PImage img;

  // Constructor
  Block(int x, int y, PImage imageToUse) {
    this.x = x;
    this.y = y;
    this.img = imageToUse;
  }

  // Method used to draw
  void update() {
    image(img, x, y);
  }
}