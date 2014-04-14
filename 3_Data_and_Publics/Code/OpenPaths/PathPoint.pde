/*

Display class for the OpenPaths pathpoints

*/

class PathPoint {
 
  PVector lonLat = new PVector();
  PVector screenPos = new PVector();
  String dateString;
  Date pointDate;
  long pointTime;
  float timeFraction;
  
  color col = #FF3300;
  
  //split this up 
  Date pointDate; 
  long pointTime; 
  
  //this is so you can place the times in a fraction. 
  float timeFraction; 
  
  color col= #FF3000; 
  void update() {
    
  }
  
  //Note that the render function requires a PGraphics object to be passed
  //If you want to draw to the main canvas, just pass 'g'.
  void render(PGraphics c) {
    c.pushMatrix();
      c.translate(screenPos.x, screenPos.y);
      c.fill(col);
      c.rect(0,0,8,8);

    c.popMatrix();
  }
  
}
