class Chime {
  float x, y, lat, lon;
  WavePlayer wp1, wp2;
  Gain g1, g2;
  Envelope ge1, ge2;
  boolean sounding;

  float px;
  float py;
  float angle = 0;
  float radius = 3;
  float drawFrequency = 10;
  

  Chime(float _x, float _y, float _lat, float _lon, AudioContext _ac) {
    x = _x;
    y = _y;
    lat = _lat;
    lon = _lon;
    ac = _ac;
    sounding = false;

    // NYC lat/lon bounding is -74.259088,40.495996,-73.700272,40.915256
    float lonFreq = map(_lon, -74.259088, -73.700272, 880, 1760);
    float closeNote1 = findCloseNote(lonFreq);
    wp1 = new WavePlayer(ac, closeNote1, Buffer.SINE);
    ge1 = new Envelope(ac, 0.0);
    g1 = new Gain(ac, 1, ge1);
    g1.addInput(wp1);
    ac.out.addInput(g1);

    float latFreq = map(_lat, 40.495996, 40.915256, 440, 880); 
    float closeNote2 = findCloseNote(latFreq);
    wp2 = new WavePlayer(ac, closeNote2, Buffer.SINE);
    ge2 = new Envelope(ac, 0.0);
    g2 = new Gain(ac, 1, ge2);
    g2.addInput(wp2);
    ac.out.addInput(g2);
  }

  void display() {
    int value;
    if (sounding) {
      value = 100 + int(g1.getGain() * 10 * 155);
    }
    else {
      value = 100;
    }
    pushMatrix();
    translate(x, y, 0);
    strokeWeight(2);
    stroke(value, 0, 0);
    //line(0, 0, 0, 0, 0, lat);
    drawChime(-radius, -radius, lat);
    strokeWeight(2);
    stroke(value);
    //line(2, 2, 0, 2, 2, -lon);
    drawChime(radius, radius, -lon);  
    popMatrix();
  }

  void drawChime(float ox, float oy, float chimeLength) {
    //float jitterX = (noise(frameCount) * (radius)) - radius/2;
    //float jitterY = (noise(frameCount) * (radius)) - radius/2;
    pushMatrix();
    translate(ox, oy, 0);
    for (int i = 0; i < 360/drawFrequency; i++) {
      px = cos(radians(angle))*(radius);
      py = sin(radians(angle))*(radius);
      line(px, py, 0, px, py, chimeLength);
      //line(px, py, 0, px+jitterX, px+jitterY, chimeLength);
      angle -= drawFrequency;
    }
    popMatrix();
  }

  void stopNote(Envelope ge) {
    sounding = false;
    ge.clear();
    ge.addSegment(0.0, 100);
  }

  void playNote(Envelope ge, float max) {
    sounding = true;
    max *= 0.1;
    ge.addSegment(max, 20);
    ge.addSegment(max*0.8, 50);
    ge.addSegment(max*0.4, 1000);
    ge.addSegment(max*0.2, 1000);
    ge.addSegment(max*0.1, 1000);
    ge.addSegment(max*0.05, 1000);
    ge.addSegment(max*0.025, 1000);
    ge.addSegment(0.0, 1000);
  }

  void sound(float max) {
    if (random(1) > 0.9995) {
      stopNote(ge1);
      playNote(ge1, max);
      stopNote(ge2);
      playNote(ge2, max);
    }
  }

  float findCloseNote(float freq) {
    int closest;
    //float[] notes = {440.00,466.16,493.88,523.25,554.37,587.33,622.25,659.25,698.46,739.99,783.99,830.61,880.00,932.33,987.77,1046.50,1108.73,1174.66,1244.51,1318.51,1396.91,1479.98,1567.98,1661.22,1760.00};
    float[] notes = {
      440.00, 493.88, 523.25, 587.33, 659.25, 698.46, 783.99, 880.00, 987.77, 1046.50, 1174.66, 1318.51, 1396.91, 1567.98, 1760.00
    };
    float diff = abs(freq - notes[0]); 
    closest = 0;
    float oldDiff;
    for (int i = 1; i < notes.length; i++) {
      oldDiff = diff;
      diff = abs(freq - notes[i]);
      if (diff <= oldDiff) {
        closest = i;
      }
    }

    //println("freq is " + freq + " closest to " + notes[closest]);
    return notes[closest];
  }
}

