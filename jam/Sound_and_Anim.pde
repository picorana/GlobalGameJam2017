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
  println(round(counter/2));
  counter+=0.5;
  return true;
  

}

private PImage[] frames;
private float counter;


}



class Sound_Player {

SoundFile song_body, song_intro, boing, explosion, salto;

	Sound_Player(PApplet sketch,  String _intro, String _song, String _boing, String _explosion, String _salto){
		song_intro = new SoundFile(sketch, _intro);
		song_body = new SoundFile(sketch, _song);

		boing = new SoundFile(sketch, _boing);
		explosion = new SoundFile(sketch, _explosion);
    salto = new SoundFile(sketch, _salto);
		song_intro.loop();
	}

	void playSong(){
		song_intro.stop();
		boing.play();
		song_body.loop();
	}

	void playBoing(){
		boing.play();
	}

  void playSalto(){
    salto.play();
  }
	void playExplosion(){
		explosion.play();
	}

	void songVolumeUP(){
	song_body.amp(1);

	}

	void songVolumeDOWN(){
		song_body.amp(0.5);
	}


}