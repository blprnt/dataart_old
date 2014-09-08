/*

ITP Data Art 
Good & PLenty Project - Data & Aesthetics Week 3 Assignment
By Michelle Chandra and Diana

This sketch outputs 3 bar label graphs using data from NYT.

*/


int[] answers;  

void setup() {
  size(1280, 720);
  smooth(8);

  loadData();
  //answers = sort(answers);
  println(answers);
}

void draw() { //keep setup and draw mostly clear; if there's a section of instructions that
  //in your head you can describe what they do, write a function
  background(255);
  drawGraph(answers);
 // drawCircles(answers);
}

/*
// This draws the Heroin Bar Label Graph
void drawGraph(int[] numbers) { //you want to viewer to know what's going on as quickly as possible
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 700, width - 350);  // position along the horizon
    float y = height;  // this puts the bar graph at the bottom of the sketch
   
    //println("n - " + n);
    float w = map(n, 0, 100, 0, 10);
    float h = -(height - 100);
   //float w = 20; // static value for the width of the rectangles
    //float h = -map(n, 0, 70, 0, height - 100); // mapping the numbers in the data to the height of each rectangle
    fill(0);
    rect(x, y, w, h);
  }
}
*/

/*
// This draws the Cocaine Bar Label Graph
void drawGraph(int[] numbers) { //you want to viewer to know what's going on as quickly as possible
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 700, width - 350);  // position along the horizon
    float y = height;  // this puts the bar graph at the bottom of the sketch
   
    //println("n - " + n);
    float w = map(n, 0, 100, 0, 10);
    float h = -(height - 100);
   //float w = 20; // static value for the width of the rectangles
    //float h = -map(n, 0, 70, 0, height - 100); // mapping the numbers in the data to the height of each rectangle
    fill(0);
    rect(x, y, w, h);
  }
}
*/



// This draws the OxyContin bar label Graph
void drawGraph(int[] numbers) { //you want to viewer to know what's going on as quickly as possible
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 700, width - 350);  // position along the horizon
    float y = height;  // this puts the bar graph at the bottom of the sketch
   
    //println("n - " + n);
    float w = map(n, 0, 100, 0, 10);
    float h = -(height - 100);
   //float w = 20; // static value for the width of the rectangles
    //float h = -map(n, 0, 70, 0, height - 100); // mapping the numbers in the data to the height of each rectangle
    fill(0);
    rect(x, y, w, h);
  }
}


void loadData() {
// Use OxyContin NYT Mentions Data (1996 - 2013)
 Table data = loadTable("oxycontin2.csv", "header"); 
 
// Use Cocaine NYT Mentions Data (1996 - 2013)
// Table data = loadTable("cocaine.csv", "header"); 

// Use Heroin NYT Mentions Data (1996 - 2013)
//Table data = loadTable("heroin.csv", "header"); 

  answers = new int[data.getRowCount()];
  for (int i = 0; i < data.getRowCount(); i++) {
    answers[i] = data.getRow(i).getInt(1);  //
  }
}

