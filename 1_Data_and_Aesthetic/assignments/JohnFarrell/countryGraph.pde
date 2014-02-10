int[] answers;
import processing.pdf.*;
String[] colorList = {

  //blues
    "ff084081", 
    "ff2b8cbe", 
    "ff4eb3d3", 
    "ff0868ac", 

  // pinks
//   "ffdf65b0",
//   "ffdd1c77",
//   "ff980043",

  //GREENS
//  "ff41ae76", 
//  "ff238b45", 
//  "ff006d2c", 
//  "ff00441b", 

  //  reds
//      "ffd7301f", 
//      "ff7f0000", 
//      "ffb30000", 
//      "ffef6548", 
  //  
  //purple
//   "ff6a51a3",
//   "ff54278f",
//   "ff3f007d",

  //whites
  //   "ffffffff", 
  //   "fff0f0f0", 
  //   "ffd9d9d9", 
  //   "ffbdbdbd"
};

color getColor(float f) {
  //f is a number between 0 and 1
  //so let's convert it to an int to pick from the array
  int i = floor(f*(colorList.length-1));
  // ^^Note -1 to keep array in bounds
  color col = unhex(colorList[i]);
  return(col);
}

void setup() {
 // size(1280, 720, PDF, "France.pdf");
  size(1280,720);
  colorMode(HSB);
  smooth();
  loadData("nigeriaData.csv");

 // println(answers);
  background(255);
  drawCrystalGraph(answers);
}

void draw() {

  //used for PDF output
  // println("finished");
  //exit();
}



void loadData(String url) {
  Table data = loadTable(url);
  answers = new int[data.getRowCount()];
  for (int i=0; i < data.getRowCount(); i++) {
    //get the second column of each row and put it in the array
    answers[i] = data.getRow(i).getInt(0);
    //println(row.getString(1)); 
    //for every tablerow Row, do something with each of the rows
  }
}


void drawCrystalGraph(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = width/2;
    float y = height/2;
    float w = 5;
    float h = -map(n, 0, max(numbers), 0, height/3);
    float c = map(n, 0, max(numbers), 0, 255);
    color col = getColor(map(n, 0, max(numbers), 0, 1));
    float r = map(i, 0, numbers.length, 0, PI);
    fill(col,125);
    noStroke();

    pushMatrix();
    translate(x, y);
    rotate(r);
    for (float b = 10; b < height/2; b+=100) {
      ellipse(0, b, w, h);
    }
    popMatrix();
  }
}

