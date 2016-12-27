// Harry and Brady's Box Class

class Box { 

  // Data
  int x, y, size;
  boolean collidingWall;
  boolean[] directionsAvailable;
  PImage boxIMG;

  //-------------------------------------------------

  // Constructor
  Box(int _x, int _y, int _size ) {
    x = _x;
    y = _y;
    size = _size;
    boxIMG = loadImage("box.png");
    boxIMG.resize(size, size);
  }

  //-------------------------------------------------

  // Methods

  // Basic draw method
  void display() {
    image(boxIMG, x, y);
  }

  //-------------------------------------------------

  // Move function
  void move(String directionToMove) {

    // Move in the direction the string's value is
    if (directionToMove == "Up") {
      y = y - size;
    } else if (directionToMove == "Down") {
      y = y + size;
    } else if (directionToMove == "Left") {
      x = x - size;
    } else if (directionToMove == "Right") {
      x = x + size;
    }
  }

  //-------------------------------------------------

  // Collision detection
  boolean[] isCollidingWallAndBox(Block[][] theMap, char[][] mapTemplate, Box[] theBoxes) {

    // First set each boolean to true;
    boolean ableToGoUp = true;
    boolean ableToGoDown = true;
    boolean ableToGoLeft = true;
    boolean ableToGoRight = true;

    // Go through the loop and check for walls, If a wall is adjacent, remove the ability to move in that direction
    for (int i = 0; i < 20; ++i) {
      for (int a = 0; a < 20; ++a) {
        if (mapTemplate[i][a] == 'W') { // Only check for walls
          if (theMap[i][a].y < y && theMap[i][a].y > y - (boxIMG.height/2 + theMap[i][a].img.height) && theMap[i][a].x > x - (boxIMG.width/2 + theMap[i][a].img.width/2) && theMap[i][a].x < x + (boxIMG.width/2 + theMap[i][a].img.width/2)) {
            ableToGoUp = false;
          }
          if (theMap[i][a].y > y && theMap[i][a].y < y + (boxIMG.height/2 + theMap[i][a].img.height) && theMap[i][a].x > x - (boxIMG.width/2 + theMap[i][a].img.width/2) && theMap[i][a].x < x + (boxIMG.width/2 + theMap[i][a].img.width/2)) {
            ableToGoDown = false;
          }
          if (theMap[i][a].x < x && theMap[i][a].x > x - (boxIMG.width/2 + theMap[i][a].img.width) && theMap[i][a].y > y - (boxIMG.height/2 + theMap[i][a].img.height/2) && theMap[i][a].y < y + (boxIMG.height/2 + theMap[i][a].img.height/2)) {
            ableToGoLeft = false;
          }
          if (theMap[i][a].x > x && theMap[i][a].x < x + (boxIMG.width/2 + theMap[i][a].img.width) && theMap[i][a].y > y - (boxIMG.height/2 + theMap[i][a].img.height/2) && theMap[i][a].y < y + (boxIMG.height/2 + theMap[i][a].img.height/2)) {
            ableToGoRight = false;
          }
        }
      }
    }

    // Do the same thing above, but for the boxes in the map
    for (int theBox = 0; theBox < theBoxes.length; theBox++) {
      if (theBoxes[theBox].x != x || theBoxes[theBox].y != y ) { // If the box is not detecting collision with itself
        if (theBoxes[theBox].y < y && theBoxes[theBox].y > y - (boxIMG.height/2 + theBoxes[theBox].boxIMG.height) && theBoxes[theBox].x > x -(boxIMG.width/2 + theBoxes[theBox].boxIMG.width/2) && theBoxes[theBox].x < x + (boxIMG.width/2 + theBoxes[theBox].boxIMG.width/2)) {
          ableToGoUp = false;
        }
        if (theBoxes[theBox].y > y && theBoxes[theBox].y < y + (boxIMG.height/2 + theBoxes[theBox].boxIMG.height) && theBoxes[theBox].x > x -(boxIMG.width/2 + theBoxes[theBox].boxIMG.width/2) && theBoxes[theBox].x < x + (boxIMG.width/2 + theBoxes[theBox].boxIMG.width/2)) {
          ableToGoDown = false;
        }
        if (theBoxes[theBox].x < x && theBoxes[theBox].x > x - (boxIMG.width/2 + theBoxes[theBox].boxIMG.width) && theBoxes[theBox].y > y -(boxIMG.height/2 + theBoxes[theBox].boxIMG.height/2) && theBoxes[theBox].y < y + (boxIMG.height/2 + theBoxes[theBox].boxIMG.height/2)) {
          ableToGoLeft = false;
        }
        if (theBoxes[theBox].x > x && theBoxes[theBox].x < x + (boxIMG.width/2 + theBoxes[theBox].boxIMG.width) && theBoxes[theBox].y > y -(boxIMG.height/2 + theBoxes[theBox].boxIMG.height/2) && theBoxes[theBox].y < y + (boxIMG.height/2 + theBoxes[theBox].boxIMG.height/2)) {
          ableToGoRight = false;
        }
      }
    }

    // Return the Directions the box can go in an array
    boolean[] directionsAvailable = {ableToGoUp, ableToGoLeft, ableToGoDown, ableToGoRight};
    return directionsAvailable;
  }

  //-------------------------------------------------

  // Check if the box is on the exit, and return true if it is
  boolean checkIfLevelIsComplete(Block[][] theMap) {
    for (int i = 0; i < 20; ++i) {
      for (int a = 0; a < 20; ++a) {
        if (map[i][a] == 'E' && x == theMap[i][a].x && y == theMap[i][a].y) {
          return true;
        }
      }
    } 
    return false;
  }
}