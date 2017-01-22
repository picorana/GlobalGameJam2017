public class FrogTile extends Tile
{
  
  
  FrogTile(float x, float y, int indexX, int indexY, Wave wave) {
    super(x, y, indexX, indexY, wave);
  } 
  @Override
    public void display()
  {
    super.display();
    image(frogImage,super.isoX,super.isoY);
  }
}