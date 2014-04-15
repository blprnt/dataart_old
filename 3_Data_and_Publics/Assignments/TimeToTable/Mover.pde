class Mover {


  //PVector desert; //origin
  //PVector closestM; //destination
  PVector velocity; 
  PVector acceleration; 
  float seconds; 
  float topspeed; 
  PVector pos; 
  
  Mover(PVector _pos, float _topspeed, float _time){
    pos = _pos;
    topspeed = _topspeed;
    seconds = _time;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    println("i am made: "+pos);
  }

  void update(PVector desert, PVector closestM) {
    println("closestM" + closestM); 
    println("desert" + desert); 
    PVector acceleration = PVector.sub(closestM, pos); 
    
//    println("acceleration" + acceleration); 
//   // println("closestM" + closestM); 
//   // println("desert" + desert); 

float s = map(seconds, 156, 158007, 0, 1);

   acceleration.setMag(seconds); 
   velocity.add(acceleration); 
    velocity.limit(topspeed); 
   pos.add(velocity);
  }

  void display() {
    stroke(0); 
    strokeWeight(2); 
    fill(255, 100); 
    noStroke(); 
    ellipse(pos.x, pos.y, 4, 4);
  }
}



