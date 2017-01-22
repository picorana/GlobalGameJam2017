import java.util.List;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PFont font;
PImage photoTileBlu;
PImage renderBellissimo;
PImage downRenderBellissimo;
PImage frogImageFront;
PImage frogImageBack;
Piscina p;
Schermata statoGioco = Schermata.START;
Player p1;
Player p2;
Animator explosion;
void setup()
{
  size(1024, 800);

  explosion = new Animator("Explosion", "png", 12); 
  font = createFont("Legothick.ttf", 10);
  textFont(font);
  photoTileBlu = loadImage("blocchetto.png");
  photoTileBlu.resize(0, 10);
  renderBellissimo = loadImage("renderbellissimo.png");
  renderBellissimo.resize(0,height);
  downRenderBellissimo = loadImage("down.png");
  downRenderBellissimo.resize(0,height);
  frogImageBack = loadImage("froggo.png");
  frogImageBack.resize(0, 50);
  frogImageFront = loadImage("froggo_front.png");
  frogImageFront.resize(0, 50);
  p1 = new Player(1,5555);
  p2 = new Player(2,5556);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}

void draw()
{
  background(100);

  switch(statoGioco)
  {
  case START:
    {
      textSize(32);
      fill(50);
      text("PRESS S TO START NEW GAME", 10, 30);
      break;
    }

  case GIOCO:
    {
      p.update();
      p.display();
      break;
    }

  case GAMEOVER:
    {
      textSize(32);
      fill(50);
      text("PRESS C TO CONTINUE", 10, 30);
      text("GAME OVER", 400, 300);
      break;
    }
  }
}



void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  if (statoGioco == Schermata.GIOCO)
  {
    if (theOscMessage.checkTypetag("isf")) {
      int player = theOscMessage.get(0).intValue();  // get the first osc argument
      String direction = theOscMessage.get(1).stringValue(); // get the second osc argument
      float intensity = theOscMessage.get(2).floatValue(); // get the third osc argument



      if (player == 1)
        p.pushInWaterLeft(intensity);
      else
        p.pushInWaterRight(intensity);
      return;
    }
  }
}




void startGame()
{
  p = new Piscina(this);
  statoGioco = Schermata.GIOCO;
}


void gameOver()
{
  statoGioco = Schermata.GAMEOVER;
}