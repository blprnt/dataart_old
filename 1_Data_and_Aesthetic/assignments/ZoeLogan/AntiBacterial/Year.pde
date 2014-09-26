/*Creates a circle, representing the volume of the year in which to place
 the instances of the data.
 */

class Year {

  PVector center;
  float radius;
  int count;
  ArrayList<Rat> rats = new ArrayList<Rat>();
  color myColor;


  Year (PVector _center, int _count) {
    center = _center;
    count = _count;
    radius = 170;

    for (int i = 0; i < count; i++) {
      //creates a random 'checking' point do determine if it is within the circle
      PVector rand;
      while (true) {
        //takes the diameter (-radius, radius) from center to make sure that it is in the circle
        rand = new PVector(random(-radius, radius) + center.x, random(-radius, radius) + center.y);
        PVector diff = PVector.sub(center, rand);
        //if the distance is radius -20 (so that no inner spots will be outside the ring) then keep going
        if (diff.mag() < radius-20) break;
      }

      myColor = 127;
      rats.add(new Rat( rand, color(myColor, 204, 174))) ;
    }
  }

  void draw() {
    //The Year circles

    fill(250, 255, 255);
    stroke(80, 95, 90, 20);
    strokeWeight(50);
    ellipse(center.x, center.y, radius*2, radius*2);
    fill(250, 255, 255);
    stroke(80, 95, 90, 60);
    strokeWeight(10);
    noFill();
    ellipse(center.x, center.y, radius*2, radius*2);
    stroke(100, 110, 150, 60);
    strokeWeight(6);
    noFill();
    ellipse(center.x, center.y, radius*2, radius*2);



    for (Rat r: rats) {

      r.draw();
    }
  }
}

