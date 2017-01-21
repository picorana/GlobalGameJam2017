class Jump {
  float max = 0;
  float min = 0;
  boolean maxFound = false;
  boolean minFound = false;
  
  void searchMax(float input) {
    if (input < 0) {
      maxFound = true;
      println("max is "+this.max);
      return;
    }
    if (input > this.max)
      this.max = input;
    println("actual max: "+this.max);
  }
  
  void searchMin(float input) {
    if (input > 0) {
      minFound = true;
      println("min is "+this.min);
      return;
    }
    if (input < this.min)
      this.min = input;
    println("actual min: "+this.min);
  }
  
  float getJump(float[] input) {
    for (float i : input) {
      if (!this.maxFound)
        searchMax(i);
      else if (!this.minFound)
        searchMin(i);
    }
    return this.max-this.min;
  }
  
}

float[] input = {
  10.64,17.9,17.91,24.23,19.45,14.2,15,16.44,16.19,16.17,15.89,14.29,11.92,9.1,7.25,6.71,
  6.69,7.14,8.51,9.8,10.5,10.09,8.14,8.11,5.56,-5.14,-6.66,-7.72,-8.36,-8.38,-8.37,-8.26,
  -8.31,-8.22,-8.01,-7.73,-7.72,-7.45,-7.37,-7.4,-7.47,-7.44,-7.48,-7.46,-7.68,-7.97,-8.6,
  -9.22,-9.54,-9.22,-9.21,-8.49,-7.49,-6.15,5
};

void setup() {
  Jump j = new Jump();
  println("jump value: "+j.getJump(input));
}
