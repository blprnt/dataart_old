class Airport {
 
  PVector lonLat;
  PVector pos;
  String name;
  String code;
  
  void update() {
    
  }
  
  void render(PGraphics pg) {
    pg.pushMatrix();
      pg.translate(pos.x, pos.y);
     //pg.point(0,0);
     pg.text(name,0,0);
    pg.popMatrix();
  }
  
}
