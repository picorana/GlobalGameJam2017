
class NewWaveFront {
  float s;
  float boxheight = 10;
  Wave wave;
  int layer;
  
  Body bodies[];
  PolygonShape shapes[];
  Body anchor;
  PrismaticJoint pistons[];
  MouseJoint p_targets[];
  
  Box2DProcessing box2d;
  NewWaveFront(Box2DProcessing bx, Wave wave, int layer) {
    
    box2d=bx;
    this.wave = wave;
    this.layer= layer;
//    s = (float)(width)/wave.x;

    
    Filter nc_filt = new Filter();
    nc_filt.groupIndex = -1;

    bodies=new Body[wave.x];
    shapes=new PolygonShape[bodies.length];
    pistons=new PrismaticJoint[bodies.length];
    p_targets=new MouseJoint[bodies.length];
    
    {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(-2*width, -2*height);    //get it away from here
    anchor = box2d.createBody(bd);
    PolygonShape sh = new PolygonShape();
    sh.setAsBox(width/2, 5);
    anchor.createFixture(sh, 1).setFilterData(nc_filt);
    
    }
    for(int i= 0; i<bodies.length; ++i){
      BodyDef bd = new BodyDef();
      bd.type = BodyType.KINEMATIC;
      bd.position.set(i, wp(i));

      bodies[i] = box2d.createBody(bd);
      shapes[i] = new PolygonShape();
      shapes[i].setAsBox(1./2 , boxheight/2.);
      
      bodies[i].createFixture(shapes[i], 30).setFilterData(nc_filt);
    }
  }

  float wp(int x){
    return (x< wave.x)? wave.p(x, layer): 0;//-boxheight;
  }

  void wp(int x, float val){
    wave.p(x, layer, val);//-boxheight;
  }

  void update(){
    wave.update(0.05); 
    for(int i=0; i<bodies.length; ++i){
       Vec2 p=bodies[i].getPosition();
       bodies[i].setLinearVelocity(new Vec2(0, 60*(wp(i) - p.y)));
    }
  }

  
  float getWavePos(int x, int y) {
    if(y!=layer){
      return wave.p(x, y);
    }else{
      return bodies[x].getPosition().y - boxheight/4.;  
    }
  }
}