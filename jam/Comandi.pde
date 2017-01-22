
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
  if(statoGioco==Schermata.GIOCO){
      if(keyCode==LEFT){
        p.pushInWaterRight(-2);
      }

      if(keyCode==RIGHT){
        p.pushInWaterLeft(-2);
      }
    }

}