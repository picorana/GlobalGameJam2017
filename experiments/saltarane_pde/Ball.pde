


public class Ball
{

  Body body;
  Vec2 pos;
  public Ball(float x, float y)
  {
    makeBody(new Vec2(x,y),6);
    pos = new Vec2(x,y);
    
  }
  
  
 void makeBody(Vec2 center, float r) {
    // Define and create the body
    BodyDef bd = new BodyDef();
        bd.type = BodyType.DYNAMIC;

    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    // Give it some initial random velocity
    //body.setLinearVelocity(new Vec2(random(-1,1),random(-1,1)));

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
  
    fd.density = 1;
    fd.friction = 0;  // Slippery when wet!
    fd.restitution = 0.5;

    // We could use this if we want to turn collisions off
    //cd.filter.groupIndex = -10;

    // Attach fixture to body
    body.createFixture(fd);

  }
  
  
  void display() {
    // We look at each body and get its screen position
    pos = box2d.getBodyPixelCoord(body);
    CircleShape c = ((CircleShape)(body.getFixtureList().getShape()));
    float rd = box2d.scalarWorldToPixels(c.getRadius());
    // Draw particle as a trail
    ellipse(pos.x,pos.y,rd,rd);
  }
}