/*

John Farrell
MINED
April 14, 2014
Data Art - ITP NYU
johnefarrell18@gmail.com

*/

ArrayList<mine> allMines = new ArrayList();

PGraphics canvas;
PVector mapTopLeft = new PVector(-180, 90);
PVector mapBottomRight = new PVector(180, -90);

void setup() {
  size(1280, 720, P3D); 

  canvas = createGraphics(width, height, P3D);
  canvas.beginDraw();
  canvas.background(255);
  canvas.stroke(255);
  canvas.rectMode(CENTER);
  canvas.endDraw();

  loadMines("minedata.csv");
  positionMines(new PVector(-131.66, 51.6), new PVector(-62.4, 21.85));

  drawMines();
}

void draw() {
  background(255);
  image(canvas, 0, 0);
  //save("typeAll.jpg");
}

void drawMines() {
  canvas.beginDraw();
  canvas.background(255);
  canvas.noStroke();
  
  for (mine m:allMines) {
    
    if (m.type.equals("Cement") == true ) {
      m.renderCEM(canvas);
    }
    
   else if (m.type.equals("Common Clay and Shale") == true ) {
      m.renderCCS(canvas);
    }
    
     else if (m.type.equals("Crushed Stone") == true ) {
      m.renderCS(canvas);
    }
    
     else if (m.type.equals("Sand and Gravel") == true ) {
      m.renderSG(canvas);
    }
    
     else if (m.type.equals("Sulfur") == true ) {
      m.renderSF(canvas);
    }
    
    else m.renderE(canvas);
  }
  canvas.endDraw();
}

void positionMines(PVector topLeft, PVector bottomRight) {
  for (mine m:allMines) {
    //This is the trick!  Mapping a world of data onto our screen
    float x = map(m.lonLat.x, topLeft.x, bottomRight.x, 0, width);
    float y = map(m.lonLat.y, bottomRight.y, topLeft.y, height, 0);
    m.pos = new PVector(x, y);
  }
}


void loadMines(String url) {
  Table t = loadTable(url);
  for (TableRow row:t.rows()) {
    float lat = row.getFloat(6);
    float lon = row.getFloat(7);

    String type = row.getString(1);
    String company = row.getString(3);
    String state = row.getString(4);

    mine m = new mine();
    m.lonLat = new PVector(lon, lat);
    m.type = type;
    m.company = company;
    m.state = state;
    allMines.add(m);
    // println(m.state+" + "+  m.type);
  }


}

