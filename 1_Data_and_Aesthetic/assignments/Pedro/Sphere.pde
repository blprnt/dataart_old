class Sphere {
  PVector position;
  PVector[] points;
  int maxPoints;
  int radiusSphere;

  //-------------------------------------------------------- Constructor
  Sphere(int radius) {
     maxPoints = myData.getSize();
     radiusSphere = radius;
     points = new PVector[maxPoints];
     createSpherePoints();
    
  }
  
  
  //-------------------------------------------------------- Method to update position
  void update() {

  }
  
  //-------------------------------------------------------- Method to display Sphere
  void display() {
    
    for (int ni=0; ni<maxPoints; ni++){
      pushStyle();
      if(ni != 199){
        stroke(150);
      } else {
        //stroke(255,204,0);
      } 
      
      //stroke(points[ni].z);
      //strokeWeight(ni/5);
      strokeWeight((myData.getValue(ni)/10)+1);
      point (points[ni].x, points[ni].y, points[ni].z);
      popStyle();
      
    }
    
    pushStyle();
    noStroke();
    fill(222);
    sphere(200);
    popStyle();

  }
  
    //-------------------------------------------------------- Method to select datapoint
  void select(int index) {
    pushStyle();
//    stroke(150);
//    strokeWeight((myData.getValue(index)/10)+1);
//    point (points[index].x, points[index].y, points[index].z);
    stroke(100);
    strokeWeight((myData.getValue(index)/10)+1);
    point (points[index].x, points[index].y, points[index].z);
    
//    stroke(150);
//    strokeWeight(10);
//    point (points[index].x, points[index].y, points[index].z);
    //println(points[index].z);
    popStyle();
    
  }
  
  
  
  //-------------------------------------------------------- Utils
  
  // populate array of points
  void createSpherePoints() {
    for (int ni=0; ni<maxPoints; ni++){
      points[ni] = randomSpherePoint(radiusSphere);
    }
    println("#2 Sphere Populated");
  }
  
  // return random sphere point using method of Cook/Neumann
  PVector randomSpherePoint(float radius) {
    float a=0, b=0, c=0, d=0, k=99;
    while (k >= 1.0)
    {
      a = random (-1.0, 1.0);
      b = random (-1.0, 1.0);
      c = random (-1.0, 1.0);
      d = random (-1.0, 1.0);
      k = a*a +b*b +c*c +d*d;
    }

    k = k/radius;
    return new PVector
      ( 2*(b*d + a*c) / k
      , 2*(c*d - a*b) / k 
      , (a*a + d*d - b*b - c*c) / k);
  }
  
  
 }
