public class Piscina
{

  int NUM_COLONNE = 48;
  int NUM_RIGHE = 18;
  int TILESIZE = 13;
  List<Tile> acqua = new ArrayList<Tile>();
  Wave wave;
  Bomb b;
  Timer time;
  FrogTile p1;
  FrogTile p2;
  FisicaSaltarane fs;

  public Piscina(PApplet pa)
  {

    fs=new FisicaSaltarane(pa, NUM_RIGHE, NUM_COLONNE);

    wave=fs.wave;

    for (int i=0; i<NUM_COLONNE; i++) 
      for (int j=0; j<NUM_RIGHE; j++) 
      {
        if (i == 6 && j == 8)
        {
          p1 = new FrogTile(j*TILESIZE, (i*TILESIZE), j, i, fs,frogImageFront);
          acqua.add(p1);
          
        }
        else
          if (i == 41 && j == 8)
          {
            p2 = new FrogTile(j*TILESIZE, (i*TILESIZE), j, i, fs,frogImageBack);
            acqua.add(p2);
          }
          else
            acqua.add(new Tile(j*TILESIZE, (i*TILESIZE), j, i, fs));
        wave.p(j, i, random(-0.5, 0.5));
      }
    b = new Bomb(NUM_RIGHE, TILESIZE);
    time = new Timer();
  }

  public void display()
  {
    image(renderBellissimo, -230, 0);

    pushMatrix();
    //    scale(0.3);
    translate(width/2+110, height/2-18);
    scale(-1, 1);

    for (Tile t : acqua)
      t.display();
      
    {
      float[] ball_p = fs.getBallPos();
      float isox = TILESIZE*(ball_p[0] - ball_p[1]) / 2.0;
      float isoy = TILESIZE*(ball_p[0] + ball_p[1]) / 4.0;
      isoy -= ball_p[2];
      ellipse(isox, isoy, 4, 4);

    }
    popMatrix();
    image(downRenderBellissimo, -230, 0);
    time.display();
  }

  void update()
  {
    fs.update();
    time.update();
  }

  void pushInWaterLeft(float intensity)
  {
    p1.jump();
    int x=(int)Math.floor(0.05*wave.x);
    for (int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y) {
      wave.p(x, y, wave.p(x, y)+intensity);
    }
  }

  void pushInWaterRight(float intensity)
  {
    p2.jump();
    int x=(int)Math.floor(0.95*wave.x);
    for (int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y) {
      wave.p(x, y, wave.p(x, y)+intensity);
    }
  }
}