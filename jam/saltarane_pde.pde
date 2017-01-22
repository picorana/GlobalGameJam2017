
Wave wave;

FisicaSaltarane fs;

void setup() {
  size(800, 600);
  
  fs=new FisicaSaltarane(this, 48, 12);
  
  wave=fs.wave;
  wave.p(10, 10, 0);
  wave.p(30, 5, 0);
  wave.p(10, 30, 0);

}


boolean left_arrow_pressed=false;
boolean right_arrow_pressed=false;
void draw() {
  translate(200, 500);
  scale(10);
  fill(0);
  if(left_arrow_pressed){ 
    int x=(int)Math.round(0.1*wave.x);
    for(int y=(int)Math.round(0.3*wave.y); y<Math.round(0.7*wave.y); ++y){
      wave.p(x, y, wave.p(x, y)+0.8);
    }
  }
  if(right_arrow_pressed){
    int x=(int)Math.round(0.9*wave.x);
    for(int y=(int)Math.round(0.3*wave.y); y<Math.round(0.7*wave.y); ++y){
      wave.p(x, y, wave.p(x, y)+0.4);
    }
  }

  background(200);

  fs.update();
  
  
  float[] bp=fs.getBallPos();
  
  ellipse(bp[0]-1, bp[2]-1, 2, 2);
  
  for(int xi=0; xi<fs.wf.wave.x; ++xi){
    float y= fs.getWavePos(xi, fs.layer);
    float bh = fs.wf.boxheight;
    rect(xi-0.5, y-bh/2, 1, bh);
  }
}

void keyPressed() {
  if(keyCode==LEFT){
    left_arrow_pressed=true;
  }
  
  if(keyCode==RIGHT){
    right_arrow_pressed=true;
  }
  
  if(keyCode==UP){
    setup();  
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