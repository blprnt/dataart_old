class NetworkWord {
  
  String word;
  int count;
  IntDict linkMap = new IntDict();
  
  PVector pos = new PVector();
  //PVector orig_pos = new PVector();
  float rot = 0;
  
  void update() {
  
  }
  
  void render() {
    pushMatrix();
     translate(pos.x, pos.y);
     rotateZ(rot);
     fill(0);
     //ellipse(0,0,5,5);
     textSize(10);
     text(word, 0, 0);
    popMatrix();
  }
  
  void renderLinks() {
    for(String w:linkMap.keys()) {
       if (displayWords.contains(wordMap.get(w))){
         
         NetworkWord moveTo = wordMap.get(w);
         println(moveTo.pos);
         float x = pos.x + (moveTo.pos.x - pos.x) * factor * iter; 
         float y = pos.y + (moveTo.pos.y - pos.y) * factor * iter;
         text(word, x,y);
       }
     }
  }
  
  void createComunters(int iter_value) {
    if (iter%1500 == iter_value) {
      for(String w:linkMap.keys()) {
        if (displayWords.contains(wordMap.get(w))){
          NetworkWord moveTo = wordMap.get(w);
          PVector cpos = new PVector(pos.x, pos.y);
          PVector dpos = new PVector(moveTo.pos.x, moveTo.pos.y);
          comutingWords.add( new ComutingWord(cpos, dpos, word) );
        }
      }
    }
  }
  
}
