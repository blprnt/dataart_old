class Particle extends VerletParticle2D {
  float radius;
  PVector self;
  PVector con;
  PVector calculatedVector;
  int count;
  String word;
  float transp = 50;

  boolean flicker = true;

  Particle(float x, float y, float rad, String w) {
    super(x, y);
    connections = new ArrayList<Particle>();
    radius =random(5,10);
    PVector self = new PVector(x,y);
    count = 0;
    word = w;
  }

  void addConnection(Particle p) {
    connections.add(p);    
  }


 PVector getBranchDirection() {
   calculatedVector = new PVector(0, 0);
   for (Particle p : connections) {
     PVector dir = new PVector(p.x-x, p.y-y);
     calculatedVector.add(dir);
   }
   calculatedVector.normalize();
   calculatedVector.mult(-1);
   calculatedVector.mult(50);
    return calculatedVector;
  }
  
  int countConnections(){   
     for (Particle p : connections) {
       count=count+1;
       println("adding to counter:"+ count);
     }
     return count;
  }

void flicker(){
   if (radius< 1) flicker = true;
    if (flicker == true){
      radius=radius+.1;
      transp= transp+1;
    }
    
    if (radius > 10) flicker = false;
    if (flicker == false){
      radius = radius-.1;
     transp= transp-1; 
    } 
  }

  void display() {
    fill(250,255,190,90);
    ellipse (x, y, 3, 3);
    stroke (255,transp);
    strokeWeight(radius);
    
    line(x,y, x+radius,y);
    line(x,y, x-radius,y);
    line(x,y, x,y+radius);
    line(x,y, x,y-radius);
    fill(255);
    text(word, x+10,y+10);
  }

  boolean contains(int x, int y) {
    float d = dist(x, y, this.x, this.y);
    if (d <= 15) { 
      return true;
    }
    else 
      return false;
  }
}

