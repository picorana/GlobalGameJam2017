import hypermedia.net.*;    // import UDP library

public class Player {
    private int playerId;
    private UDP udp;

    Player(int playerId, int port) {
        this.playerId = playerId;
        this.udp = new UDP(this,port);
        udp.listen(true);
    }

    void receive(byte[] data) {
        String message = new String( data );
        String[] parts = split(message, ",");
        float value = float(parts[3]);
        if (value > 15) {
            value /= 10;
            if (playerId == 1)
                p.pushInWaterLeft(value);
            else {
                p.pushInWaterRight(value);
            }
        }
            
    }
}