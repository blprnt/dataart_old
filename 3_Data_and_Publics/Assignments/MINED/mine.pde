class mine {

  PVector lonLat;
  PVector pos;
  String type;
  String company;
  String state;
  color col;

  void update() {
  }

  void renderCS(PGraphics pgCS) {
    pgCS.pushMatrix();
    pgCS.translate(pos.x, pos.y);
    pgCS.noStroke();
    pgCS.fill(2,49,56,175);
    pgCS.ellipse(0, 0, 8, 8);
    //pgCS.text(type, 0, 0);
    pgCS.popMatrix();
  }
  
    void renderCEM(PGraphics pgCEM) {
    pgCEM.pushMatrix();
    pgCEM.translate(pos.x, pos.y);
    pgCEM.noStroke();
    pgCEM.fill(183,73,231);
    pgCEM.ellipse(0, 0, 8, 8);
    //pgCEM.text(type, 0, 0);
    pgCEM.popMatrix();
  }
  
    void renderCCS(PGraphics pgCCS) {
    pgCCS.pushMatrix();
    pgCCS.translate(pos.x, pos.y);
    pgCCS.noStroke();
    pgCCS.fill(8,165,172,175);
    pgCCS.ellipse(0, 0, 8, 8);
    //pgCCS.text(type, 0, 0);
    pgCCS.popMatrix();
  }
  

     void renderSG(PGraphics pgSG) {
    pgSG.pushMatrix();
    pgSG.translate(pos.x, pos.y);
    pgSG.noStroke();
    pgSG.fill(247,100,50,175);
    pgSG.ellipse(0, 0,8, 8);
    //pgSG.text(type, 0, 0);
    pgSG.popMatrix();
  }
       void renderSF(PGraphics pgSF) {
    pgSF.pushMatrix();
    pgSF.translate(pos.x, pos.y);
    pgSF.noStroke();
    pgSF.fill(247,76,77,175);
    pgSF.ellipse(0, 0, 8, 8);
    //pgSF.text(type, 0, 0);
    pgSF.popMatrix();
  }
  
  
  
  void renderE(PGraphics pgE) {
       pgE.pushMatrix();
    pgE.translate(pos.x, pos.y);
    pgE.noStroke();
    pgE.fill(0,130);
    pgE.ellipse(0, 0, 8, 8);
    //pg.text(type, 0, 0);
    pgE.stroke(0);
    pgE.popMatrix();
  }
}

