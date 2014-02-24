class Line {
  PVector mp;
  PVector mp1;
  PVector mp2;
  PVector sp;
  PVector ep;
  float hits;
  float h;
  float w;
  float m;


  Line(float _x, float _y, int _hits) {
    mp = new PVector(_x, _y);
    hits = _hits;
  }

  void display() {    
    h = map(hits, 0, max(totals),  0, height/2);
    w = map(hits, 0, max(totals),  0, 20);
    PVector mp1 = new PVector(mp.x+w,mp.y);
    PVector mp2 = new PVector(mp.x-w,mp.y);
    PVector sp = new PVector(mp.x, mp.y+h);
    PVector ep = new PVector(mp.x, mp.y-h);
//    ellipse(mp.x,mp.y,  5,5);
//    ellipse(mp.x, mp.y+h,10,10);
//    ellipse(mp.x, mp.y-h,10,10);
    bezierBetweenPoints(sp,ep,mp1);
    bezierBetweenPoints(sp,ep,mp2);
  }

  void bezierBetweenPoints(PVector start, PVector end, PVector middle) {
    PVector cp1 = new PVector(start.x, start.y, start.z);
    cp1.lerp(middle, 0.5);
    PVector cp2 = new PVector(end.x, end.y, end.z);
    cp2.lerp(middle, 0.5);
    //anchor control conrtol anchor
    stroke(255,100);
    strokeWeight(2);
    bezier(start.x, start.y, cp1.x, cp1.y, cp2.x, cp2.y, end.x, end.y);
  }
}

