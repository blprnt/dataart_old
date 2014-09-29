/*

 Modified Simple NYTimes Viz Example - Aesthetic focus Static Data Viz
 September 22, 2014
 blprnt@blprnt.com
 
 */

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
  renderCircles3(counts);
  renderCircles2(counts);
  renderCircles(counts);
  translate(50, 50);
  image(issImg, -100, height/2, 1540, height/2);
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

void renderCircles(int[] nums) {
  float arclength = 0;
  
  for (int i=0; i < nums.length; i++) {
    //Mapping Choices (all possible things that I could map the data to)
    float x = map(i, 0, nums.length, 25, width-10); //Index mapped to length of nums with buffer of 100
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
    noStroke();
    ellipse(x, y, d, d);
    //popMatrix();
    //arclength += d/2;
  }
}

void renderCircles2(int[] nums) {

  for (int i=0; i < nums.length; i++) {
    //Mapping Choices (all possible things that I could map the data to)
    float x = map(i, 0, nums.length, -45, width+45); //Index mapped to length of nums with buffer of 100
    float y = height/6.5; //Arbitrary
    float d = map(sqrt(nums[i]), 0, sqrt(max(nums)), 0, 10); //Diameter mapped, MUST square root these numbers if using an ellipse
    float c = 255;
    //float c = map(nums[i], min(nums), max(nums), 0, 255);
    //noFill();
    fill(c, 255, 255, 150);
    ellipse(x, y, d, d);
  }
}

void renderCircles3(int[] nums) {

  for (int i=0; i < nums.length; i++) {
    //Mapping Choices (all possible things that I could map the data to)
    float x = map(i, 0, nums.length, -300, width+300); //Index mapped to length of nums with buffer of 100
    float y = height/14; //Arbitrary
    float d = map(sqrt(nums[i]), 0, sqrt(max(nums)), 0, 10); //Diameter mapped, MUST square root these numbers if using an ellipse
    float c = 255;
    //float c = map(nums[i], min(nums), max(nums), 0, 255);
    //noFill();
    fill(c, 255, 255, 70);
    ellipse(x, y, d, d);
  }
}
