public class FrogTile extends Tile
{
  FrogTile(float x, float y, int indexX, int indexY, FisicaSaltarane fs) {
    super(x, y, indexX, indexY, fs);
  } 
  @Override
    public void display()
  {
    super.display();
    image(frogImage,super.isoX,super.isoY);
  }
}