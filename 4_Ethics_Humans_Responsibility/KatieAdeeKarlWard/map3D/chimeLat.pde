class Chime {
  float x, y, lat, lon;

  Chime(float _x, float _y, float _lat, float _lon) {
    x = _x;
    y = _y;
    lat = _lat;
    lon = _lon;
  }

  void display() {
    pushMatrix();
    translate(x,y,0);
    strokeWeight(2);
    stroke(255, 0, 0);
    line(0,0, 0, 0,0, lat);
    strokeWeight(2);
    stroke(255);
    line(2,2, 0, 2,2, -lon);    
    popMatrix();
  }
}

