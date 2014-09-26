/*

 Simple NYTimes Viz Example
 September, 2014
 blprnt@blprnt.com
 
 */

// WEEK 2, Class Exercise

//"Mise En Place"
PImage issImg;
int[] counts;
float r = 100;

void setup() {
  size(1440, 900);
  //colorMode(HSB);
  issImg = loadImage("iss.jpg");
  loadData();
}

void draw() {
  background(0);
  //renderCircles(counts);
  renderCircles2(counts);
  translate(50, 50);
  image(issImg, -100, height/2, 1540, height/2);
  //renderGrid(counts, 10, 30, 5)
}

void loadData() {

  //Load the table
  Table myTable = loadTable("issData.csv");
  counts = new int[myTable.getRowCount()];

  //For Loop Type: "Every Tree in the Forest" Loop

  /* 
   for (TableRow row:myTable.rows()) {
   println(row.getInt(0));
   
   }
   //*/

  //For Loop Type: Indexed Loop

  for (int i = 0; i < myTable.getRowCount (); i++) {
    //println(myTable.getRow(i).getInt(0));
    counts[i] = myTable.getRow(i).getInt(0);
  }
}

//void renderGrid(int[] nums, int cols, float boxSize, float padding) {
//
//  for (int i=0; i < nums.length; i++) {
//    float x = (i % cols) * (boxSize + padding);
//    float y = (floor(i/cols)) * (boxSize + padding);
//    float w = boxSize;
//    float c = map(nums[i], 0, max(nums), 0, 255);
//    fill(c, 255, 255);
//    noStroke();
//    rect(x, y, w, w);
//  }
//}

void renderCircles(int[] nums) {

  for (int i=0; i < nums.length; i++) {
    //Mapping Choices (all possible things that I could map the data to)
    float x = map(i, 0, nums.length, 100, width-100); //Index mapped to length of nums with buffer of 100
    float y = height/2; //Arbitrary
    float d = map(sqrt(nums[i]), 0, sqrt(max(nums)), 0, 10); //Diameter mapped, MUST square root these numbers if using an ellipse
    float c = 255;
    //float c = map(nums[i], min(nums), max(nums), 0, 255);
    //noFill();
    fill(c, 255, 255);
    stroke(255);
    ellipse(x, y, d, d);
  }
}

void renderCircles2(int[] nums) {
  float arclength = 0;
  
  for (int i=0; i < nums.length; i++) {
    //Mapping Choices (all possible things that I could map the data to)
    float x = map(i, 0, nums.length, 0, width); //Index mapped to length of nums with buffer of 100
    float y = height/4; //Arbitrary
    float d = map(sqrt(nums[i]), 0, sqrt(max(nums)), 0, 20); //Diameter mapped, MUST square root these numbers if using an ellipse
    float c = 255;

    //arclength += /2;
    //float theta = arclength / r;
    //pushMatrix();
    //translate(r*cos(theta) , r*sin(theta));
    //rotate(theta);
    //float c = map(nums[i], min(nums), max(nums), 0, 255);
    //noFill();
    //fill(255, 255, 255, 0.5);
    stroke(255);
    ellipse(x, y, d, d);
    //popMatrix();
    //arclength += d/2;
  }
}
