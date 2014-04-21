import beads.*;

public class Sonifier {

  
  AudioContext ac;

  float[] numbers;

  float maxNum = 0;
  float minNum = 0;
  
  float lowFreq = 0;
  float highFreq = 0;
  
  float pace = 100;
  
  float decay = 60;
  
  int count = 0;
  
  color fore = color(255,30,0);
  color back = color(0,0,0);

  Sonifier() {
  }

  void init(float[] na, float low, float high, float p) {
    lowFreq = low;
    highFreq = high;
    pace = p;
    numbers = na;
    maxNum = max(numbers);
    minNum = min(numbers);
    ac = new AudioContext();
    /*
  * In this example a Clock is used to trigger events. We do this
     * by adding a listener to the Clock (which is of type Bead).
     * 
     * The Bead is made on-the-fly. All we have to do is to
     * give the Bead a callback method to make notes.
     * 
     * This example is more sophisticated than the previous
     * ones. It uses nested code.
     */
    Clock clock = new Clock(ac, pace);
    clock.addMessageListener(
    //this is the on-the-fly bead
    new Bead() {
      //this is the method that we override to make the Bead do something
      public void messageReceived(Bead message) {
        Clock c = (Clock)message;
        if(c.isBeat()) {
          WavePlayer wp = new WavePlayer(ac, (float) map(numbers[count], minNum, maxNum,lowFreq,highFreq), Buffer.SINE);
          Gain g = new Gain(ac, 1, new Envelope(ac, 0.1));
          ((Envelope)g.getGainEnvelope()).addSegment(0, decay, new KillTrigger(g));
          g.addInput(wp);
          ac.out.addInput(g);

          count++;
          if (count == numbers.length) count = 0 ;
        }
      }
    }
    );
    ac.out.addDependent(clock);
    
  }
  
  void start() {
   ac.start(); 
  }

  void render() {
    loadPixels();
    //set the background
    java.util.Arrays.fill(pixels, back);
    //scan across the pixels
    for(int i = 0; i < width; i++) {
      //for each pixel work out where in the current audio buffer we are
      int buffIndex = i * s.ac.getBufferSize() / width;
      //then work out the pixel height of the audio data at that point
      int vOffset = (int)((1 + s.ac.out.getValue(0, buffIndex)) * height / 2);
      //draw into Processing's convenient 1-D array of pixels
      pixels[vOffset * height + i] = fore;
    }
    updatePixels();
  }
}

