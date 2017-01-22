class Bomb {
  private int fieldLength;
  private int stepLength;
  private int position = 0;
  private boolean end = false;
  
  public Bomb(int fieldLength, int stepLength) {
    this.fieldLength = fieldLength;
    this.stepLength = stepLength;
  }
  
  public void reset() {
    println();
    this.position = 0;
    this.end = false;
    println("start position: "+this.position);
  }
  
  private void move(int steps) {
    this.position = this.position + this.stepLength * steps;
    if (position == fieldLength) {
      this.end = true;
    }
    else if (position == -fieldLength) {
      this.end = true;
    }
  }
  
  void moveRight(int steps) {
    this.move(abs(steps));
  }
  
  void moveLeft(int steps) {
    this.move(-steps);
  }
}