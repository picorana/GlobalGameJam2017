
void keyPressed() {
  switch(statoGioco)
  {
  case START:
    {
      if (keyCode=='S' || keyCode=='s') {
        p = new Piscina();
        statoGioco = Schermata.GIOCO;
      }
    }

  case GIOCO:
    {
      if (keyCode=='t' || keyCode=='T')
        statoGioco = Schermata.GAMEOVER;
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