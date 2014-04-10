//This is calculating the closest market to each desert

//April 9th, 2014
//By: Patricia R. Zablah 

//to use the Google Maps API to get the time distance traveled
//import httprocessing.*;

import http.requests.*;
String apiKey = "AIzaSyB4M0A8xSufQHc-qo7qZWOa1FGfaTNKG0s"; 
String origin; 



ArrayList <Market> allMarkets = new ArrayList(); 
ArrayList <Desert> allDeserts = new ArrayList(); 

PGraphics canvas; 

PVector mapTopLeft = new PVector(-74.25909, 40.917577); 
PVector mapBottomRight = new PVector(-73.700172,40.477399); 

 PVector firstDesert = new PVector(40.7934921,-73.8835318); 
 PVector firstMarket = new PVector(40.857388, -73.909695); 

void setup() {
 size(1280, 720, P3D); 
 
 canvas= createGraphics(1280,720, P3D); 
 canvas.beginDraw(); 
 canvas.background(0);  
 canvas.stroke(255); 
 canvas.endDraw(); 
 
 loadMarkets("farmers_markets.csv"); 
 loadDeserts("nyc_foodDesertsOnly.csv"); 
// positionMarkets(new PVector (-74.25909, 40.917577), new PVector(-73.700172,40.477399)); 
// drawMarkets(); 
 calcShortDist(new PVector(40.7934921,-73.8835318), new PVector(40.857388, -73.909695));
 calcTime();  
}


void draw() {
  background(255); 
  image(canvas,0,0);  
   //calcTime();  
}

void loadMarkets (String url) {
  Table tm = loadTable(url); 
  for (TableRow row: tm.rows()) {
    Float lat = row.getFloat(0); 
    Float lon = row.getFloat(1); 
    
    Market m = new Market(); 
    m.latLon = new PVector(lat,lon); 
    allMarkets.add(m); 
  }
  
}

void loadDeserts(String url) {
  
  Table td = loadTable(url); 
  for (TableRow row: td.rows()) {
    Float lat = row.getFloat(3); 
    Float lon = row.getFloat(4); 
    
    Desert d = new Desert(); 
    d.latLon = new PVector(lat,lon); 
    allDeserts.add(d); 
  }
  
}

void calcShortDist(PVector firstMarket, PVector firstDesert)  {
  
  float minDist = 10000; 
  int closestDist = 0; 
  println("calculating Shortest Distance"); 
  
  for (int i=0; i< allDeserts.size(); i++) {
    for (int j=0; j<allMarkets.size(); j++) {
      float dist = (allDeserts.get(i).latLon).dist(allMarkets.get(j).latLon); 
      
      //compare so that the shortest distance always wins
      if(dist<minDist) {
        minDist = dist; 
        closestDist = j; 
      }
    }
    minDist = 10000; 
    //sending the closest market pair and storing it into that particular desert. 
    allDeserts.get(i).closestM = allMarkets.get(closestDist);
    println("pushed a new market into your desert:" + allDeserts.get(i)); 
    //this is where you put the function to call the calculate time. 
    
    //store the distance and/or time    
  }
}

//Time calcualted between two points. 
void calcTime() {
  println("im about to do the http request"); 
  GetRequest get = new GetRequest("https://maps.googleapis.com/maps/api/distancematrix/json?origins=Vancouver+BC&destinations=San+Francisco&mode=walking&sensor=false&key=AIzaSyB4M0A8xSufQHc-qo7qZWOa1FGfaTNKG0s"); 
//                                   1234567890123456789012345678901234567890123456789012345678901234567890123456 
  println("the request is done"); 
  get.send(); 
  
  println("Reponse Content: " + get.getContent());
  //println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));
  
  //How do you get only the duration between the two?
  
  JSONObject response = parseJSONObject(get.getContent());
  println("status: " + response.getString("status"));
  println("duration: " + response.getString("elements"));
//  JSONArray boxes = response.getJSONArray("data");
//  println("boxes: ");
//  for(int i=0;i<boxes.size();i++) {
//    JSONObject box = boxes.getJSONObject(i);
//    println("  wifiboxid: " + box.getString("wifiboxid"));
}





void drawMarkets() {
  canvas.beginDraw(); 
  canvas.background(255); 
  for (Market m:allMarkets) {
    m.render(canvas); 
  }
  canvas.endDraw(); 
}

void positionMarkets(PVector topLeft, PVector bottomRight) {
  for (Market m:allMarkets) {
    float x = map(m.latLon.x, topLeft.x, bottomRight.x, 0, width); 
    float y = map(m.latLon.y, bottomRight.y, topLeft.y, height, 0);    
    m.pos = new PVector(x,y); 
    
  }
}
