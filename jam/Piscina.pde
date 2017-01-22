public class Piscina
{
 int NUM_COLONNE = 18;//48;
  int NUM_RIGHE = 48;//18;
  int TILESIZE = 13;
  List<Tile> acqua = new ArrayList<Tile>();
  Wave wave;
  Bomb b;
  Timer time;
  FrogTile p1;
  FrogTile p2;
  
  FisicaSaltarane fs;
  PImage bomb;
  public Piscina(PApplet pa)
  {
    
    fs=new FisicaSaltarane(pa, NUM_RIGHE, NUM_COLONNE);

    wave=fs.wave;

    for (int i=0; i<NUM_COLONNE; i++) 
      for (int j=0; j<NUM_RIGHE; j++) 
      {
          if (j == 3 && i == 10)
        {
          p1 = new FrogTile(j*TILESIZE, (i*TILESIZE), j, i, fs,frogImageFront);
          acqua.add(p1);
          
        }
        else
          if (j == 44 && i == 10)
          {
            p2 = new FrogTile(j*TILESIZE, (i*TILESIZE), j, i, fs,frogImageBack);
            acqua.add(p2);
          }
        else
          acqua.add(new Tile(j*TILESIZE ,(i*TILESIZE), j, i, fs));
        wave.p(j, i, random(-0.01, 0.01));
      }
    b = new Bomb(NUM_RIGHE,TILESIZE);
    time = new Timer();
     bomb = loadImage("Pong.png");
  }
  
  boolean expl_now=false;
  
  int expx=0;
  int expy=0;
  
  public void display()
  {
    image(renderBellissimo,-230,0);
    
    pushMatrix();
    translate(width/2+110, height/2-18);
    scale(-1, 1);

    for (Tile t : acqua)
      t.display();
      
    if(!expl_now){
      float[] ball_p = fs.getBallPos();
      float isox = TILESIZE*(ball_p[0] - ball_p[1]) / 2.0;
      float isoy = TILESIZE*(ball_p[0] + ball_p[1]) / 4.0;
      isoy -= ball_p[2];
      imageMode(CENTER);
      pushMatrix();
      translate(isox, isoy);
      rotate(3000*ball_p[3]);
      translate(-isox, -isoy);
      image(bomb, isox, isoy, 40,40);
      popMatrix();
      imageMode(CORNER);
      
      if(ball_p[0]<0){
        expl_now=true;
        explosion.start();
        expx=350;
        expy=250;
        p1.die();
      }
      
      if(ball_p[0]>fs.wf.wave.x){
        expl_now=true;
        explosion.start();
        expx=100;
        expy=400;
        p2.die();
      }
    }
    popMatrix();
    image(downRenderBellissimo,-230,0);
    time.display();
        if(expl_now){
          if(!explosion.update(expx, expy)){
             startGame(); 
          }
        }
  }

  void update()
  {
    fs.update();
    time.update();
  }

  void pushInWaterLeft(float intensity)
  {
    if(p2.alive){
      p2.jump();
      int x=(int)Math.floor(0.95*wave.x);
      for (int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y) {
        wave.p(x, y, wave.p(x, y)+intensity);
      }
    }
  }

  void pushInWaterRight(float intensity)
  {
    if(p1.alive){
      p1.jump();
      int x=(int)Math.floor(0.05*wave.x);
      for (int y=(int)Math.floor(0.3*wave.y); y<Math.ceil(0.7*wave.y); ++y) {
        wave.p(x, y, wave.p(x, y)+intensity);
      }
    }
  }
}