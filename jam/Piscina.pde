public class Piscina
{
 int NUM_COLONNE = 48;
  int NUM_RIGHE = 18;
  int TILESIZE = 13;
  List<Tile> acqua = new ArrayList<Tile>();
  Wave wave;
  Bomb b;
  Timer time;
  
  FisicaSaltarane fs;

  public Piscina(PApplet pa)
  {
    
    fs=new FisicaSaltarane(pa, NUM_RIGHE, NUM_COLONNE);

    wave=fs.wave;

    for (int i=0; i<NUM_COLONNE; i++) 
      for (int j=0; j<NUM_RIGHE; j++) 
      {
        acqua.add(new Tile(j*TILESIZE ,(i*TILESIZE), j, i, fs));
        wave.p(j, i, random(-0.5, 0.5));
      }
    b = new Bomb(NUM_RIGHE,TILESIZE);
    time = new Timer();
  }

  public void display()
  {
    image(renderBellissimo,-230,0);
    
    pushMatrix();
//    scale(0.3);
    translate(width/2+110, height/2-18);
    for (Tile t : acqua)
      t.display();
    popMatrix();
    image(downRenderBellissimo,-230,0);
    time.display();
  }

  void update()
  {
    fs.update();
    time.update();
  }

  void pushInWaterLeft(float intensity)
  {
    int y=(int)Math.floor(0.1*wave.y);
    for (int x=(int)Math.floor(0.3*wave.x); x<Math.ceil(0.7*wave.x); ++x) {
      wave.p(x, y, wave.p(x, y)+intensity);
    }
  }

  void pushInWaterRight(float intensity)
  {
    int y=(int)Math.floor(0.9*wave.y);
    for (int x=(int)Math.floor(0.3*wave.x); x<Math.ceil(0.7*wave.x); ++x) {
      wave.p(x, y, wave.p(x, y)+intensity);
    }
  }
}