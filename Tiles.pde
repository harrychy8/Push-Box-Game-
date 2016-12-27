// Harry's Subclasse Constructors for the Block class, used simply to display the correct image when displaying each tile

// A floor tile
class Floor extends Block {
  Floor(int x, int y, PImage imageToUse) {
    super(x, y, imageToUse);
  }
}

// A wall tile
class Wall extends Block {
  Wall(int x, int y, PImage imageToUse) {
    super(x, y, imageToUse);
  }
}

// An end tile
class End extends Block {
  End(int x, int y, PImage imageToUse) {
    super(x, y, imageToUse);
  }
}