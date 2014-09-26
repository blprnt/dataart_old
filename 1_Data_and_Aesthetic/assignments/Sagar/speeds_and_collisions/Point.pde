class Point {
  float lon;
  float lat;
  Point(float _lat, float _lon){
    lon = _lon;
    lat = _lat;
  }
  
  void display(){
    println(this.lat + "  " + this.lon);
  }
  
  //fit points within viewports
  void mapToScreen(){
    lon *= -1;
    lat = map(lat, 40490, 40960, width-170, 170);
    lon = map(lon, 74250, 73700, height-30, 30); 
  }
}
