
void keyPressed() {
  switch(statoGioco)
  {
  case START:
    {
      if (keyCode=='S' || keyCode=='s') 
        startGame();
      break;
    }

  case GIOCO:
    {
      if (keyCode=='t' || keyCode=='T')
        gameOver();
      
      if(keyCode==LEFT){
        p.pushInWaterLeft(-5.5 + random(-0.5, 0.5));
      }

      if(keyCode==RIGHT){
        p.pushInWaterRight(-5.5+ random(-0.5, 0.5));
      }

      if (keyCode=='S' || keyCode=='s') 
        startGame();

      break;
    }

  case GAMEOVER:
    {
      if (keyCode=='C' || keyCode=='c')
        statoGioco = Schermata.START;
      break;
    }
  }
}

void keyReleased() {
}