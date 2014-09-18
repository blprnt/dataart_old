import googlemapper.*;
import peasy.*;
String endPoint = "pedDeaths2.json";

PeasyCam cam;
PImage map;
GoogleMapper gMapper;
ArrayList<Chime> chimeList = new ArrayList();

public void setup() {

  size(1000, 1000, P3D);
  cam = new PeasyCam(this, width/2, height/2, -100, 1200);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(2000);	
  cam.setRotations(-0.8854452, -0.7244981, 0.4583774);

  double maCenterLat = 40.7245;
  double mapCenterLon = -73.970;
  int zoomLevel =11;
  String mapType = GoogleMapper.MAPTYPE_TERRAIN;
  int mapWidth=1000;
  int mapHeight=1000;
  gMapper = new GoogleMapper(maCenterLat, mapCenterLon, zoomLevel, mapType, mapWidth, mapHeight);
  //map = gMapper.getMap();
  map = loadImage("map.jpg");
  //cam.setRotations(-0.8854452, -0.7244981, 0.4583774);
  loadDeaths(endPoint);
}

public void draw() {
  background(0);

  tint(255, 50);
  image(map, 0, 0);

  for (Chime c : chimeList) {
    c.display();
    
  }

}

void loadDeaths(String url) {
  JSONObject deathJSON = loadJSONObject(endPoint);
  JSONArray deathList = deathJSON.getJSONArray("features");
  for (int i = 0; i < deathList.size(); i++) {
    JSONObject d = deathList.getJSONObject(i); 
    JSONObject geo = d.getJSONObject("geometry");
    JSONArray coord = geo.getJSONArray("coordinates");
    float lat = coord.getFloat(1);
    float lon = coord.getFloat(0);
    
    float y = (float)gMapper.lat2y(lat);
    float x = (float)gMapper.lon2x(lon);
    
    Chime c  = new Chime(x,y,lat,lon);
    chimeList.add(c);
    
  }

  println(chimeList.size());
}

