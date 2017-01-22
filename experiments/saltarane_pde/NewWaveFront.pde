
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
      bd.linearDamping=0.8f;
      bd.bullet=true;

      bodies[i] = box2d.createBody(bd);
      shapes[i] = new PolygonShape();
      shapes[i].setAsBox(1./2 , boxheight/2.);
      
      bodies[i].createFixture(shapes[i], 300).setFilterData(nc_filt);
      
      PrismaticJointDef pjd= new PrismaticJointDef();
                                                 //0 here was heigth
      pjd.initialize(anchor, bodies[i], new Vec2(i, 0), new Vec2(0, 1));
      pjd.enableLimit=false;
      pjd.enableMotor=false;
      pjd.collideConnected=false;
      pistons[i] = (PrismaticJoint)box2d.createJoint(pjd);
      
      
      MouseJointDef mjd = new MouseJointDef();
      mjd.bodyB=bodies[i];
      mjd.bodyA=anchor;
      mjd.collideConnected=false;
      //mjd.target=box2d.coordPixelsToWorld(s*i, wp(i));
      mjd.maxForce=bodies[i].getMass()*2000;
      mjd.dampingRatio=0.8;
      p_targets[i]=(MouseJoint)box2d.createJoint(mjd);
      p_targets[i].setTarget(new Vec2(0, wp(i)));
    }
  }

  float wp(int x){
    return (x< wave.x)? wave.p(x, layer): 0;//-boxheight;
  }

  void wp(int x, float val){
    wave.p(x, layer, val);//-boxheight;
  }

  void update(){
    wave.update(0.02); 
    for(int i=0; i<bodies.length; ++i){
//       Vec2 pos=p_targets[i].getTarget();
//       Vec2 p=bodies[i].getPosition();
       //p_targets[i].setTarget(new Vec2(pos.x, wp(i) - p.y));

       p_targets[i].setTarget(new Vec2(0, wp(i)));
       //wp(i, (p.y-wp(i))/10. + wp(i));
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