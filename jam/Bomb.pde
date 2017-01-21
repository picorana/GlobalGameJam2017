class Bomb {
  private int fieldLength;
  private int stepLength;
  private int position = 0;
  private boolean end = false;
  
  public Bomb(int fieldLength, int stepLength) {
    this.fieldLength = fieldLength;
    this.stepLength = stepLength;
    println("game start");
    println("start position: "+this.position);
  }
  
  public void reset() {
    println();
    this.position = 0;
    this.end = false;
    println("start position: "+this.position);
  }
  
  private void move(int steps) {
    this.position = this.position + this.stepLength * steps;
    println("new position: "+this.position);
    if (position == fieldLength) {
      this.end = true;
      println("right player win!");
      this.reset();
    }
    else if (position == -fieldLength) {
      this.end = true;
      println("left player win!");
      this.reset();
    }
  }
  
  void moveRight(int steps) {
    this.move(abs(steps));
  }
  
  void moveLeft(int steps) {
    this.move(-steps);
  }
}
