
class Animator{
  Animator(String basePath, String extension, int number ){
    if (number > 99)
      println("THE animator acepts no more than 99 frames");

    frames = new PImage[number];
    for (int i = 0 ; i<number ; i++ ) {
      frames[i] = new PImage();
      try{
        frames[i] = loadImage( basePath + i + "." +extension);
      
      } catch (Exception e){
        println("Cant find the file: " + basePath + number + "." +extension );
        break;
      }
      
    }
    counter = 0;

  }

void start(){
  counter = 0;
}

boolean update(int x, int y){
  if (round(counter/2) >= frames.length)
    return false;

 
  image(frames[round(counter/2)], x, y);
  //println(round(counter/2));
  counter+=0.5;
  return true;
  

}

private PImage[] frames;
private float counter;


}