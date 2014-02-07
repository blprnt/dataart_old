class Particle {
 PVector loc;
 PVector newLoc;

Particle( float x, float y){
 loc = new PVector (x,y);
}

void display(){
  fill(0);
  noStroke();
  ellipse(loc.x,loc.y, 3,3);
}

void update(){
  
}
  
}
