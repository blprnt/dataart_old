class Mover {

  PVector velocity; 
  PVector acceleration; 
  float seconds; 
  float topspeed; 
  PVector pos; 
  PVector fPos;
  
  Market closestM; 

  float globalSpeed = 1;

  Mover(PVector _pos, float _topspeed, float _time, PVector _fPos) { //need to add a destination (closestM to the arguments)
    pos = _pos;
    fPos = _fPos; 
    topspeed = _topspeed;
    seconds = _time;
    velocity = new PVector(0, 0);
    //    acceleration = new PVector(0, 0);
  }

  void init(PVector start, PVector end) {
    pos.set(start.x, start.y);
    velocity = PVector.sub(end, start);
    velocity.div(seconds * frameRate);
  }

  void update() {
    //map the seconds so that they are all in whatever.
    float s = map(seconds, 156, 158007, 0, 1000);
    println("this is s:" + s); 

    velocity.mult(s);
    pos.add(velocity);
    println("this is pos:" + pos); 
  }

  void display() {
    stroke(0); 
    strokeWeight(2); 
    fill(255, 100); 
    noStroke(); 
    ellipse(pos.x, pos.y, 4, 4);
  }
}

