/*
4/14/14
 CitiBike Live Data
 */
import googlemapper.*;
import peasy.*;

PImage map;
PeasyCam cam;
GoogleMapper gMapper;

String endpoint = "http://citibikenyc.com/stations/json";
ArrayList <Station> allStations =  new ArrayList();
import java.util.Map;
HashMap<Integer, Station> stationHash = new HashMap<Integer, Station>();  

void setup() {
  size(1280, 720, P3D);
  smooth(8);

  double maCenterLat = 40.7245;
  double mapCenterLon = -73.970;
  int zoomLevel =13;
  String mapType = GoogleMapper.MAPTYPE_SATELLITE;
  int mapWidth=1280;
  int mapHeight=720;
  map = loadImage("map.jpg");
  gMapper = new GoogleMapper(maCenterLat, mapCenterLon, zoomLevel, mapType, mapWidth, mapHeight);
  
  cam = new PeasyCam(this, width/2, height/2, 0, 500);
  cam.setRollRotationMode();
  //cam.setMinimumDistance(100);
  cam.setMaximumDistance(500);

  loadStations();
}

void draw() {
  background(255);
  image(map, 0, 0);
  for (Station s : allStations) {
    s.update();
    s.render();
    s.graph();
  }

  if (frameCount % 60 * 60 ==0) updateStations(); 

}

void loadStations() {
  JSONObject stationJSON =  loadJSONObject(endpoint);  
  JSONArray stationList = stationJSON.getJSONArray("stationBeanList");
  for (int i=0; i < stationList.size(); i++) {
    JSONObject sj = stationList.getJSONObject(i); 
    //println(sj.getString("stationName"));
    Station s = new Station();
    s.id = sj.getInt("id");
    s.totalDocks = sj.getInt("totalDocks");
    s.availableDocks = sj.getInt("availableDocks");
    float lat = sj.getFloat("latitude");
    float lon = sj.getFloat("longitude");
    float x = (float)gMapper.lon2x(lon);
    float y = (float)gMapper.lat2y(lat);
    s.pos = new PVector(x, y);
    s.cpos = new PVector(width, i*5);
    allStations.add(s);
    stationHash.put(s.id, s);
  }
}

void updateStations() {
  JSONObject stationJSON =  loadJSONObject(endpoint);  
  JSONArray stationList = stationJSON.getJSONArray("stationBeanList");
  for (int i=0; i < stationList.size(); i++) {
    JSONObject sj = stationList.getJSONObject(i);
    int id = sj.getInt("id");
    Station s = stationHash.get(id);
    s.availableDocks = sj.getInt("availableDocks");
  }
  //println("updating stations");
  //for (Station s : allStations){
  //  println(s.id +" : "+ s.availableDocks);
  //}
}


