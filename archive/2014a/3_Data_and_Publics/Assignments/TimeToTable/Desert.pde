class Desert {

  //real data 
  PVector lonlat; 
  float seconds; 
  float miles; 
  Market closestM;    //= new Market();
  Mover mover; 

  //for position and draw
  PVector pos; 
  float lon;
  float lat;
  String borough;
  int rectSize = 4;
    int rectWidth = 20; 

//  void update() {
//    
//    newPos = mover.movement(seconds, lonLat, pos, closestM)
//    //pos.add(newPos);
//    
//  }

  void renderD() {
    pushMatrix();
    translate(pos.x, pos.y);
  //  print("pos.x:" + pos.x); 
  //  println("; pos.y:" + pos.y); 
    fill(255, 0, 0);
    rect(0, 0, rectSize, rectWidth);
    popMatrix();
  }
  
  void renderLines(){
//    pushMatrix();
   // translate(0, 0);
  // print("closestM:" + closestM);   
   // print("pos.x:" + pos.x); 
  //  print("; pos.y:" + pos.y); 

//    println("lat" + closestM.lat); 
//    println("lon" + closestM.lon); 
//    print("\tclosestM.pos.x:" + closestM.pos.x);   
//    println("; closestM.pos.y:" + closestM.pos.y);
    //print("\tclosestM.pos.x:" + closestM.lon);   
    //println("; closestM.pos.y:" + closestM.pos.y); 
  
   // convertTime();   
    stroke(255, 0, 0, 100);
    //strokeWeight(4); 
   line(pos.x, pos.y, closestM.pos.x, closestM.pos.y);
   
    
//    line(pos.x, pos.y, closestM.pos.x, -500);
//    line(pos.x, pos.y, -10, -500);
//    rect(pos.x, pos.y, rectSize, 10);
//    popMatrix();
    
  }
}

