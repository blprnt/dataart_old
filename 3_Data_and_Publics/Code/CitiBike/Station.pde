class Station {
 
  int totalDocks;
  int availableDocks;
  
  PVector pos;
  
  void update() {
    
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(255);
    line(0,0,0,totalDocks);
    
    stroke(255,0,0);
    line(0,0,0,availableDocks);
    popMatrix();
    
  }
  
}
