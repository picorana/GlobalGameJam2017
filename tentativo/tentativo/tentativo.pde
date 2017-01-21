PImage cubetto;
int NUM_COLONNE = 70;
int NUM_RIGHE = 70;
int TILESIZE = 65;

Wave wave;

void setup(){
  size(800, 800);
  cubetto = loadImage("tile.png");  
  wave=new Wave(NUM_COLONNE, NUM_RIGHE);
  
  for(int x=0; x<wave.x; ++x){
    for(int y=0; y<wave.y; ++y){
    wave.p(x, y, random(-1, 1)); 
    }
  }
}
boolean left_arrow_pressed=false;
boolean right_arrow_pressed=false;
void draw(){
  
  if(left_arrow_pressed){ 
    int x=(int)Math.floor(0.1*wave.x);
    for(int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y){
      wave.p(x, y, wave.p(x, y)+2);
    }
  }
  if(right_arrow_pressed){
    int x=(int)Math.floor(0.9*wave.x);
    for(int y=(int)Math.floor(0.5*wave.y); y<Math.ceil(0.9*wave.y); ++y){
      wave.p(x, y, wave.p(x, y)+2);
    }
  }

  background(100);
  wave.update(0.04);
  pushMatrix();
  translate(width/2, height/2);
  for (int i=0; i<NUM_COLONNE; i++){
    for (int j=0; j<NUM_RIGHE; j++){
        PVector pos = new PVector(i*TILESIZE, j*TILESIZE);
        toIsometric(pos);
        image(cubetto, pos.x, pos.y-wave.p(i, j));
    }
  }
  popMatrix();
}

void toIsometric(PVector v){
    float isoX = (v.x - v.y) / 2.0;
    v.y = (v.x + v.y) / 4.0;
    v.x = isoX;
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