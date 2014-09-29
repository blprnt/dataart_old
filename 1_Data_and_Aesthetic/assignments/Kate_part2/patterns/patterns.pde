int[] years;
String[] urls;
int[] heights;

int[] yearsT;
String[] urlsT;
int[] heightsT;

int[] absTR;
int[] yearsTR;
String[] urlsTR;
int[] heightsTR;

void setup() {
  size(800, 800);
  //loadRiotData();
  //loadToyData();
  loadPatternData();
}

void draw() {
  background(255);
  //renderCircles(counts);
  //translate(50, 50);
  //renderGrid(counts, 10, 25, 10);
  //renderImages();
  renderStripes();
  //filter(GRAY);
  //filter(BLUR, 4);
}

void loadPatternData() {
  Table myTable = loadTable("ginghamMedia2.csv", "header");
  absTR = new int[myTable.getRowCount()];
  yearsTR = new int[myTable.getRowCount()];
  urlsTR = new String[myTable.getRowCount()];
  heightsTR = new int[myTable.getRowCount()];
  
  for(TableRow row:myTable.rows()) {
    int absT = row.getInt("num");
    int yearT = row.getInt("year");
    String urlT = row.getString("url");
    int heightT = row.getInt("height");
    //println(row.getInt(0)); //'every tree in the forest loop' (no count)
  }
  
  //it might be good to turn this into an array so that it's more usable
  
  for(int i = 0; i < myTable.getRowCount(); i++) {
    //println(myTable.getRow(i).getInt(0)); //could use getString for that type
    absTR[i] = myTable.getRow(i).getInt(0);
    
    //println(myTable.getRow(i).getInt(1)); //could use getString for that type
    yearsTR[i] = myTable.getRow(i).getInt(1);
    
    //println(myTable.getRow(i).getString(2));
    urlsTR[i] = myTable.getRow(i).getString(2);
    
    //println(myTable.getRow(i).getInt(3));
    heightsTR[i] = myTable.getRow(i).getInt(3);
  }

}

void renderStripes() {
  
  PImage webImg;
  
  float yPos = 0;
  
  for (int i = 0; i < yearsTR.length; i++) {
    
    String url = "http://nytimes.com/" + urlsTR[i];
    //println(urlsTR[i]);
    // Load image from a web server
    webImg = loadImage(url, "jpg");
    
    int scale_ = absTR[i];
    float scaleW = map(scale_, 18, 67, 20, 80);
    webImg.resize(int(scaleW), 0);
    
    float sizeW = webImg.width;
    float sizeH = webImg.height;
    
    float xPos = 0;
    
    for (int j = 0; j < (width / sizeW) + 1; j++) {
      image(webImg, xPos, yPos);
      
      xPos = j * sizeW;
    }
    yPos = yPos + sizeH;

  }
}
