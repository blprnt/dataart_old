//Ju Young Park
//Data Art 2014
//Mar.10.2014

// A circular particle

class Particle {

  // We need to keep track of a Body and a radius
  Body body;
  float r;
  float a;
  String w;
  int size;

  Particle(float x, float y, float r_, String word, int i) {
    r = r_;
    w = word;
    size = i;
    // This function puts the particle in the Box2d world
    makeBody(x,y,r);
    a = random(0, -HALF_PI);
    
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }

  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    
    pushMatrix();
    translate(pos.x,pos.y);
    //rotate(-a);
    //rotate(-HALF_PI);
    fill(255,46,231);
    textSize(size*0.1);
    //rotate(random(0, -HALF_PI));
    text(w, 0, 0);
    popMatrix();
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(25);
    //cs.m_radius = box2d.scalarPixelsToWorld(size*0.2);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 5;
    fd.friction = 0.3;
    fd.restitution = 0.3;
    
    // Attach fixture to body
     body.createFixture(fd);

    // Give it a random initial velocity (and angular velocity)
    body.setLinearVelocity(new Vec2(random(-10f,10f),random(5f,10f)));
    body.setAngularVelocity(random(-10,10));
    
    a = body.getAngle();
  }






}


