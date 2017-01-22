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
        }
        
        public void display()
        {
          float secondi = ms / 100;
          secondi /= 10.0;
          String timeString = Float.toString(secondi);
          text(timeString, width/2, height / 10);
        }
    }