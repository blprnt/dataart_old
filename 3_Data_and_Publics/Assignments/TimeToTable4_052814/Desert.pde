class Desert {

  //real data 
  PVector lonlat; 
  float seconds; 
  float miles; 
  Market closestM;    //= new Market();
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

  void renderD() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255, 0, 0);
    rect(0, 0, rectSize, rectWidth);
    popMatrix();
  }
}

