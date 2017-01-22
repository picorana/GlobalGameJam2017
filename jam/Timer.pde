    public class Timer {
        private int ms = 60000;
        private int lastmillis;

        public Timer() {
            this.lastmillis = millis();
        }

        public void update() {
            int delta = millis() - this.lastmillis;
            ms -= delta;
            lastmillis = millis();
            if(ms < 0)
                gameOver();
        }
        
        public void display()
        {
          float secondi = ms / 100;
          secondi /= 10.0;
          String timeString = Float.toString(secondi);
          strokeWeight(20);
          //fill(255,255,255,127);
          textSize(65);
          text(timeString, width/2 - 20, height / 10);
        }
    }