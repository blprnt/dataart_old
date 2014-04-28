String endPoint = "http://citibikenyc.com/stations/json";
ArrayList<Station> allStations = new ArrayList();

HashMap<String, Station> stationMap = new HashMap();

void setup() {
  size(1400, 720, P3D);
  smooth(8);

  loadStations();
  reportStations();
}

void draw() {
  background(0);
  for (Station s:allStations) {
    s.update();
    s.render();
  }

  if (frameCount % (60 * 10) == 0) {
    loadStations();
    reportStations();
  }
}

void reportStations() {
 for(Station s:allStations) {
  print(nf(s.availableDocks, 2) + "|");
 } 
}

void loadStations() {
  JSONObject stationJSON = loadJSONObject(endPoint);
  JSONArray stationList = stationJSON.getJSONArray("stationBeanList");
  for (int i = 0; i < stationList.size(); i++) {
    JSONObject sj = stationList.getJSONObject(i); 
    //println(sj.getString("stationName"));
    String id = str(sj.getInt("id"));
    //Have we already seen this station?
    if (stationMap.containsKey(id)) {
      //Previously seen station
      Station s = stationMap.get(id);
      s.updateDocks(sj.getInt("availableDocks"));
    } 
    else {
      //New station
      Station s = new Station();
      s.totalDocks = sj.getInt("totalDocks");
      s.availableDocks = sj.getInt("availableDocks");
      s.tpos = new PVector(map(i, 0, stationList.size(), 0, width), height/2);
      allStations.add(s);
      stationMap.put(id, s);
    }
  }
}

