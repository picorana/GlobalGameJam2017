public class Leaf
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  
    Leaf(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    toIsometric(location);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  
    private void toIsometric(PVector v)
  {
    float isoX = (v.x - v.y) / 2.0;
    v.y = (v.x + v.y) / 4.0;
    v.x = isoX;
    
  }

  
   void applyForce(PVector force) {
    toIsometric(force);
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    velocity.mult(0.98799);
    //toIsometric(location);
    
  }

  void display() {
    stroke(4);
    strokeWeight(2);
    fill(0, 255,0);
    //rect();
    line(location.x - (World.TILE_SIZE >> 1), location.y, location.x, location.y - (World.TILE_SIZE >> 2) ); //>> è il bitshift
    line(location.x + (World.TILE_SIZE >> 1), location.y, location.x, location.y - (World.TILE_SIZE >> 2) );
    line(location.x - (World.TILE_SIZE >> 1), location.y, location.x, location.y + (World.TILE_SIZE >> 2) );
    line(location.x + (World.TILE_SIZE >> 1), location.y, location.x, location.y + (World.TILE_SIZE >> 2) );
  }


  void checkEdges() {

    if (location.x+(mass*16)/2 > width) {
      location.x = width-(mass*16)/2;
      velocity.mult(0.333);
      velocity.x *= -1;
    } 
    else if (location.x-(mass*16)/2 < 0) {
      location.x = 0+(mass*16)/2;
      velocity.mult(0.333);
      velocity.x *= -1;
    }

    if (location.y+(mass*16)/2 > height) {
      velocity.mult(0.333);
      velocity.y *= -1;
      location.y = height-(mass*16)/2;
    }
    if (location.y-(mass*16)/2 < 0) {
      velocity.mult(0.333);
      velocity.y *= -1;
      location.y = 0+(mass*16)/2;
    }
  }
}