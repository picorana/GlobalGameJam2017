// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A fixed boundary class (now incorporates angle)

class NewWaveFront {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;
  
  float step = 0;
  float s =2;
  float floor = 800;
  // But we also have to make a body for box2d to know about it
  Body b;
  float wave[] = new float[30]; 
  NewWaveFront() {


    for (int i = 0; i< wave.length; i++)
    {
      wave[i] = (float)(20*Math.sin(i/3.f)) +580;
    }
    // Define the polygon
    s= width /wave.length;
    // Figure out the box2d coordinates


    // We're just a box

    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;
    b = box2d.createBody(bd);
    for (int i= 1; i<wave.length; ++i)
    {
      PolygonShape sd = new PolygonShape();
      sd.setAsBox(box2d.scalarPixelsToWorld(s), box2d.scalarPixelsToWorld(200), new Vec2(box2d.coordPixelsToWorld(s*(i), wave[i])),0);
      b.createFixture(sd, 1);
    }




    // Create the body


    // Attached the shape to the body using a Fixture
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    step++;
    stroke(0);
    strokeWeight(1);
    for (int i=1; i < wave.length; i++)
    {
      rect(s*(i-1)- s/2, wave[i-1]- 100,s,200);
    }
    
    
    b.setLinearVelocity(new Vec2(0,(float)(Math.sin(step))*30));
     
    
  }
}