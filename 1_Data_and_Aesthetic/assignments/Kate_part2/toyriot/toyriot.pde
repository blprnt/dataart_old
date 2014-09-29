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
  loadToyriotData();
}

void draw() {
  background(255);
  //renderCircles(counts);
  //translate(50, 50);
  //renderGrid(counts, 10, 25, 10);
  //renderImages();
  renderStripes();
  filter(GRAY);
  filter(BLUR, 4);
}

//void loadRiotData() {
//  Table myTable = loadTable("riotgearMedia.csv", "header");
//  years = new int[myTable.getRowCount()];
//  urls = new String[myTable.getRowCount()];
//  heights = new int[myTable.getRowCount()];
//  
//  for(TableRow row:myTable.rows()) {
//    int yearT = row.getInt("year");
//    String urlT = row.getString("url");
//    int heightT = row.getInt("height");
//    //println(row.getInt(0)); //'every tree in the forest loop' (no count)
//  }
//  
//  //it might be good to turn this into an array so that it's more usable
//  
//  for(int i = 0; i < myTable.getRowCount(); i++) {
//    println(myTable.getRow(i).getInt(0)); //could use getString for that type
//    years[i] = myTable.getRow(i).getInt(0);
//    
//    println(myTable.getRow(i).getString(1));
//    urls[i] = myTable.getRow(i).getString(1);
//    
//    println(myTable.getRow(i).getInt(2));
//    heights[i] = myTable.getRow(i).getInt(2);
//  }
//
//}
//
//void loadToyData() {
//  Table myTable = loadTable("toygunMedia.csv", "header");
//  yearsT = new int[myTable.getRowCount()];
//  urlsT = new String[myTable.getRowCount()];
//  heightsT = new int[myTable.getRowCount()];
//  
//  for(TableRow row:myTable.rows()) {
//    int yearT = row.getInt("year");
//    String urlT = row.getString("url");
//    int heightT = row.getInt("height");
//    //println(row.getInt(0)); //'every tree in the forest loop' (no count)
//  }
//  
//  //it might be good to turn this into an array so that it's more usable
//  
//  for(int i = 0; i < myTable.getRowCount(); i++) {
//    println(myTable.getRow(i).getInt(0)); //could use getString for that type
//    yearsT[i] = myTable.getRow(i).getInt(0);
//    
//    println(myTable.getRow(i).getString(1));
//    urlsT[i] = myTable.getRow(i).getString(1);
//    
//    println(myTable.getRow(i).getInt(2));
//    heightsT[i] = myTable.getRow(i).getInt(2);
//  }
//
//}

void loadToyriotData() {
  Table myTable = loadTable("toyriotMedia2.csv", "header");
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
    println(myTable.getRow(i).getInt(0)); //could use getString for that type
    absTR[i] = myTable.getRow(i).getInt(0);
    
    println(myTable.getRow(i).getInt(1)); //could use getString for that type
    yearsTR[i] = myTable.getRow(i).getInt(1);
    
    println(myTable.getRow(i).getString(2));
    urlsTR[i] = myTable.getRow(i).getString(2);
    
    println(myTable.getRow(i).getInt(3));
    heightsTR[i] = myTable.getRow(i).getInt(3);
  }

}

void renderImages() {
  
  PImage webImg;
  
  for (int i = 0; i < years.length; i++) {
    float xPos = (i % 6) * (200);
    float yPos = (floor(i / 6)) * (100);
    String url = "http://nytimes.com/" + urls[i];
    println(urls[i]);
    // Load image from a web server
    webImg = loadImage(url, "jpg");
    webImg.resize(200, 0);
    image(webImg, xPos, yPos);

  }
  
  for (int i = 0; i < yearsT.length; i++) {
    float xPos = (i % 6) * (200);
    float yPos = 400 + ((floor(i / 6)) * (100));
    String url = "http://nytimes.com/" + urlsT[i];
    println(urlsT[i]);
    // Load image from a web server
    webImg = loadImage(url, "jpg");
    webImg.resize(200, 0);
    image(webImg, xPos, yPos);

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
    float scaleW = map(scale_, 1, 106, 10, 100);
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

//void renderGrid(int[] nums, int cols, float boxSize, float padding) {
//  
//  for(int i = 0; i < nums.length; i++) {
//     float x = (i % cols) * (boxSize + padding);
//     float y = (floor(i / cols)) * (boxSize + padding);
//     float w = boxSize;
//     float c = map(nums[i], 0, max(nums), 60, 255);
//     fill(c, 255, 255);
//     noStroke();
//     rect(x, y, w, w);
//  }
//}
//
//void renderCircles(int[] nums) {
//  for(int i = 0; i < nums.length; i++) {
//    float x = map(i, 0, nums.length, 100, width - 100);
//    float y = height/2;
//    //float d = map(nums[i], 0, max(nums), 0, 100); //these ellipses lie because area is exponential!
//    float d = map(sqrt(nums[i]), 0, sqrt(max(nums)), 0, 100);
//    float c = map(nums[i], min(nums), max(nums), 0, 255);
//    noFill();
//    stroke(c, 255, 0);
//    ellipse(x, y, d, d);
//  }
//}
