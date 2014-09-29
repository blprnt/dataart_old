/*
Fletcher Bach 2014
*/

int[] counts;


void setup() {
  
  PFont myFont;
  myFont = createFont("Futura", 48);
  textFont(myFont);
  
  size(500, 700);
  loadData();  //load .csv from data folder
  
  background(#DAD6CA); //#307BA8 blue #DAD6CA grey
  //renderBackgroundArt();
  //renderBlurLayer(25);
  renderTitle();
  renderYears();
  renderCircles(counts);
  //translate(50, 50);
}

void draw() {

}

void loadData() { //Function for loading dataset
  //Table myTable = loadTable("hivaids1880to2015.csv"); 
  //Table myTable = loadTable("ebola1880to2015.csv");
  //Table myTable = loadTable("typhus1880to2015.csv");
  //Table myTable = loadTable("bubonicplague1880to2015.csv");
  //Table myTable = loadTable("cholera1880to2015.csv");
  Table myTable = loadTable("tb1880to2015.csv");
  counts = new int[myTable.getRowCount()];


  for (int i = 0; i < myTable.getRowCount (); i++) { //Iterates through counts array 
    counts[i] = myTable.getRow(i).getInt(0);
  }
}

void renderCircles(int[] nums) {  //Function for displaying circles 
    for (int i=0; i < nums.length; i++) {
    float x = map(i, 0, nums.length, 60, width-60); //i mapped to length of nums with buffer
    float y = height/2; //Mid line
    float d = map(sqrt(nums[i]), 0, sqrt(max(nums)), 0, 100); 
    float o = map(nums[i], min(nums), max(nums), 0, 255); //o mapped to nums values
    noFill();
    stroke(#8B9465); //#DE3501
    strokeWeight(1.5);
    smooth();
    //noStroke();
    //fill(224, 70, 9, ((o + 1) * 50)); //opacity linked to values from dataset
    ellipse(x, y, d, d);
    strokeWeight(0.75);
    line(66, height/2, width-60, height/2); // line from 1880 to 2014
  }
}

void renderTitle() {  //Function for displaying disease title
  int titleLocX = 15;
  int titleLocY = 100 - 20;
  fill(#786B7F); //#E59C00
  textSize(66); //120
  text("TUBERCULOSIS", titleLocX, titleLocY);  //insert name of disease
}

void renderYears() {  //Function for displaying year range
  int startX = width/20;
  int startY = height - 50;
  int endX = width/10 * 8;
  int endY = height - 50;
  int startYear = 0;
  int endYear = 2014;
  textSize(28);
  fill(#786B7F); //#E0AA01
  text("1880", startX, startY); //start year
  text("2014", endX, endY); //end year
}

void renderBackgroundArt() {
   noStroke();
   
   fill(0);
   beginShape();          //making color varied sections using polygons
   vertex(0,0);
   vertex(width/2, 0);
   vertex(0,0);
   vertex(0, height/4);
   vertex(0, height/4);
   vertex(width/2, 0);
   endShape();
   
//   fill();
//   beginShape();          //shape 2
//   vertex(0,0,width/2,0);
//   vertex(0);
//   endShape();
//   
//   fill();
//   beginShape();         //shape 3 
//   vertex(0,0,width/2,0);
//   vertex(0);
//   endShape();
}

void renderBlurLayer(int layerAlpha){
  layerAlpha = 50;
  noStroke();
  fill(0,0,0,layerAlpha);
  rect(width, height, width, height);
  noFill();
}

