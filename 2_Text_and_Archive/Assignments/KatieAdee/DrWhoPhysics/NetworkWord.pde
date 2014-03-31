class NetworkWord {

  String word;
  int count;
  IntDict linkMap = new IntDict();
  PVector pos = new PVector();
  float rot =0;
  Particle p;

  void update() {
  }
  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);
    fill(255);
    ellipse(0, 0, 5, 5);
    text(word, 5, 5);
    popMatrix();
  }
  
   void makeLinks() {
    //go through the words stored in the IntDict
    for (String w:linkMap.keys()) {
      NetworkWord nw = wordmap.get(w);
      if (displayWords.contains(nw)) {
        
        //Make spring btw this particle and the other
        
        Spring s = new Spring(nw.p, this.p, 100,1,1);
        springs.add(s);
        physics.addSpring(s);
     
      }
    }
  }

  void renderLinks() {
    //go through the words stored in the IntDict
    for (String w:linkMap.keys()) {
      NetworkWord nw = wordmap.get(w);
      if (displayWords.contains(nw)) {
        //Makem spring btw this particle and the other
        strokeWeight(sqrt(linkMap.get(w))*0.1);
        stroke(255,50);
        line(pos.x, pos.y, nw.pos.x, nw.pos.y);
      }
    }
  }
}

