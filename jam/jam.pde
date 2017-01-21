import java.util.List;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


PImage photoTileBlu;
Piscina p;
Schermata statoGioco = Schermata.START;
void setup()
{
  size(800, 800);

  photoTileBlu = loadImage("tile.png");
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
      text("Press s to start a new game", 10, 30);
      p = new Piscina();
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
      text("Press c to continue", 10, 30);
      text("GameOver", 400, 300);
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