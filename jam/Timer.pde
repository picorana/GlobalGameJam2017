    public class Timer {
        private int ms = 60000;
        private int lasmillis;

        public Timer() {
            this.lastmillis = millis();
        }

        public void update() {
            int delta = millis() - this.lastmillis;
            ms -= delta;
            lastmillis = millis();
        }
    }