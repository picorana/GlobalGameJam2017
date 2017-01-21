
Wave wave;

int w = 800;
int h = 600;

class Ell{
  float p[]= {0,0,0};
  float p_[]= {0,0,0};
  float a[]= {0,0,0};

  void p(float x, float y, float z){
    ell.p[0]=x;
    ell.p[1]=y;
    ell.p[2]=z;
  }

  void p_(float x, float y, float z){
    ell.p_[0]=x;
    ell.p_[1]=y;
    ell.p_[2]=z;
  }
  
  void a(float x, float y, float z){
    ell.a[0]=x;
    ell.a[1]=y;
    ell.a[2]=z;
  }
  
  void update(float dt){
    for(int i =0; i<3; ++i){
      float pn = 2*p[i] - 1*p_[i] + a[i]*dt*dt;
      p_[i]= p[i];
      p[i] = pn;
    }
    
    a[0]=0;
    a[1]=0;

    //float the ball above water by applying acceleration
    if(p[2]<0){
      a[2]=10;
    }else{
      a[2]=-20;
    }
  }
}

Ell ell = new Ell();

int lasttime;
void setup() {
  size(800, 600);

  wave=new Wave(70, 70);

  wave.p(10, 10, 10);

  wave.p(30, 5, 70);
  wave.p(10, 30, -40);

  ell.p(wave.x/2, floor(wave.y/2),0);
  ell.p_(wave.x/2, floor(wave.y/2), 0);
  ell.a(0,0,0);
  
  ell.p[0]+=0.1;
  lasttime=millis();
}


boolean left_arrow_pressed=false;
boolean right_arrow_pressed=false;
void draw() {
  if(left_arrow_pressed){ 
    int x=(int)Math.floor(0.1*wave.x);
    for(int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y){
      wave.p(x, y, wave.p(x, y)+15);
    }
  }
  if(right_arrow_pressed){
    int x=(int)Math.floor(0.9*wave.x);
    for(int y=(int)Math.floor(0.5*wave.y); y<Math.ceil(0.9*wave.y); ++y){
      wave.p(x, y, wave.p(x, y)+15);
    }
  }

  background(255);
  float dt=(millis()-lasttime)/1000.;
//  float dt=0.4;
  lasttime=millis();

  float reps=1.;
  for(int i=0; i<reps; ++i){
    wave.update(dt);
  }

  ell.update(dt);

  //apply the displacement from the water below
  do{
      int x=(int)floor(ell.p[0]);
      int y=(int)floor(wave.y/2);
      if(x>=wave.x || y>=wave.y) continue;
      float z = wave.p(x, y);
      if(z<ell.p[2]){
        ell.p[2]=z;
      }
  }while(false);  
  
  ellipse(w*ell.p[0]/wave.x, h/2+ell.p[2], 20, 20);

  float scalef=0.2;
  for(int y=0; y< wave.y; ++y){
    stroke(255-255*y/wave.y);
    for(int x=1; x<wave.x; ++x){

//      rect(x*w/wave.x, y*h/wave.y + floor(wave.p(x, y).p/15)*15, 15, 15)
      line((x-1)*w/wave.x, y*h/wave.y + round(scalef*wave.p(x-1, y) / 20.)*20., x*w/wave.x, y*h/wave.y +round(scalef*wave.p(x, y) /20.)*20.);

    }
  }
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