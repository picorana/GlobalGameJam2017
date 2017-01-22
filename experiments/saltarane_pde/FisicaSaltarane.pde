import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

class FisicaSaltarane(){
  
  Box2DProcessing box2d;
  Body ball;
  NewWaveFront wf;

  Wave wave;
  
  float x_l;
  float y_l;
  float layer;
  FisicaSaltarane(int x, int y){
    x_l=x;
    y_l=y;

    layer = round(y/2.);
    wave=new Wave(x, y);
    box2d = new Box2DProcessing(this, 1);
  
    box2d.createWorld();
    box2d.setGravity(0, 0);
    b = makeBall(x/2., 0, 3/2.);
    wf = new NewWaveFront(wave, layer);
    
  }
  
  Body makeBall(float x, float y, float radius){
    float r= radius;
    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;

    bd.position.set(new Vec2(x, y));
    body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius =r;
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
  
    fd.density = 1;
    fd.friction = 0;  // Slippery when wet!
    fd.restitution = 0.5;

    // Attach fixture to body
    body.createFixture(fd);
  }
  
  update(){
    wf.update();
    
    b.body.applyForceToCenter(new Vec2(0, -40));
    box2d.step();
  }
  
  float getWavePos(int x, int y){
        
    
  }
  
  float[] getBallPos(){
    Vec2 pos= ball.getPosition();
    
    return new float[]{pos.x, layer, pos.y}
    
    
  }
  
  
}