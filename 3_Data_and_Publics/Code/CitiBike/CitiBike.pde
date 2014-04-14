String endPoint = "http://citibikenyc.com/stations/json";
ArrayList<Station> allStations = new ArrayList();

void setup() {
  size(1280,720,P3D);
  smooth(8);
  
  loadStations();
}

void draw() {
  for(Station s:allStations) {
    s.update();
    s.render();
  }
  
  if (frameCount % 60 * 60 == 0) loadStations();
}

void loadStations() {
 JSONObject stationJSON = loadJSONObject(endPoint);
 JSONArray stationList = stationJSON.getJSONArray("stationBeanList");
 for(int i = 0; i < stationList.size(); i++) {
  JSONObject sj = stationList.getJSONObject(i); 
  //println(sj.getString("stationName"));
  Station s = new Station();
  s.totalDocks = sj.getInt("totalDocks");
  s.availableDocks = sj.getInt("availableDocks");
  s.pos = new PVector(i * 5, 20);
  allStations.add(s);
 }
}
