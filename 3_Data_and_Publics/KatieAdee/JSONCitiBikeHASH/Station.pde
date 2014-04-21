class Station {
  int id;
  int totalDocks;
  int availableDocks;  
  PVector pos;
  
  void update(){
    
  }
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(255);
    strokeWeight(3);
    line(0,0,0,-totalDocks*6);
    stroke(255,0,0);
    line(0,0,0,-availableDocks*6);
    popMatrix();
  }
  


}

