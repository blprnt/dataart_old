class Station {

  int totalDocks;
  int availableDocks;

  PVector pos = new PVector();
  PVector tpos = new PVector();

  ArrayList<Bike> bikes = new ArrayList();

  void update() {
    pos.lerp(tpos, 0.1);
    for (Bike b:bikes) b.update();
    
    //clear out all of the dead bikes
    ArrayList<Bike> tempBikes = new ArrayList();
    for(Bike b:bikes) {
      if (b.alive) tempBikes.add(b);
    }
    bikes = tempBikes();
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(255);
    line(0, 0, 0, totalDocks);

    stroke(255, 0, 0);
    line(0, 0, 0, availableDocks);

    for (Bike b:bikes) b.render();
    popMatrix();
  }

  void updateDocks(int avail) {
    int change = avail - availableDocks;
    availableDocks = avail;
    launchBikes(change);
  }

  void launchBikes(int change) {
    tpos.y += change * 5;
    for (int i = 0; i < abs(change); i++) {
      Bike b = new Bike();
      if (change > 0) {
        b.velocity = new PVector(0, random(-0.1, -0.3));
      } else {
        b.pos.y = height - pos.y;
        b.velocity = new PVector(0, random(-0.1, -0.3));
        b.incoming = true;
      }
      bikes.add(b);
    }
  }
}

