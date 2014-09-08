/*

 Name: Colin Narver
 Title: Communism to Terrorism ALT
 Inspired by: Evan Wu's "From Communism to Terrorism"
 Email: colin.narver@nyu.edu
 Date: 2.23.14
 Assignment: 1st realized assignment (part 2)
 
 Notes: 
 
 The concentric circles that emerge from the middle
 represent terrorism's tree rings or growth rings over the last 100 years in NYT.
 
 The larger red radial graph represents communism's prevalence in the NYT's
 headlines. 
 
 */

int[] answers;
int[] answers2;

import processing.pdf.*;

void setup() {
  size(1280, 800);
  beginRecord(PDF, "comm_terror.pdf");
  smooth(8);
  loadData("communism.csv");
  loadData2("terrorism.csv");
  
  //answers = sort(answers);
  println(max(answers));
  println(answers);
   println(max(answers2));
  println(answers2);
}

void draw() {
  background(0);
  //fill(0, 100);
  //rect(0, 0, 1280, 800);
  drawRadialGraph(answers);
  drawCircles(answers2);
  //drawGraph(answers);
  //  fill(255, 165);
  //  rect(0, 0, 1280, 800);
  //  drawGraphTwo(answers);
  //  drawGrid(answers, 40, 24);
}

void drawRadialGraph(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = width/2-75;
    float y = height/2-50;
    float w = 7;
    float h = -map(n, 0, max(numbers), 0, height*6);
    float r = map(i, 0, numbers.length, 0, TAU);
    float c = map(n, 0, max(numbers), 0, 255);
    fill(255, c, c, c);
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(r);
    rect(0, -60, w, h);
    popMatrix();
  }
}

void drawCircles(int[] numbers2) {
  for (int i = 0; i < numbers2.length; i++) {
    int n = numbers2[i];
    //    float x = map(i, 0, numbers2.length, 400, width - 400);
    float x = width/2;
    float y = height/2;
    //float d = map(sqrt(n), 0, sqrt(max(numbers)), 0, sqrt(500));
    float d = map(sqrt(n), 0, sqrt(max(numbers2)), 330, sqrt(200));
    float c = map(n, 0, max(numbers2), 0, 255);
    //    fill(c,200, c, c*2);
    noFill();
    pushMatrix();
    translate(x, y);
    rotate(HALF_PI +radians(-10));
    //    fill(#ff6600, 150);
    //    noStroke();
    stroke(255, 50);
    strokeWeight(1);
    ellipse(x-702, y-335, d*2, d*2);
    popMatrix();
  }
}

void loadData(String url) {
  Table data = loadTable(url);
  answers = new int[data.getRowCount()];

  for (int i = 0; i < data.getRowCount(); i++) {
    //get the first column of each row and put it in the array
    answers[i] = data.getRow(i).getInt(0);
  }
}

void loadData2(String url) {
  Table data2 = loadTable(url);
  answers2 = new int[data2.getRowCount()];

  for (int i = 0; i < data2.getRowCount(); i++) {
    //get the first column of each row and put it in the array
    answers2[i] = data2.getRow(i).getInt(0);
  }
}


void keyPressed() {
  if (key == 'q') {
    endRecord();
    exit();
  }
}

