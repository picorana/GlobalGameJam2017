import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


Box2DProcessing box2d;
Ball b;
ArrayList<Boundary> boundaries;
NewWaveFront w;

void setup()
{
  size(800, 600);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);
  b = new Ball(width/2, height/2);
  w = new NewWaveFront();
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(width/2, height, width, 5, 0));
  boundaries.add(new Boundary(0, height/2, 5, height, 0));
  boundaries.add(new Boundary(width, height/2, 5, height, 0));
}

void draw()
{
  // We must always step through time!
  background(255);
  b.body.applyForceToCenter(new Vec2(0, -10));
  b.body.applyForceToCenter(new Vec2(-1, 0));
  box2d.step();

  b.display();

  for (Boundary wall : boundaries)
    wall.display();
    
  w.display();
}