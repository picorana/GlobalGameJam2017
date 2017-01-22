public class Piscina
{
  int NUM_COLONNE = 32;
  int NUM_RIGHE = 11;
  int TILESIZE = 67;
  List<Tile> acqua = new ArrayList<Tile>();
  Wave wave;
  Bomb b;
  Timer time;

  public Piscina()
  {
    
    wave=new Wave(NUM_RIGHE,NUM_COLONNE);
    for (int i=0; i<NUM_COLONNE; i++) 
      for (int j=0; j<NUM_RIGHE; j++) 
      {
        acqua.add(new Tile(j*TILESIZE ,(i*TILESIZE), j, i, wave));
        wave.p(j, i, random(-1, 1));
      }
    b = new Bomb(NUM_RIGHE,TILESIZE);
    time = new Timer();
  }

  public void display()
  {
    image(renderBellissimo,-230,0);
    
    pushMatrix();
    scale(0.3);
    translate(width/2 + 1545, height/2+ 867);
    for (Tile t : acqua)
      t.display();
    popMatrix();
    image(downRenderBellissimo,-230,0);
    time.display();
  }

  void update()
  {
    wave.update(0.04);
    time.update();
  }

  void pushInWaterLeft(float intensity)
  {
    int x=(int)Math.floor(0.1*wave.x);
    for (int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y) {
      wave.p(x, y, wave.p(x, y)+intensity);
    }
  }

  void pushInWaterRight(float intensity)
  {
    int x=(int)Math.floor(0.1*wave.x);
    for (int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y) {
      wave.p(x, y, wave.p(x, y)+intensity);
    }
  }
}