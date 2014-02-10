class Particle {
 PVector loc;
 PVector newLoc;

Particle( float x, float y){
 loc = new PVector (x,y);
}

void display(){
  fill(0);
  stroke(255,0,0);
  ellipse(loc.x,loc.y, 3,3);
}

void update(){
  
}
  
}
