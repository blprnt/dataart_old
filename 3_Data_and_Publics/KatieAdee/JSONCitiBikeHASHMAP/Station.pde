class Station {
  int id;
  int totalDocks;
  int availableDocks;  
  PVector pos;
  PVector cpos;
  
  void update(){
    
  }
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(02,70,145,150);
    ellipse(0,0,sqrt(totalDocks), sqrt(totalDocks));
    fill(255,0,0);
    ellipse(0,0,sqrt(availableDocks), sqrt(availableDocks));
    popMatrix();
  }
  
  void graph(){
    pushMatrix();
    translate(cpos.x, cpos.y);
    stroke(255);
    strokeWeight(3);
    line(0,0,0,-totalDocks*6);
    stroke(255,0,0);
    line(0,0,0,-availableDocks*6);
    popMatrix();
  }

}

