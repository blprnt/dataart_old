class Bike {
 
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  PVector velocity = new PVector();
  
  boolean incoming = false;
  boolean alive = true;
  
  void update() {
   pos.add(velocity);
   
   //check if we should die
   if( (incoming && pos.y < 0) || (!incoming && pos.y < -height/2)) alive = false;
  }
  
  void render() {
   pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(255);
    ellipse(0,0,5,5);
   popMatrix(); 
  }
  
}
