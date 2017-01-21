PImage photoTileBlu;
World world = new World();
Leaf l;
final int TILENUMBER = 44;
void setup() {
  size(640, 480);
  ellipseMode(CORNER);
  noSmooth();
  photoTileBlu = loadImage("tile.png");
  // noCursor();
  l=new Leaf(5, width/2, 260);
}

void draw() {
  background(0);
  translate(width / 2, height / 2);
  world.render();

  if (mousePressed)
  {
    if (mouseButton == LEFT)
    {
      PVector p= new PVector((mouseX-l.location.x)*-1, 0);
      p.normalize();
      l.applyForce(p);
    } else
    {
      PVector p= new PVector(0, (mouseY-l.location.y)*-1);
      p.normalize();
      l.applyForce(p);
    }
  }

  l.update();


  l.display();
}