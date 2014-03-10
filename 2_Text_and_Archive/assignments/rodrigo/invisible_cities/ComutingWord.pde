
class ComutingWord {

  PVector pos;
  PVector destination;
  String word;
  float angle = 0;

  ComutingWord(PVector _init_pos, PVector _destination, String _word) {
    pos = _init_pos;
    destination = _destination;
    word = _word;
  }
  
  void update() {
    
      PVector direction = new PVector(destination.x, destination.y);
      direction.sub(pos);
      direction.normalize();
      
      if (abs(direction.y) - abs(direction.x) > 0.75) {
        angle = HALF_PI;
      }else{
        angle = 0;
      }
      
      direction.mult(FrameStep + (random(0,100) /100));
      pos.add(direction);
    
      float x_grid = getNearestGrid(pos.x);
      float y_grid = getNearestGrid(pos.y); 
      
      
      if (abs(pos.x - x_grid) <= abs(pos.y - y_grid)) {
        pos.x = x_grid; 
      }else{
        pos.y = y_grid;
      }
  }
  
  void render() {
    pushMatrix();
     translate(pos.x, pos.y);
     rotate(angle);
     fill(0);
     textSize(10);
     text(word, 0, 0);
    popMatrix();
  }
  
  float getNearestGrid(float val) {
    return(round(val/gridSize) * gridSize);
  }
  
}
