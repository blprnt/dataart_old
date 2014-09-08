class Spring extends VerletSpring2D {
  float thick;


 Spring(Particle p1, Particle p2, float len, float strength, float thickness) {
    super(p1, p2, len, strength);
    thick = thickness;
  }

  void display() {
    strokeWeight(thick);
    stroke(255);
    line(a.x, a.y, b.x, b.y);
  }
}


