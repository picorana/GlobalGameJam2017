PImage cubetto;
int NUM_COLONNE = 10;
int NUM_RIGHE = 10;
int TILESIZE = 65;

void setup(){
  size(800, 800);
  cubetto = loadImage("tile.png");  
}

void draw(){
  pushMatrix();
  translate(width/2, height/2);
  for (int i=0; i<NUM_COLONNE; i++){
    for (int j=0; j<NUM_RIGHE; j++){
        PVector pos = new PVector(i*TILESIZE, j*TILESIZE);
        toIsometric(pos);
        image(cubetto, pos.x, pos.y);
    }
  }
  popMatrix();
}

void toIsometric(PVector v){
    float isoX = (v.x - v.y) / 2.0;
    v.y = (v.x + v.y) / 4.0;
    v.x = isoX;
}