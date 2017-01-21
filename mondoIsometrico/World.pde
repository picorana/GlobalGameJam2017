class World {
  
  World() {
    
    
  }

  PVector getScreenPosition(PVector loc) {

    PVector positionOnScreen = new PVector();

    positionOnScreen.x = (loc.x - loc.y) / 2.0;
    positionOnScreen.y = (loc.x + loc.y) / 4.0;

    return positionOnScreen;
  }

  PVector getRealPosition(PVector onScreenPoint) {
    PVector realPosition = new PVector();

    realPosition.x = onScreenPoint.x + 2.0 * onScreenPoint.y;
    realPosition.y = - onScreenPoint.x + 2.0 * onScreenPoint.y;

    return realPosition;
  }
  static final int TILE_SIZE = 19;
  void renderTile(float x, float y) {
    
    
    /*
    line(x - (TILE_SIZE >> 1), y, x, y - (TILE_SIZE >> 2) ); //>> è il bitshift
    line(x + (TILE_SIZE >> 1), y, x, y - (TILE_SIZE >> 2) );
    line(x - (TILE_SIZE >> 1), y, x, y + (TILE_SIZE >> 2) );
    line(x + (TILE_SIZE >> 1), y, x, y + (TILE_SIZE >> 2) );
    */
    
    image(photoTileBlu,x,y);
  }

  void render() {

    PVector brush;

    for (int i = -(TILE_SIZE * (TILENUMBER/2 - 1)); i <= TILE_SIZE * (TILENUMBER/2); i += TILE_SIZE)
      for (int j = TILE_SIZE * (TILENUMBER/2); j >= -(TILE_SIZE * (TILENUMBER/2 - 1)); j -= TILE_SIZE) 
      {
        PVector realTilePosition = new PVector(i, j);
        brush = getScreenPosition(realTilePosition);

        int intensity;
        /*
        int intensity = int(realTilePosition.dist(isoMouse));
         
         if (intensity > 200)
         */
        intensity = 200;

        brush.z = intensity;

        stroke(0, 128, 60, 200 - intensity);
        renderTile(brush.x, brush.y + 100 - (brush.z / 2));


        stroke(255, 0, 128, intensity);

        renderTile(brush.x, brush.y - 100 + (brush.z / 2));
      }

    //Disegna una tile che è il cursore del mouse, non ci serve.
    /*   
     PVector isoMouseTile = getScreenPosition(isoMouse);
     
     stroke(255, 255, 0, 128);
     renderTile(isoMouseTile.x, isoMouseTile.y); 
     */
  }
}