/*

Display class for the OpenPaths pathpoints

*/

class PathPoint {
 
  PVector lonLat = new PVector();
  PVector screenPos = new PVector();
  String dateString;
  
  void update() {
    
  }
  
  //Note that the render function requires a PGraphics objec to be passed
  //If you want to draw to the main canvas, just pass 'g'.
  void render(PGraphics c) {
    c.pushMatrix();
      c.translate(screenPos.x, screenPos.y);
      c.fill(255);
      c.rect(0,0,3,3);
    c.popMatrix();
  }
  
}
