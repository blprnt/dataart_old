String endPoint = "http://citibikenyc.com/stations/json";
ArrayList<Station> allStations = new ArrayList();

HashMap<String, Station> stationMap = new HashMap();

void setup() {
  size(1400, 720, P3D);
  smooth(8);

  //loadStations();
  //reportStations();
  CitiBikeThread loader = new CitiBikeThread("loader");
  loader.start();
}

void draw() {
  background(0);
  if (allStations.size() > 0) {
    for (Station s:allStations) {
      s.update();
      s.render();
    }
  }

  if (frameCount % (60 * 10) == 0) {
    CitiBikeThread loader = new CitiBikeThread("loader");
    loader.start();
    //loadStations();
    //reportStations();
  }
}

void reportStations() {
  for (Station s:allStations) {
    print(nf(s.availableDocks, 2) + "|");
  }
}

