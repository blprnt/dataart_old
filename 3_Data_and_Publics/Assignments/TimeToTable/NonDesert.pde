class NonDesert {

  //real data 
  PVector lonlat; 
  float seconds; 
  float miles; 
  Market closestM; 
  Mover mover; 


  //for position and draw
  PVector pos;
  float lon;
  float lat;
  String borough;
  int rectSize = 4;
  int rectWidth = 20; 

  void update() {
  }

  /* void rendernD(PGraphics pg) {
   pg.pushMatrix();
   pg.translate(pos.x, pos.y);
   pg.fill(255, 0, 0);
   pg.rect(0, 0, 2, 2);
   pg.popMatrix();
   }*/

  void renderND() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255);
    rect(0, 0, rectSize, rectWidth);
    popMatrix();
  }

  void renderLines() {
    //    pushMatrix();
    // translate(0, 0);
    stroke(150, 255, 100, 100);
    //strokeWeight(4); 
    line(pos.x, pos.y, closestM.pos.x, closestM.pos.y);
    // line(pos.x, pos.y, 400, 400);

    //    line(pos.x, pos.y, closestM.pos.x, -500);
    //    line(pos.x, pos.y, -10, -500);
    //    rect(pos.x, pos.y, rectSize, 10);
    //    popMatrix();
  }
}

