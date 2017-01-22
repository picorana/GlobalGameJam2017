import java.util.List;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PFont font;
PImage photoTileBlu;
PImage renderBellissimo;
PImage downRenderBellissimo;
PImage frogImage;
Piscina p;
Schermata statoGioco = Schermata.START;

Sound_Player sounds;

void setup()
{
  size(1024, 800);

  font = createFont("Legothick.ttf", 10);
  textFont(font);
  photoTileBlu = loadImage("blocchetto.png");
  photoTileBlu.resize(0, 10);
  renderBellissimo = loadImage("renderbellissimo.png");
  renderBellissimo.resize(0,height);
  downRenderBellissimo = loadImage("down.png");
  downRenderBellissimo.resize(0,height);
  frogImage = loadImage("froggo.png");
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
  
  sounds = new Sound_Player(this, "lego_waves_intro.vaw", "lego_waves_loop.wav", "boing.wav", "explosion.wav");
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
  sounds.playSong();
}


void gameOver()
{
  statoGioco = Schermata.GAMEOVER;
}