/*

Name: Colin Narver
Title: The Word of God
Email: colin.narver@nyu.edu
Date: February 9, 2014
Assignment: 1st realized assignment

- Helpful note: the CSV god.csv lists the number of times
God was included in NY Times headlines over the last 100 years.
It has exponentially increased over the last two years, which
bears further investigation. 

Examples:
1914
"On the Side of God."
1915
For God to See.
1916
God Is Good
1917
Kaiser Ascribes Victories in Italy to Judgment of God

*/

int[] answers;

String[] colorList = {
  "FF000000", 
  "FF252525", 
  "FF525252", 
  "FF737373", 
  "FF969696", 
  "FFbdbdbd", 
  "FFd9d9d9", 
  "FFf0f0f0", 
  "FFffffff"
};

color getColor(float f) {
  //f is a number between 0 and 1
  // so let's convert it to an int to pick from the array 

  int i = floor( f * (colorList.length - 1));
  color col = unhex(colorList[i]);
  return(col);
}

import processing.pdf.*;

void setup() {
  size(1280, 800);
  beginRecord(PDF, "colin_god_sketch.pdf");
  smooth(8);
  loadData("God.csv");
  //answers = sort(answers);
  println(max(answers));
  //println(answers);
}

void draw() {
  background(0);
  fill(0, 100);
  rect(0, 0, 1280, 800);
  //  drawCircles(answers);
  drawRadialGraph(answers);
  drawGraph(answers);
  fill(255, 165);
  rect(0, 0, 1280, 800);
  drawGraphTwo(answers);
  drawGrid(answers, 40, 24);
}

void drawRadialGraph(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = width/3+55;
    float y = height/2-149;
    float w = 9;
    float h = -map(n, 0, max(numbers), 0, height*6);
    float r = map(i, 0, numbers.length, 0, TAU);
    float c = map(n, 0, max(numbers), 0, 255);
    fill(0, c, c, 150);
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(r);
    rect(0, -60, w, h);
    popMatrix();
  }
}

void drawGraph(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    //    float x = map(i, 0, numbers.length, 100, width - 100);
    float x = map(i, 0, numbers.length, 0, width-800);
    float y = height;
    float w = 3;
    float h = -map(n, 0, max(numbers), 0, height-100 );
    pushMatrix();
    translate(x, y);
    rotate(HALF_PI +radians(40));
    fill(255, 90);
    rect(-x-18, -y+1200, w*2, h*2);
    popMatrix();
  }
}

void drawGraphTwo(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    //    float x = map(i, 0, numbers.length, 100, width - 100);
    float x = map(i, 0, numbers.length, 0, width-790);
    float y = height;
    float w = 3;
    float h = -map(n, 0, max(numbers), 0, height-100 );
    fill(255, 1800);
    rect(x, y, w, h);
  }
}


//void drawCircles(int[] numbers) {
//  for (int i = 0; i < numbers.length; i++) {
//    int n = numbers[i];
//    float x = map(i, 0, numbers.length, 100, width - 100);
//    float y = height/2;
//    //float d = map(sqrt(n), 0, sqrt(max(numbers)), 0, sqrt(500));
//    float d = map(sqrt(n), 0, sqrt(max(numbers)), 50, sqrt(60));
//    fill(#ff6600, 150);
//    noStroke();
//    ellipse(x, y, d, d);
//  }
//}


void drawGrid(int[] nums, int cols, float s) {
  for (int i = 0; i < nums.length; i++) {
    int n = nums[i];
    float x = (i % cols) * s;
    float y = floor(i / cols) * s;
    float c = map(n, 0, max(nums), 0, 255);
    //fill(c);
    color col = getColor(map(n, 0, max(nums), 0, 1));
    //  fill(c,255,0);
    fill(col);
    noStroke();
    rect(x, y, s, s);
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

void keyPressed() {
  if (key == 'q') {
    endRecord();
    exit();
  }
}


