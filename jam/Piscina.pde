public class Piscina
{
  int NUM_COLONNE = 10;
  int NUM_RIGHE = 10;
  int TILESIZE = 65;
  List<Tile> acqua = new ArrayList<Tile>();
  Wave wave;
  Bomb b;


  public Piscina()
  {
    wave=new Wave(NUM_COLONNE, NUM_RIGHE);
    for (int i=0; i<NUM_COLONNE; i++) 
      for (int j=0; j<NUM_RIGHE; j++) 
      {
        acqua.add(new Tile(i*TILESIZE, j*TILESIZE, i, j, wave));
        wave.p(i, j, random(-1, 1));
      }
    b = new Bomb(NUM_RIGHE,TILESIZE);
  }

  public void display()
  {
    pushMatrix();
    translate(width/2, height/2);
    for (Tile t : acqua)
      t.display();
    popMatrix();
  }

  void update()
  {
    wave.update(0.04);
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