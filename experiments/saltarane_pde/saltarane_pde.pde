
Wave wave;

FisicaSaltarane fs;

void setup() {
  size(800, 600);
  
  
  wave=fs.wave
  wave.p(10, 10, 10);
  wave.p(30, 5, 70);
  wave.p(10, 30, -40);

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

  fs.update();
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