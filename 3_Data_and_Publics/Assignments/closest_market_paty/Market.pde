class Market {
  
  PVector latLon; 
  PVector pos; 
  
  
  void update() {
    
  }
  
  void render(PGraphics pg) {
    pg.fill(255,0,0); 
    pg.pushMatrix();
    pg.translate(pos.x, pos.y); 
    pg.rect(0, 0, 100, 100); 
    pg.popMatrix(); 
  }
  
}
