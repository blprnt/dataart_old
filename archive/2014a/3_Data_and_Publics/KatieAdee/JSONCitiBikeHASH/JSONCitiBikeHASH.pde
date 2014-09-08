/*
4/14/14
CitiBike Live Data
 */

String endpoint = "http://citibikenyc.com/stations/json";
ArrayList <Station> allStations =  new ArrayList();
import java.util.Map;
HashMap<Integer, Station> stationHash = new HashMap<Integer,Station>();  

void setup() {
  size(1280, 720, P3D);
  smooth(8);

  loadStations();
  
}

void draw() {
  background(0);
  for (Station s : allStations){
    s.update();
    s.render(); 
  }
  
  if (frameCount % 60 * 60 ==0) updateStations(); 
  
  if (keyPressed == true) {
    updateStations();
    
  }
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
    s.pos = new PVector(i*5, height-10);
    allStations.add(s);
    stationHash.put(s.id, s);
  }
}

void updateStations(){
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



