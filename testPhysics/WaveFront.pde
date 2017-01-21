// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A fixed boundary class (now incorporates angle)

class WaveFront {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;


  float s =1;
  float floor = 800;
  // But we also have to make a body for box2d to know about it
  Body b;
  float wave[] = new float[30]; 
  WaveFront() {


    for (int i = 0; i< wave.length; i++)
    {
      wave[i] = (float)(20*Math.sin(i/3.f)) +580;
    }
    // Define the polygon
    s= width /wave.length;
    // Figure out the box2d coordinates


    // We're just a box

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    b = box2d.createBody(bd);
    for (int i= 1; i<wave.length; ++i)
    {
      PolygonShape sd = new PolygonShape(); 
      Vec2 arr[]= new Vec2[4];

      arr[0] = box2d.coordPixelsToWorld(s*(i-1), wave[i-1]);
      arr[1] = box2d.coordPixelsToWorld(s*(i), wave[i]);
      arr[2] = box2d.coordPixelsToWorld(s*(i), floor);
      arr[3] = box2d.coordPixelsToWorld(s*(i-1), floor);

      sd.set(arr, 4);

      b.createFixture(sd, 1);
    }




    // Create the body


    // Attached the shape to the body using a Fixture
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    stroke(0);
    strokeWeight(1);
    for(int i=1; i < wave.length;i++)
    {
      line(s*(i-1), wave[i-1],s*i, wave[i]);
      
    }
    /*
    Fixture f = getFixtureList().destroy();
    while(f.next() != null )
    {
      
    }
    
    */
  }
}