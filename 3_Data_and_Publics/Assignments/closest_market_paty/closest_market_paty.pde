//Completing the Desert class with its closest market and the distance and time between them. 

//April 9th, 2014
//By: Patricia R. Zablah 

//to use the Google Maps API to get the time distance traveled

import http.requests.*;

String apiKey = "AIzaSyB4M0A8xSufQHc-qo7qZWOa1FGfaTNKG0s"; 

ArrayList <Market> allMarkets = new ArrayList(); 
ArrayList <Desert> allDeserts = new ArrayList(); 

PGraphics canvas; 

PVector mapTopLeft = new PVector(-74.25909, 40.917577); 
PVector mapBottomRight = new PVector(-73.700172, 40.477399); 

PVector firstDesert = new PVector(40.7934921, -73.8835318); 
PVector firstMarket = new PVector(40.857388, -73.909695); 

void setup() {
  size(1280, 720, P3D); 

  canvas= createGraphics(1280, 720, P3D); 
  canvas.beginDraw(); 
  canvas.background(0);  
  canvas.stroke(255); 
  canvas.endDraw(); 

  loadMarkets("farmers_markets.csv"); 
  loadDeserts("nyc_foodDesertsOnly.csv"); 
  
  calcClosestMarket(new PVector(40.7934921, -73.8835318), new PVector(40.857388, -73.909695));
  
  //if I put it inside of the class 
  //Desert.setMarket(); //have two functions, that calls calls closest market and then calculate the time. 
}

void draw() {
  background(255); 
  image(canvas, 0, 0);  
  //calcTime();
}

void loadMarkets (String url) {
  Table tm = loadTable(url); 
  for (TableRow row: tm.rows()) {
    Float lat = row.getFloat(0); 
    Float lon = row.getFloat(1); 

    Market m = new Market(); 
    m.latLon = new PVector(lat, lon); 
    allMarkets.add(m);
  }
}

void loadDeserts(String url) {

  Table td = loadTable(url); 
  for (TableRow row: td.rows()) {
    Float lat = row.getFloat(3); 
    Float lon = row.getFloat(4); 

    Desert d = new Desert(); 
    d.latLon = new PVector(lat, lon); 
    allDeserts.add(d);
  }
}

void calcClosestMarket(PVector firstMarket, PVector firstDesert) {

  float minDist = 10000; 
  int closestDist = 0; 
  println("calculating Shortest Distance"); 

  //iterate through each desert and for each, iterate through all the markets. 
  for (int i=0; i< allDeserts.size(); i++) {
    for (int j=0; j<allMarkets.size(); j++) {
      float dist = (allDeserts.get(i).latLon).dist(allMarkets.get(j).latLon); 

      //compare so that the shortest distance always wins.
      if (dist<minDist) {
        minDist = dist; 
        closestDist = j;
      }
    }
    minDist = 10000; 
    //sending the closest market pair and storing it into that particular desert. 
    allDeserts.get(i).closestM = allMarkets.get(closestDist);
  }

  //iterate through each desert to run calcTime on each of them. 
  for ( int i = 0; i < allDeserts.size(); i++ ) {
    calcTime(allDeserts.get(i));
  }
}

//Time calcualted between two points. 
void calcTime(Desert currentDesert) {

  //the variable types that you will need to set up the request and work with the data. 
  String myString; //A string to hold and parse the content from HTTP request
  JSONObject json; // A JSON object to fill with HTTP request myString above

  println("im about to do the http request"); 
  //convert the floats of the latlons to string and send them into the get request. 
  String desertLatLon = Float.toString(currentDesert.latLon.x) + "," + Float.toString(currentDesert.latLon.y);
  String marketLatLon = Float.toString(currentDesert.closestM.latLon.x) + "," + Float.toString(currentDesert.closestM.latLon.y);
  String mode = "walking"; 
  
  //for walking
  GetRequest get = new GetRequest("https://maps.googleapis.com/maps/api/distancematrix/json?origins=" + desertLatLon + "&destinations=" + marketLatLon + "&mode=" + mode + "&sensor=false&key=" + apiKey); 

  get.send(); 

  myString = get.getContent(); //put content from the call into a string. 

  json = JSONObject.parse(myString); //turn content into a JSON object for processing. 

  //instead of just making it a float, insert it straight into the class. 
  currentDesert.time = json.getJSONArray("rows").getJSONObject(0).getJSONArray("elements").getJSONObject(0).getJSONObject("duration").getFloat("value");
  println("time:" + currentDesert.time); 

  currentDesert.distance = json.getJSONArray("rows").getJSONObject(0).getJSONArray("elements").getJSONObject(0).getJSONObject("distance").getFloat("value");
  println("distance:" + currentDesert.distance);
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
    m.pos = new PVector(x, y);
  }
}

