String dataPath = "../../../data/";
ArrayList<Airport> allAirports = new ArrayList();

PGraphics canvas;

PVector mapTopLeft = new PVector(-180, 90);
PVector mapBottomRight = new PVector(180, -90);

void setup() {
  size(1280, 720, P3D);
  background(0);

  canvas = createGraphics(width, height, P3D);
  canvas.smooth(8);
  canvas.beginDraw();
  canvas.background(0);
  canvas.stroke(255);
  canvas.endDraw();

  loadAirports(dataPath + "all_airports.csv");
  //Whole world
  positionAirports(new PVector(-180, 90), new PVector(180, -90));
  //Top left quadrant
  //positionAirports(new PVector(-180,90), new PVector(0,0));
  //USA
  //positionAirports(new PVector(-131.66,51.6), new PVector(-62.4,21.85));

  drawAirports();
}

void draw() {
  background(0);
  image(canvas, 0, 0);
  fill(255, 100);
  rect(mouseX, mouseY, 256, 144);
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

void positionAirports(PVector topLeft, PVector bottomRight) {
  for (Airport a:allAirports) {
    float x = map(a.lonLat.x, topLeft.x, bottomRight.x, 0, width);
    float y = map(a.lonLat.y, bottomRight.y, topLeft.y, height, 0);
    a.pos = new PVector(x, y);
  }
}

void drawAirports() {
  canvas.beginDraw(); 
  canvas.background(0);
  for (Airport a:allAirports) {
    a.render(canvas);
  }
  canvas.endDraw();
}

void zoomToBox() {
  //calculate the latLon equivalent of the selection box
  PVector topLeft = new PVector();
  topLeft.x = map(mouseX, 0, width, mapTopLeft.x, mapBottomRight.x);
  topLeft.y = map(mouseY, 0, height, mapTopLeft.y, mapBottomRight.y);

  PVector bottomRight = new PVector();
  bottomRight.x = map(mouseX + 256, 0, width, mapTopLeft.x, mapBottomRight.x);
  bottomRight.y = map(mouseY + 144, 0, height, mapTopLeft.y, mapBottomRight.y);

  positionAirports(topLeft, bottomRight);
  drawAirports();

  mapTopLeft = topLeft;
  mapBottomRight = bottomRight;
}

void mousePressed() {
  zoomToBox();
}

void keyPressed() {
  if (key == ' ') {
    mapTopLeft = new PVector(-180, 90);
    mapBottomRight = new PVector(180, -90);
    positionAirports(mapTopLeft, mapBottomRight);
    drawAirports();
  }
}












