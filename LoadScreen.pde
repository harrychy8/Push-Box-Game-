// Brady's LoadScreen Class

class LoadScreen {
  // Data for LoadScreen class
  float startTime, timeToLast;

  //-------------------------------------------------

  // Constructor(s) 
  LoadScreen() {
    timeToLast = 3000;
  }

  LoadScreen(float _timeToLast) {
    timeToLast = _timeToLast;
  }

  //-------------------------------------------------

  // Methods

  // Create a new timer with millis()
  void createNewTimer() {
    startTime = millis();
  }

  //-------------------------------------------------

  // Display the message at the start of the level
  boolean displayTheScreen(int theLevel, int finalLevel) { 
    textSize(32);
    textAlign(CENTER);
    background(0);
    fill(255);
    
    if (theLevel < finalLevel) {
    text("Starting Level " + theLevel, width/2, height/2);   
    }
    else {
      text("Starting Final Level", width/2, height/2);   
    }

    if (millis() < startTime + timeToLast) { 
      return false;
    }
    return true; // Return true if the timer is up
  }
  
  //-------------------------------------------------
  
  // Used to display the victory screen
  void displayVictoryScreen() {
   textSize(24);
   textAlign(CENTER);
   background(0);
   fill(255);
   text("Congrats, you beat the game, now go outside", width/2, height/2);
  }
} 