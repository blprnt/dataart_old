class Market {

  PVector lonlat;
  PVector pos;
  float lon;
  float lat;
  String borough;
  int rectSize = 4;
  int rectWidth = 20; 
  float seconds; 

  void update() {
  }

  /*  void renderM(PGraphics pgM) {
   pgM.pushMatrix();
   pgM.translate(pos.x, pos.y);
   pgM.stroke(0, 0, 255);
   pgM.rect(0, 0, 2, 2);
   pgM.popMatrix();
   }*/

  void renderM() {
    pushMatrix();
    translate(pos.x, pos.y);
   // println("posx of drawn market" + pos.x); 
     // println("posy of drawn market" + pos.y); 
    fill(0, 255, 0, 200);
    rect(0, 0, rectSize, rectWidth);
    popMatrix();
  }
}

