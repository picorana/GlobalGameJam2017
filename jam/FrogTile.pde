public class FrogTile extends Tile
{
  PImage frogImage;
  float easing = 0.14;
  float frogX;
  float frogY;
  float gravity = 1.0;
  float offsetJump = 0.0;
  boolean alive=true;
  FrogTile(float x, float y, int indexX, int indexY, FisicaSaltarane fs, PImage frogImage) {
    super(x, y, indexX, indexY, fs);
    this.frogImage = frogImage;
    frogX = x;
    frogY = y;
    
    if(indexY == 40)
        println("ok");
  } 
  @Override
    public void display()
  {
    super.display();
    this.update();
    if(alive){
      float dx = super.isoX -frogX;
      float dy = super.isoY -frogY;
      frogX += dx * easing;
      frogY += dy * easing;
      image(frogImage, frogX, frogY - 30 + offsetJump);
    }
  }
  
  public void jump()
  {
    offsetJump = -30.0;
  }
  
  public void die(){
    this.alive=false;  
  }
  
  public void update()
  {
    if(offsetJump < 0)
        offsetJump += gravity;
    
  }
}