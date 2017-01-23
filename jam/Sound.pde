

class Sound_Player {

SoundFile song_body, song_intro, boing, explosion, salto, voice, gover;
Boolean song_playing = false;

  Sound_Player(PApplet sketch,  String _intro, String _song, String _boing, String _explosion, String _salto, String  _voice, String _gover){
    song_intro = new SoundFile(sketch, _intro);
    song_body = new SoundFile(sketch, _song);

    boing = new SoundFile(sketch, _boing);
    explosion = new SoundFile(sketch, _explosion);
    salto = new SoundFile(sketch, _salto);
    voice = new SoundFile(sketch, _voice);
    gover = new SoundFile(sketch, _gover);
    salto.amp(0.6);
    song_intro.amp(0.1);
    song_body.amp(0.2);
    song_intro.loop();
  }

  void playSong(){
    song_intro.stop();
    voice.play();
    
    if (!song_playing){
      song_body.loop();
      song_playing = true;
    }

}

  void playBoing(){
    salto.play();
  }

  void playSalto(){
    salto.play();
    
  }
  void playExplosion(){
    explosion.play();
  }

   void playVoice(){
    voice.play();
  }
  
   void playGAMEOVER(){
    gover.play();
  }

  void songVolumeUP(){
  song_body.amp(1);

  }

  void songVolumeDOWN(){
    song_body.amp(0.5);
  }


}