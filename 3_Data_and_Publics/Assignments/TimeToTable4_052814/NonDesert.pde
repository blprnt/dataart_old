class NonDesert {

  //real data 
  PVector lonlat; 
  float seconds; 
  float miles; 
  
  Market closestM; 
  Mover mover; 

  //for position and draw
  PVector pos;
  float lon;
  float lat;
  String borough;
  int rectSize = 4;
  int rectWidth = 20; 

  void update() {
  }

  void renderND() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255);
    rect(0, 0, rectSize, rectWidth);
    popMatrix();
  }
}

