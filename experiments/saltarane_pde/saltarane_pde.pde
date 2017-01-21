import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;



Box2DProcessing box2d;
Ball b;
ArrayList<Boundary> boundaries;
NewWaveFront wf;

Wave wave;

void setup() {
  size(800, 600);

  wave=new Wave(70, 70);
  wave.p(10, 10, 10);
  wave.p(30, 5, 70);
  wave.p(10, 30, -40);

  box2d = new Box2DProcessing(this);
  
  box2d.createWorld();
  box2d.setGravity(0, 0);
  b = new Ball(width/2, height/2);
  wf = new NewWaveFront(wave);
/*  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(width/2, height, width, 5, 0));
  boundaries.add(new Boundary(0-4, height/2, 5, height, 0));
  boundaries.add(new Boundary(width+4, height/2, 5, height, 0));
  */
}


boolean left_arrow_pressed=false;
boolean right_arrow_pressed=false;
void draw() {
  //scale(0.3);
  fill(0);
  if(left_arrow_pressed){ 
    int x=(int)Math.floor(0.1*wave.x);
    for(int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y){
      wave.p(x, y, wave.p(x, y)+15);
    }
  }
  if(right_arrow_pressed){
    int x=(int)Math.floor(0.9*wave.x);
    for(int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y){
      wave.p(x, y, wave.p(x, y)+15);
    }
  }

  background(200);

  wf.update();

  b.body.applyForceToCenter(new Vec2(0, -40));
  box2d.step();

  wf.display();

  b.display();

/*
  for (Boundary wall : boundaries){
    wall.display();
  }
*/
}

void keyPressed() {
  if(keyCode==LEFT){
    left_arrow_pressed=true;
  }
  
  if(keyCode==RIGHT){
    right_arrow_pressed=true;
  }
}

void keyReleased(){
  if(keyCode==LEFT){
    left_arrow_pressed=false;
  }
  
  if(keyCode==RIGHT){
    right_arrow_pressed=false;
  }

}