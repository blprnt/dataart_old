/*

 Simple NYTimes Viz Example
 September, 2014
 blprnt@blprnt.com
 
 */

int[] counts;

void setup() {
  size(800, 600);
  colorMode(HSB);
  loadData();
}

void draw() {
  background(0);
  //renderCircles(counts);
  translate(50,50);
  renderGrid(counts, 10, 30, 5);
}

void loadData() {
  Table myTable = loadTable("monkeyData.csv");
  counts = new int[myTable.getRowCount()];
  /*
  for (TableRow row:myTable.rows()) {
    println(row.getInt(0));
  }
  //*/

  for (int i = 0; i < myTable.getRowCount(); i++) {
    //println(myTable.getRow(i).getInt(0));
    counts[i] = myTable.getRow(i).getInt(0);
  }
}

void renderGrid(int[] nums, int cols, float boxSize, float padding) {
  
  for(int i = 0; i < nums.length; i++) {
    float x = (i % cols) * (boxSize + padding);
    float y = (floor(i/cols)) * (boxSize + padding);
    float w = boxSize;
    float c = map(nums[i], 0, max(nums), 60, 255);
    fill(c,255,255);
    noStroke();
    rect(x,y,w,w);
  }
}

void renderCircles(int[] nums) {
  for(int i = 0; i < nums.length; i++) {
    float x = map(i, 0, nums.length, 100, width - 100);
    float y = height/2;
    float d = map(sqrt(nums[i]), 0, sqrt(max(nums)), 0, 100);
    float c = map(nums[i], 0, max(nums), 0, 255);
    noFill();
    stroke(255,c,0);
    ellipse(x,y,d,d);
    //rect(x,y,10,d);
  }
}
