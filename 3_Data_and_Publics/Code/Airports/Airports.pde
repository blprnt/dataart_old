String dataPath = "../../../data/";
ArrayList<Airport> allAirports = new ArrayList();

PGraphics canvas;

void setup() {
  size(1280, 720, P3D);
  background(0);

  canvas = createGraphics(width, height, P3D);
  canvas.beginDraw();
  canvas.background(0);
  canvas.stroke(255);
  canvas.endDraw();

  loadAirports(dataPath + "all_airports.csv");
  positionAirports();
  drawAirports();
}

void draw() {
  background(0);
  image(canvas, 0, 0);
  fill(255,100);
  rect(mouseX,mouseY,128,72);
}

void loadAirports(String url) {
  //loadStrings(url);
  Table t = loadTable(url);

  for (TableRow row:t.rows()) {
    float lat = row.getFloat(3);
    float lon = row.getFloat(4);

    String name = row.getString(2);
    String code = row.getString(0);
    if (code.length() == 0) code = row.getString(1);

    Airport a = new Airport();
    a.lonLat = new PVector(lon, lat);
    a.name = name;
    a.code = code; 

    allAirports.add(a);
  }
}

void positionAirports() {
  for (Airport a:allAirports) {
    float x = map(a.lonLat.x, -180, 180, 0, width);
    float y = map(a.lonLat.y, -90, 90, height, 0);
    a.pos = new PVector(x, y);
  }
}

void drawAirports() {
  canvas.beginDraw(); 
  for (Airport a:allAirports) {
    a.render(canvas);
  }
  canvas.endDraw();
}

