import java.util.List;

PImage photoTileBlu;
int NUM_COLONNE = 10;
int NUM_RIGHE = 10;
int TILESIZE = 65;
List<Tile> piscina = new ArrayList<Tile>();
void setup()
{
  size(800, 800);
  photoTileBlu = loadImage("tile.png");
  for (int i=0; i<NUM_COLONNE; i++) {
    for (int j=0; j<NUM_RIGHE; j++) {
      piscina.add(new Tile(i*TILESIZE, j*TILESIZE));
    }
  }
}

void draw()
{
  pushMatrix();
  translate(width/2, height/2);
  for (Tile t : piscina)
    t.display();
  popMatrix();
}