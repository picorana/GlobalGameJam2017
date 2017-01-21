Game g;

void setup() {
  g = new Game(10, 1);
}

void draw() {
}

void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
      case LEFT:
        print("move left - ");
        g.moveLeft(1);
        break;
      case RIGHT:
        print("move right - ");
        g.moveRight(1);
        break;
    }
  }  
}
