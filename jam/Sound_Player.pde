

class Sound_Player {

SoundFile song_body, song_intro, boing, explosion;

	Sound_Player(PApplet sketch,  String _intro, String _song, String _boing, String _explosion){
		song_intro = new SoundFile(sketch, _intro);
		song_body = new SoundFile(sketch, _song);

		boing = new SoundFile(sketch, _boing);
		explosion = new SoundFile(sketch, _explosion);
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

	void playExplosion(){
		explosion.play();
	}

	void songVolumeUP(){
		song.amp(1);

	}

	void songVolumeDOWN(){
		song.amp(0.5);
	}


}

