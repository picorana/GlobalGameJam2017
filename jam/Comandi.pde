
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