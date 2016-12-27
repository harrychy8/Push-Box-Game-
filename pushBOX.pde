//-------------------------------------------------
//
//  Brady & Harry's Pair Programming Assignment
//
//  May 19, 2016
//
//  pushBOX: The exciting puzzle game where you push boxes!
//
//  Feel free to test your own custom levels by editing the txt. files
//  in the levels folder located in this sketch's data folder!
//
//  Limitations with levels:
//  - Only one player can created in a level
//  - The amount of exits must be equal to or less than the amount of boxes in a level
//
//  Instructions:
//  Simply push the boxes onto the red 'X' tiles!
//
//-------------------------------------------------

// Declaring variables
String[] mapTemplate, movementAftermath;
char[][] map = new char[20][20];
Block[][] realMap = new Block[20][20];
Person player;
Box[] theBoxes;
LoadScreen levelDisplay;
int currentLevel, size, numberOfExits, numberOfExitsCovered, levelToAdd, finalLevel;
PImage wallIMG, endIMG, floorIMG, boxIMG, personIMG;
boolean newLevel, displayLevelScreen, showHelp, displayVictoryScreen;
boolean[] boxDirections;

//-------------------------------------------------

// Setup Loop
void setup() {
  size(600, 600);
  size = 30; // Approx. size of a single tile
  showHelp = true;

  // Load Images here to send into classes
  wallIMG = loadImage("wall.png");
  wallIMG.resize(size, size);
  endIMG = loadImage("end.png");
  endIMG.resize(size, size);
  floorIMG = loadImage("floor.png");
  floorIMG.resize(size, size);

  // Set up level variables
  newLevel = true;
  currentLevel = 1;
  finalLevel = 15;

  // Setup display screen
  levelDisplay = new LoadScreen();
}

//-------------------------------------------------

// Draw Loop
void draw() {

  // If a level needs to be drawn, increase the level by 0 or 1 (levelToAdd) and draw it
  if (newLevel && !displayVictoryScreen) {
    currentLevel += levelToAdd;
    
    if (currentLevel > finalLevel) {
     displayVictoryScreen = true; 
    }

    if (!displayVictoryScreen) {
    createNewLevel();
    drawLevel();

    newLevel = false; 
    displayLevelScreen = true; // Set display screen to true
    levelDisplay.createNewTimer(); // Create new timer for the displayScreen
    }
  }

  // If the displayScreen is active
  if (displayLevelScreen && !displayVictoryScreen) {
    boolean stopDisplaying = levelDisplay.displayTheScreen(currentLevel, finalLevel); // Check the display Screen's timer

    // If it's time to stop displaying, set display screen to stop
    if (stopDisplaying) {
      displayLevelScreen = false;
    }
  }

  //-------------------------------------------------

  // If the game is active
  if (!newLevel && !displayLevelScreen && !displayVictoryScreen) {
    for (int i = 0; i < 20; ++i) {
      for (int a = 0; a < 20; ++a) {
        realMap[i][a].update(); // Redraw the map so the box and player are shown in their new location
      }
    }

    // Draw the Player on the newly drawn map
    player.display();

    numberOfExitsCovered = 0; // Reset this value so the amounts of exits covered can be calculated
    
    // Instructions for the player
    if (showHelp) {
      textSize(12);
      fill(0);
      text("W, A, S, D for Movement", width/1.2, height/1.15);
      text("Q to Restart a Level", width/1.2, height/1.10);
      text("E to Hide/Show Help", width/1.2, height/1.05);
    }

    // Display all the boxes
    for (int theBox = 0; theBox < theBoxes.length; theBox++) {
      theBoxes[theBox].display();

      if (theBoxes[theBox].checkIfLevelIsComplete(realMap)) {
        numberOfExitsCovered += 1; // Increase this value if a box is on an exit
      }
    }

    if (numberOfExitsCovered == numberOfExits) { // If all the exits are covered
      newLevel = true; // Move on to the next level
      levelToAdd = 1;
    }
  }
  
  //-------------------------------------------------
  
  if (displayVictoryScreen) {
    levelDisplay.displayVictoryScreen();
  }
}

//-------------------------------------------------

void createNewLevel() {
  numberOfExits = 0; // Reset numbers of exits to 0

  mapTemplate = loadStrings("Levels/level" + Integer.toString(currentLevel) + ".txt");

  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 20; j++) {
      map[i][j] = mapTemplate[i].charAt(j); // Create the map template for the actual map to be drawn with
    }
  }

  for (int i = 0; i < 20; ++i) {
    for (int a = 0; a < 20; ++a) {
      if (map[i][a] == 'W') { // Create a wall tile
        realMap[i][a] = new Wall(a * size, i * size, wallIMG);
      }
      if (map[i][a] == 'F' || map[i][a] == 'B' || map[i][a] == 'P') { // create a floor tile
        realMap[i][a] = new Floor(a * size, i * size, floorIMG);
      }
      if (map[i][a] == 'E') { // create an exit tile
        numberOfExits += 1; // Increase this amount for each exit on the map
        realMap[i][a] = new End(a * size, i * size, endIMG);
      }
    }
  }
}

//-------------------------------------------------

// Draw/Redraw the level with the realMap array
void drawLevel() {

  int boxesInArray = 0;

  for (int i = 0; i < 20; ++i) {
    for (int a = 0; a < 20; ++a) {
      if (map[i][a] == 'B') {
        boxesInArray++; // First, determine the amount of boxes to be in the array
      }
    }
  }

  theBoxes = new Box[boxesInArray]; // Create the array

  int theBoxToAdd = 0; // Create a new int so we can keep track which box goes into each element

  for (int i = 0; i < 20; ++i) {
    for (int a = 0; a < 20; ++a) {
      if (map[i][a] == 'P') { // Create the player
        player = new Person(a * size, i * size, size);
      }
      if (map[i][a] == 'B') { // Create a box and add it to the array
        theBoxes[theBoxToAdd] = new Box(a * size, i * size, size);
        theBoxToAdd++; // Add 1 to theBoxToAdd so for the next element
      }
    }
  }
}

//-------------------------------------------------

// Keep track of key presses
void keyPressed() {

  // If the game is active
  if (!displayLevelScreen) {
    boolean ableToMove = true;
    for (int theBox = 0; theBox < theBoxes.length; theBox++) { // For each box, detect it's collision and move
      boxDirections = theBoxes[theBox].isCollidingWallAndBox(realMap, map, theBoxes);  

      movementAftermath = player.determineAftermathOfMoving(realMap, map, boxDirections, theBoxes[theBox]); // Determine if the player can move and what will happen if they do

      if (movementAftermath[0] != null) { // If a box can move, move it
        theBoxes[theBox].move(movementAftermath[0]);
      }
      if (movementAftermath[1] == null) { // Else stop the loop
        ableToMove = false;
        break;
      }
    }

    if (ableToMove) { // If the player can still move, move them
      player.movePlayer(movementAftermath[1]);
    }

    if (keyCode == 'Q') { // If Q is pressed, restart the level
      levelToAdd = 0;
      newLevel = true;
    }
    if(keyCode == 'E') {
     showHelp = !showHelp; 
    }
  }
}