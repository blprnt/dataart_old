/**
Author: Sagar Mohite. @ssm. 2014.
-----------------------------------
Vehicle Collisions vs Speed detectors in New York City.
--------------------------------------------------------
The blue lines show the traffic speeds information (as of 9/21/14) 
captured by various traffic speed detectors installed by New York City DOT. 
In contrast, the red dots show the vehicle collisions that happened since 2012.

Data Sources: 
1. [As of 9/21/2014 2100 hrs in the video] https://data.cityofnewyork.us/Transportation/Real-Time-Traffic-Speed-Data/xsat-x5sa
2. https://data.cityofnewyork.us/NYC-BigApps/NYPD-Motor-Vehicle-Collisions/h9gi-nx95

TODOs: 
1. Fix colors. 
2. Port to JavaCL on Processing or OpenGL(Cinder/OF) for real-time rendering.
**/

Table table, collisions;
ArrayList<Point> paths;

void setup() {
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  background(20);
  
  //needs an active internet connection
  table = loadTable("http://207.251.86.229/nyc-links-cams/LinkSpeedQuery.txt", "header, tsv");
  collisions = loadTable("collisions.csv", "header, csv");
}


int i = 1000; //for a sample camera angle

void draw() {
  //set camera
  camera(i, 400, i, width/2, height/2, 0, 0, 1, 0); 
   
  //i+=5; //set camera motion 
  
  background(20);
  pushMatrix();
  rotate(PI/2);
  translate(-width/4,-height); /*note that this is translation after rotation hence flipped*/
  
   //load and plot speeds and locations
  
  beginShape();
  showSpeeds();
  //showCollisions(); //load collision points
  endShape();
  
  popMatrix();
}


void showSpeeds() {
   for(TableRow row : table.rows()) {
    if(row.getString("\"EncodedPolyLine\"") != null){
      paths = decodePoly(row.getString("\"EncodedPolyLine\"").replace("\"",""));
      String spdString = row.getString("\"Speed\"").replace("\"", "");
     
      float colr = map(parseFloat(spdString), 0, 60, 10, 255);
      noFill();
      //fill(0, (int)colr, 255);
      for (Point p : paths) {
        p.mapToScreen();
        noStroke();
        stroke(0, (int)colr, 255);
        vertex(p.lat, p.lon);
        //line(p.lat,p.lon,0,p.lat,p.lon,colr/4);
      }
    }
  }
}

void showCollisions() {
    for(TableRow row : collisions.rows()){
    fill(255, 55, 0, 100);
    float clat = row.getFloat("LATITUDE");
    float clon = row.getFloat("LONGITUDE");
    Point p = new Point(clat*1E3, clon*1E3);
    p.mapToScreen();
    stroke(255, 55, 0);
    vertex(p.lat, p.lon, 1, 1);
  }
}

/* Decode EncodedPolyLine as mentioned here 
   https://developers.google.com/maps/documentation/utilities/polylineutility */
ArrayList<Point> decodePoly(String encoded) {
  ArrayList<Point> poly = new ArrayList<Point>();
  int index = 0, len = encoded.length();
  int lat = 0, lng = 0;

  while (index < len) {
    try {
    int b, shift = 0, result = 0;
    do {
      b = encoded.charAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.charAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;
    } catch(Exception e) {}


    Point p = new Point((float) lat/1E2,
       (float) lng/1E2 );
    poly.add(p);
  }
  return poly;
}

boolean sketchFullScreen(){
  return true;
}
