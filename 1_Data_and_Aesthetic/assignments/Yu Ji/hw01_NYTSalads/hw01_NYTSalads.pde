/*
 09/20/2014
 Yu Ji
 DataArt_HW01: Data and Aesthetic
 Exploring NYTimes Article Search v2 API 
 Title: "The Meaningless Use of Nonsense Data for Aesthetic Pleasure (and Bon Appetite!)" 
 */

import processing.pdf.*;
int[] ingredient1;
int[] ingredient2;
int[] ingredient3;
int[] ingredient4;
int[] ingredient5;
int[] ingredient6;
int[] ingredient7;

void setup() {
  size(1280, 720, P3D);

  ingredient1 = loadData("lettuce.csv"); //15,471 //163
  ingredient2 = loadData("apple.csv"); //120,4803 //3385
  ingredient3 = loadData("orange.csv"); //1021,4526 //2838
  ingredient4 = loadData("chicken.csv"); //69,2972 //1584
  ingredient5 = loadData("oliveoil.csv"); //21,1575 //647
  ingredient6 = loadData("vinegar.csv"); //10,726 //285
  ingredient7 = loadData("pepper.csv"); //86,2357 //1049
}

void draw() {
  beginRecord(PDF, "assignment1.pdf");
  smooth();
  colorMode(RGB);
  background(30, 30, 30); 

  drawWaveGraph(ingredient1, 0, round(0.57*height), color(121, 181, 93));//lettuce--green
  drawWaveGraph(ingredient4, 0, round(0.15*height), color(247, 186, 46));//chicken--white/yellow
  drawWaveGraph(ingredient3, 0, round(0.08*height), color(255, 153, 0));//orange--orange
  drawWaveGraph(ingredient2, 0, round(0.08*height), color(219, 106, 64));//apple--red
  drawWaveGraph(ingredient5, 0, round(0.06*height), color(100, 84, 1) );//oliveoil
  drawWaveGraph(ingredient6, 0, round(0.04*height), color(116, 21, 29));//vinegar--wine
  drawWaveGraph(ingredient7, 0, round(0.02*height), color(69, 42, 35));//pepper-- 2

  fill(255, 255, 255);
  PFont font;
  font=createFont("OpenSans-Bold", 100);
  textAlign(RIGHT);
  textFont(font, 20);
  text("NYT Salads", width - 20, height - 80);
  text("Frequency of 'Lettuce/ Chicken/ Orange/ Apple/ Olive Oil/ Vinegar/ Pepper' Over 100 Years", width - 20, height - 50);
  text("The Meaningless Use of Nonsense Data for Aesthetic Pleasure (and Bon Appetite!)", width - 20, height - 20);

  endRecord();
}

void drawWaveGraph(int[] numbers, int a, int b, color c) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = width/2;
    float y = height/2 + 70;
    float w = 15;
    float h = -map(n, 0, max(numbers), a, b);
    float r = map(i, 0, numbers.length, 0, 2*PI); //TAU=2*PI
    //    float c = map(n, 0, max(numbers), 0, 255);

    //    println(max(numbers));
    //    println(min(numbers));
    //    println(numbers[99]);

    fill(c);
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(r);
    rect(0, 0, w, h);
    popMatrix();
  }
}

int[] loadData(String url) {
  Table data = loadTable(url);
  int[] array = new int[data.getRowCount()];

  for (int i = 0; i < data.getRowCount(); i++) {
    //get the first column of each row and put it in the array
    array[i] = data.getRow(i).getInt(0);
  }
  return array;
}

