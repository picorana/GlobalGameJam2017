
class NewWaveFront {
  float s;
  float bh = 10;
  
  Wave wave;
  int layer;
  
  Body bodies[];
  PolygonShape shapes[];
  Body anchor;
  PrismaticJoint pistons[];
  MouseJoint p_targets[];
  NewWaveFront(Wave wave) {

    this.wave = wave;
    this.layer= round(wave.y/2);
    s = (float)(width)/wave.x;

    System.out.println(s);
    
    Filter nc_filt = new Filter();
    nc_filt.groupIndex = -1;

    bodies=new Body[wave.x];
    shapes=new PolygonShape[bodies.length];
    pistons=new PrismaticJoint[bodies.length];
    p_targets=new MouseJoint[bodies.length];
    
    {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(width/2, -height));
    anchor = box2d.createBody(bd);
    PolygonShape sh = new PolygonShape();
    sh.setAsBox(box2d.scalarPixelsToWorld(width/2), box2d.scalarPixelsToWorld(5));
    anchor.createFixture(sh, 1).setFilterData(nc_filt);
    }
    for(int i= 0; i<bodies.length; ++i){
      BodyDef bd = new BodyDef();
      bd.type = BodyType.DYNAMIC;

      bd.position.set(box2d.coordPixelsToWorld(s*i, wp(i)));

      bodies[i] = box2d.createBody(bd);
      shapes[i] = new PolygonShape();
      shapes[i].setAsBox(box2d.scalarPixelsToWorld(s), box2d.scalarPixelsToWorld(bh));
      
      bodies[i].createFixture(shapes[i], 1).setFilterData(nc_filt);
      
      PrismaticJointDef pjd= new PrismaticJointDef();
      pjd.initialize(anchor, bodies[i], box2d.coordPixelsToWorld(s*i, height), new Vec2(0, 1));
      pjd.enableLimit=false;
      pjd.enableMotor=false;
      pjd.collideConnected=false;
      pistons[i] = (PrismaticJoint)box2d.createJoint(pjd);
      
      
      MouseJointDef mjd = new MouseJointDef();
      mjd.bodyB=bodies[i];
      mjd.bodyA=anchor;
      mjd.collideConnected=false;
      //mjd.target=box2d.coordPixelsToWorld(s*i, wp(i));
      mjd.maxForce=bodies[i].getMass()*1000;
      mjd.dampingRatio=0.8;
      p_targets[i]=(MouseJoint)box2d.createJoint(mjd);
    }
  }

  float wp(int x){
//    return 400;
    return wave.p(x, layer)/10 + 800;
  }

  void update(){
    wave.update(0.05); 
    for(int i=0; i<bodies.length; ++i){
        Vec2 pos=p_targets[i].getTarget();
        Vec2 p=bodies[i].getPosition();
       p_targets[i].setTarget(new Vec2(pos.x, wp(i)/box2d.scaleFactor - p.y));//new Vec2(pos.x, 0));//wp(i)/box2d.scaleFactor));
    }
  }

  void display() {
    stroke(0);
    strokeWeight(1);
 
    for(int i=0; i< bodies.length; ++i){
      Vec2 pos = box2d.getBodyPixelCoord(bodies[i]);
      //the fuck 
      rect(pos.x+s/4, pos.y+bh/4, s*0.8, bh); 
    }
  }
}