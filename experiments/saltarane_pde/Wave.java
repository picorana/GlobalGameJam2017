class Wave{
  int x, y;
  float[] wave;  //p, p_, a
  float restitution=0.998f;
  float springiness=0.99f;
  float returnosity=0.15f;
  float maxJerk=10;
  int iterations=10;
  Wave(int x, int y){
    this.x=x;
    this.y=y;
    this.wave=new float[x*y*3];
    for(int i=0; i< (this.wave.length)/3; ++i){
      this.wave[i]=0;
      this.wave[i+1]=0;
      this.wave[i+2]=0;
    }
  }
  
  float p(int x, int y){
    return this.wave[(y + x*this.y)*3];
  }
  
  void p(int x, int y, float z){
    this.wave[(y + x*this.y)*3] = z;
  }

  float p_(int x, int y){
    return this.wave[(y + x*this.y)*3 +1];
  }
  
  void p_(int x, int y, float z){
    this.wave[(y + x*this.y)*3+1] = z;
  }

  float a(int x, int y){
    return this.wave[(y + x*this.y)*3 +2];
  }
  
  void a(int x, int y, float z){
    this.wave[(y + x*this.y)*3 +2] = z;
  }

  void update(float dt){
    for(int i=0; i<iterations; ++i){
    //apply verlet integration to each point (points are constrained in the vertical dimension, x and y are fixed
    for(int x=0; x<this.x; ++x){
      for(int y=0; y<this.y; ++y){
        float p=this.p(x, y);
        float p_=this.p_(x,y);
        float a=this.a(x,y);
        float pn=(1+restitution)*p - restitution*p_ + a*dt*dt;
        this.p_(x, y, p);
        this.p(x, y, pn);
      }
    }
    
      propagate();
    }
  }

  void propagate(){
    //modify the acceleration of each particle based on its neighbors. if on the edge, this reflect the wave
    for(int x=0; x<this.x; ++x){
      for(int y=0; y<this.y; ++y){
        //neighbors: up
        int eux = (x==0)? x+1: x-1; 
        int euy = y;
        float eu = p(eux, euy);    
        
        //down
        int edx = (x==this.x-1)? x-1: x+1;
        int edy = y;
        float ed = p(edx, edy);
  
        //left
        int elx = x;
        int ely = (y==0)? y+1: y-1;
        float el = p(elx, ely);
  
        //right
        int erx = x;
        int ery = (y==this.y-1)? y-1: y+1;
        float er = p(erx, ery);
  
        float p=p(x, y);
         
        float a = (eu + ed + el + er -4*p)* springiness;
        a -= p * returnosity;
        
        float old_a=a(x, y);
        if(old_a*a <0) a=0;        
//        if((a-old_a )> maxJerk){ a=old_a+maxJerk; }else if((a-old_a) < -maxJerk){a = old_a - maxJerk;}

        a(x, y, a);
      }
    }
    
  }
}