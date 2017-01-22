public class Tile
{
  static final int TILESIZE = 65;
  PVector location;
  float isoX = 0;
  float isoY = 0;
  int indexX;
  int indexY;
  FisicaSaltarane fs;
  
  Tile(float x, float y,int indexX, int indexY, FisicaSaltarane fs) {
    location = new PVector();
    location.x = x;
    location.y = y;
    this.indexX = indexX;
    this.indexY = indexY;
    this.fs = fs;
  }

   PVector toIsometric(PVector v)
  {
    PVector iso = new PVector();
    iso.x = (v.x - v.y) / 2.0;
    iso.y = (v.x + v.y) / 4.0;
    return iso;
  
}
  
  void display()
  {
   PVector isoL = toIsometric(location);
   isoX = isoL.x;
   isoY = isoL.y - fs.getWavePos(indexX, indexY);
   image(photoTileBlu, isoX, isoY);
  }
}