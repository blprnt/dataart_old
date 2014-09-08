/*
http://www.agriculture.ny.gov/AP/CommunityFarmersMarkets.asp#Bronx County
 */

ArrayList<Desert> allDeserts = new ArrayList();
ArrayList<NonDesert> allNonDeserts = new ArrayList();
ArrayList<Market> allMarkets = new ArrayList();
ArrayList<Mover> allMovers = new ArrayList(); 

//Mover mover = new Mover();
//Market market = new Market(); 
int rectSizeD = 10;
int rectSizeND = 20;

//nonofficial NY - based on lon/lat from market/census tracts
float mapOutXsmall = -73.4549061;
float mapOutXbig = -74.316766;
float mapOutYsmall = 40.4997874;
float mapOutYbig = 40.903093;

void setup() {
  size(1440, 780);
  background(0);
  frameRate(2);

  loadMarkets("farmers_markets.csv");
  // println("loaded markets");

  positionMarketsX(new PVector (mapOutXbig, 0), new PVector (mapOutXsmall, 0));
  // println("positioned markets");
  loadTimeDistDes("timeDistanceDes.csv");
  // println("loded time dist des");
  loadTimeDistNonDes("timeDistanceNonDes.csv");
  // println("loded time dist NON des");

  // positionClosestMarket(new PVector (40, 0), new PVector (mapOutXsmall, 0));
  positionDesertsX(new PVector (mapOutXbig, height - rectSizeD), new PVector (mapOutXsmall, height - rectSizeD));
  // println("positioning deserts");
  //positioning everything on the X axis
  positionNonDesertsX(new PVector (mapOutXbig, height - rectSizeND), new PVector (mapOutXsmall, height - rectSizeND));
  //println("first vector" + new PVector(mapOutXbig, height - rectSizeND)); 
 // println("second vector" + new PVector(mapOutXsmall, height - rectSizeND)); 
  
  
  //  println("positioning nondeserts");
  drawAnchorPoints();
  // drawLines(); 

  //divider line
  stroke(255, 100);
  strokeWeight(2);
  line(width/3*2, 0, width/3*2, height);
}

void draw() {
  //  image(canvas, 0, 0);
  //background(0); 
  for (Desert d:allDeserts) {
    println("im iterating through the deserts"); 
    d.mover.update(d.pos, d.closestM.pos);
    println("mover is updated"); 
    d.mover.display();
    println("mover is displayed"); 
  }
  
  for (NonDesert nd:allNonDeserts) {
    println("nd.pos" + nd.pos + "nd.closestM.pos" + nd.closestM.pos); 
    nd.mover.update(nd.pos, nd.closestM.pos);  //this is a problem
    nd.mover.display(); 
  }

}

void loadMarkets(String url) {
  Table t = loadTable(url);

  for (TableRow row:t.rows()) {
    float lonM = row.getFloat(1);
    float latM = row.getFloat(0); 

    Market m = new Market();
    m.lon = lonM;
    m.lat = latM; 
    //    m.pos = new PVector();
    m.lonlat = new PVector(lonM, latM); 
    // println("lonlat of market:" + m.lonlat); 

    allMarkets.add(m);
  }
}

void loadTimeDistDes(String url) {
  Table t = loadTable(url);
  // println("time loaded");
  for (TableRow row:t.rows()) {
    float seconds = row.getFloat(0); 
    float miles = row.getFloat(1);

    //CSV cols: time (sec), distance(), desert (lat, lon), closest market (lat, lon);
    PVector lonlat = new PVector (row.getFloat(3), row.getFloat(2));
    PVector lonlatM = new PVector (row.getFloat(6), row.getFloat(5));
    // println("desertlonlatD " + lonlat + " lonlatM " + lonlatM);

    Desert d = new Desert();
    d.lon = row.getFloat(3); 
    d.lat = row.getFloat(2); 
    d.lonlat = lonlat; 
    d.seconds = seconds; 
    d.miles = miles; 

    d.closestM = new Market();   
    for (Market m:allMarkets) {
      //  println("m.lonlat is :" + m.lonlat); 
      // println("lonlatM:" + lonlatM); 

      String checkX = String.format("%.5f", lonlatM.x);
      String checkY = String.format("%.5f", lonlatM.y);

      String mX = String.format("%.5f", m.lonlat.x);
      String mY = String.format("%.5f", m.lonlat.y);


      if (lonlatM.x == m.lonlat.x && lonlatM.y == m.lonlat.y) {
        d.closestM = m;
      }
      allDeserts.add(d);
    }
  }
}

//
void loadTimeDistNonDes(String url) {
  Table t = loadTable(url);
  // println("time loaded");
  for (TableRow row:t.rows()) {
    float seconds = row.getFloat(0); 
    float miles = row.getFloat(1);

    //CSV cols: time (sec), distance(), desert (lat, lon), closest market (lat, lon);
    PVector lonlat = new PVector (row.getFloat(3), row.getFloat(2));
    PVector lonlatM = new PVector (row.getFloat(6), row.getFloat(5));
    // println("nonDesertlonlatD " + lonlat + " lonlatM " + lonlatM);

    NonDesert nD = new NonDesert();
    nD.lon = row.getFloat(3); 
    nD.lat = row.getFloat(2); 
    nD.lonlat = lonlat;
    nD.seconds = seconds;  
    nD.miles = miles; 

    //  println("closesrMarket:" + nD.closestM); 

    for (Market m:allMarkets) {  
      //comparing the market you already made to the lat lon od the same market on the spreadsheet. 
      if (lonlatM.x == m.lonlat.x && lonlatM.y == m.lonlat.y) {
        //  println("matched a market" + m.lonlat +  "to a desert:"+ nD.lonlat);
        nD.closestM = m;
        nD.closestM.seconds = nD.seconds;
      }
    }

    allNonDeserts.add(nD);
  }
}

void positionDesertsX(PVector left, PVector right) {
  for (Desert d:allDeserts) {
    float x = map(d.lon, left.x, right.x, width/3*2, width);
    float y = height - rectSizeD;
    d.pos = new PVector(x, y);
    d.mover = new Mover(d.pos, 5, d.seconds); 
  }
}

void positionNonDesertsX(PVector left, PVector right) {
  int rectSizeND = 20;
  for (NonDesert nD:allNonDeserts) {
    //float x = constrain(map(nD.lon, left.x, right.x, 0, width/3*2 - 4), 0, width/3*2 - 4 );
    float x = constrain(map(nD.lon, left.x, right.x, 0, width/3*2 - 4), 0, width/3*2 - 4 );
    float y = height - rectSizeD;
    nD.pos = new PVector(x, y);
    nD.mover = new Mover(nD.pos, 5, nD.seconds); 
  }
}

void positionMarketsX(PVector left, PVector right) {
  for (Market m:allMarkets) {
    float x = map(m.lon, left.x, right.x, 0, width);
    float y = 0;
    m.pos = new PVector(x, y);
    //  println("this is the market vector:" + m.pos); 
    //println("the markets have been positioned");
  }
}

//This draws all of the rectangles(food deserts, non food deserts, markets). 
void drawAnchorPoints() {
  for (Desert d:allDeserts) 
    d.renderD();
  for (NonDesert nD:allNonDeserts) 
    nD.renderND();  
  for (Market m:allMarkets) 
    m.renderM();
  //  canvas.endDraw();
}

//this draws the lines
void drawLines() {
  for (Desert d:allDeserts)  
    d.renderLines();
  for (NonDesert nd:allNonDeserts) {
    nd.renderLines();
  }
}

