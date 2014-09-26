

class Rat {

  PVector location;
  float radius;
  color myColor;

  Rat(PVector loc, color c) {

    location = loc;
    radius = random(10,16);
    myColor = c;
  }

  void draw() {
    stroke(97, 255, 91, 10);
    strokeWeight(1);
    fill(97, 127, 91, random(80, 100) );
    ellipse(location.x, location.y, radius*2, radius*2);
    noFill();
    stroke(150, 150, 150, 50);
    strokeWeight(2);
    ellipse(location.x, location.y, radius*2, radius*2);
    stroke(180, 180, 180, 50);
    strokeWeight(10);
    ellipse(location.x, location.y, radius*2, radius*2);
    noStroke();
    //    fill(255, 251, 199, 90);
    fill(255, 68, 175, 60);
    stroke(255, 68, 175, 20);
    ellipse(location.x, location.y, radius/2, radius/2);
  }
}

