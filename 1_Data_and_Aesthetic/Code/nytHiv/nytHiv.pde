/*
Modified from: 
 blprnt@blprnt.com
 September, 2014
 */

int[] counts;

void setup() {
  size(1200, 400);
  loadData();  //load data
}

void draw() {
  background(245, 232, 191);
  renderCircles(counts);
  translate(50, 50);
  //renderGrid(counts, 10, 30, 5);
}

void loadData() { //Function for loading dataset

  Table myTable = loadTable("hiv.csv");
  counts = new int[myTable.getRowCount()];


  for (int i = 0; i < myTable.getRowCount (); i++) { //Iterates through counts array 
    counts[i] = myTable.getRow(i).getInt(0);
  }
}


void renderCircles(int[] nums) {

  for (int i=0; i < nums.length; i++) {
    float x = map(i, 0, nums.length, 100, width-100); //i mapped to length of nums with buffer
    float y = height/2; //Mid line
    float d = map(sqrt(nums[i]), 0, sqrt(max(nums)), 0, 100); 
    float o = map(nums[i], min(nums), max(nums), 0, 255); //o mapped to nums values
    noFill();
    noStroke();
    fill(224, 70, 9, ((o + 1) * 50)); //opacity linked to values from dataset
    ellipse(x, y, d, d);
  }
}

