// Brady and Harry's Person class

class Person { 

  // Data
  int x, y;
  int size;
  boolean collidingWall, collidingBox;
  PImage personIMG;

  //-------------------------------------------------

  // Constructor
  Person(int _x, int _y, int _size) {
    x = _x;
    y = _y;
    size = _size;
    personIMG = loadImage("person.png");
    personIMG.resize(size, size);
  }

  //-------------------------------------------------

  // Method

  // Basic Display
  void display() {
    image(personIMG, x, y);
  }

  //-------------------------------------------------

  // Function used to determine what WILL happen if the player moves and returns the appropriate values to make that movement happen or not
  String[] determineAftermathOfMoving(Block[][] theMap, char[][] mapTemplate, boolean[] boxDirections, Box theBox) {
    boolean[] directionsAvailable = isCollidingWall(theMap, mapTemplate); // Determine if adjacent to walls
    boolean[] isBoxNear = isCollidingBox(theBox); // Determine if adjacent to box
    String pushedBox = null; // Set pushedBox and directionToMove to null first
    String directionToMove = null;

    // Check for player key presses
    if (key == 'w' || key == 'W' ) { //UP
      if (directionsAvailable[0] == true && (isBoxNear[0] == false || boxDirections[0] == true)) { // Make sure the player can move in the pressed direction
        if (isBoxNear[0]) { // If the box will be pushed, return the direction of pushiness
          pushedBox = "Up";
        }
        directionToMove = "Up"; // Return the direction the player moves
      }
    } else if (key == 's' || key == 'S' ) { //DOWN
      if (directionsAvailable[2] == true && (isBoxNear[2] == false || boxDirections[2] == true)) {
        if (isBoxNear[2]) {
          pushedBox = "Down";
        }
        directionToMove = "Down";
      }
    } else if (key == 'a' || key == 'A' ) { //LEFT
      if (directionsAvailable[1] == true && (isBoxNear[1] == false || boxDirections[1] == true)) {
        if (isBoxNear[1]) {
          pushedBox = "Left";
        }
        directionToMove = "Left";
      }
    } else if (key == 'd' || key == 'D' ) { //RIGHT
      if (directionsAvailable[3] == true && (isBoxNear[3] == false || boxDirections[3] == true)) {
        if (isBoxNear[3]) {
          pushedBox = "Right";
        }
        directionToMove = "Right";
      }
    }

    String[] movementOptions = {pushedBox, directionToMove}; // Return the pushedBox direction and player direction
    return movementOptions;
  }

  //-------------------------------------------------

  // Check if the player is adjacent to a wall and prevent movement in that direction
  boolean[] isCollidingWall(Block[][] theMap, char[][] mapTemplate) {

    // Same idea as the box, set all values to true
    boolean ableToGoUp = true;
    boolean ableToGoDown = true;
    boolean ableToGoLeft = true;
    boolean ableToGoRight = true;

    // And set them to false, as we check if a wall is adjacent to the player
    for (int i = 0; i < 20; ++i) {
      for (int a = 0; a < 20; ++a) {
        if (mapTemplate[i][a] == 'W') {
          if (theMap[i][a].y < y && theMap[i][a].y > y - (personIMG.height/2 + theMap[i][a].img.height) && theMap[i][a].x > x - (personIMG.width/2 + theMap[i][a].img.width/2) && theMap[i][a].x < x + (personIMG.width/2 + theMap[i][a].img.width/2)) {
            ableToGoUp = false;
          }
          if (theMap[i][a].y > y && theMap[i][a].y < y + (personIMG.height/2 + theMap[i][a].img.height) && theMap[i][a].x > x - (personIMG.width/2 + theMap[i][a].img.width/2) && theMap[i][a].x < x + (personIMG.width/2 + theMap[i][a].img.width/2)) {
            ableToGoDown = false;
          }
          if (theMap[i][a].x < x && theMap[i][a].x > x - (personIMG.width/2 + theMap[i][a].img.width) && theMap[i][a].y > y - (personIMG.height/2 + theMap[i][a].img.height/2) && theMap[i][a].y < y + (personIMG.height/2 + theMap[i][a].img.height/2)) {
            ableToGoLeft = false;
          }
          if (theMap[i][a].x > x && theMap[i][a].x < x + (personIMG.width/2 + theMap[i][a].img.width) && theMap[i][a].y > y - (personIMG.height/2 + theMap[i][a].img.height/2) && theMap[i][a].y < y + (personIMG.height/2 + theMap[i][a].img.height/2)) {
            ableToGoRight = false;
          }
        }
      }
    }

    // Return the available directions of movement
    boolean[] directionsAvailable = {ableToGoUp, ableToGoLeft, ableToGoDown, ableToGoRight};
    return directionsAvailable;
  }

  //-------------------------------------------------

  // Check is the player is adjacent to the box
  boolean[] isCollidingBox(Box theBox) {

    // Same idea as the isCollidingWall function, but set all values to false
    boolean boxIsAbove = false;
    boolean boxIsBelow = false;
    boolean boxIsToLeft = false;
    boolean boxIsToRight = false;

    // And then set the values to true as they check out!
    if (theBox.y < y && theBox.y > y - (personIMG.height/2 + theBox.boxIMG.height) && theBox.x > x - (personIMG.width/2 + theBox.boxIMG.width/2) && theBox.x < x + (personIMG.width/2 + theBox.boxIMG.width/2)) {
      boxIsAbove = true;
    }
    if (theBox.y > y && theBox.y < y + (personIMG.height/2 + theBox.boxIMG.height) && theBox.x > x - (personIMG.width/2 + theBox.boxIMG.width/2) && theBox.x < x + (personIMG.width/2 + theBox.boxIMG.width/2)) {
      boxIsBelow = true;
    }
    if (theBox.x < x && theBox.x > x - (personIMG.width/2 + theBox.boxIMG.width) && theBox.y > y - (personIMG.height/2 + theBox.boxIMG.height/2) && theBox.y < y + (personIMG.height/2 + theBox.boxIMG.height/2)) {
      boxIsToLeft = true;
    }
    if (theBox.x > x && theBox.x < x + (personIMG.width/2 + theBox.boxIMG.width) && theBox.y > y - (personIMG.height/2 + theBox.boxIMG.height/2) && theBox.y < y + (personIMG.height/2 + theBox.boxIMG.height/2)) {
      boxIsToRight = true;
    }
    
    // Return the values that tell if the box is adjacent
    boolean[] isBoxNear = {boxIsAbove, boxIsToLeft, boxIsBelow, boxIsToRight};
    return isBoxNear;
  }

//-------------------------------------------------

  // Used to move the player in the pressed direction
  void movePlayer(String directionToMove) {
    if (directionToMove == "Left") {
      x = x - size;
    } else if (directionToMove == "Right") {
      x = x + size;
    } else if (directionToMove == "Up") {
      y = y - size;
    } else if (directionToMove == "Down") {
      y = y + size;
    }
    
    // Realistically, the player will never have a chance to leave the screen, but for completeness sake, constrain x and y coordinates
    x = constrain(x, 0, width-size);
    y = constrain(y, 0, height-size);
  }
}