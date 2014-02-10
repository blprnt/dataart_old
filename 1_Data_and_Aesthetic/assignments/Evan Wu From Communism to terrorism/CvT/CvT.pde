/*

 NYTimes Data Exploration
 From Communism to Terrorism
 
 chw323@nyu.edu
 
 2014/FEB/10
 
 CSV war.csv can be replaced with any int list
 
 */

int[]communism;
int[]terrorism;
PShape title;


String[] colorListC= {
//  "FFfff5f0", 
  "FFfee0d2", 
  "FFfcbba1", 
  "FFfc9272", 
  "FFfb6a4a", 
  "FFef3b2c", 
  "FFcb181d", 
  "FFa50f15", 
  "FF67000d",
};

String[] colorListT= {
//  "FFffffff", 
//  "FFf0f0f0", 
//  "FFd9d9d9", 
//  "FFbdbdbd", 
//  "FF969696", 
//  "FF737373", 
//  "FF525252", 
//  "FF252525", 
//  "FF000000",

//"FFf7fbff",
"FFdeebf7",
"FFc6dbef",
"FF9ecae1",
"FF6baed6",
"FF4292c6",
"FF2171b5",
"FF08519c",
"FF08306b",
};

color getColorC(float f) {
  //f is a number between 0 and 1
  //so let's convert it to an int to pick form an array
  int i=floor(f*(colorListC.length-1));
  color colC=unhex(colorListC[i]);
  return(colC);
}

color getColorT(float t) {
  int i=floor(t*(colorListT.length-1));
  color colT=unhex(colorListT[i]);
  return(colT);
}

void setup() {
  size(1280, 720);
  smooth();
  loadDataC("communism.csv");
  loadDataT("terrorism.csv");
title = loadShape("CvT.svg");
}

void draw() {
  background(255);
  drawCirclesC(communism);
  drawCirclesT(terrorism);
  shape(title, width/2-52,height/2-50);
}

void drawCirclesC(int[] communism) {
  for (int i = 0; i < communism.length; i++) {
    int n = communism[i];
    float x = width/2;
    float y = height/2;
    float d = map(sqrt(n), 0, sqrt(max(communism)), 0, sqrt(1000));
    float r = map(i, 0, communism.length, 0, TAU);
    color colC=getColorC(map(n, 0, max(communism), 0, 1));
    fill(colC, 150);
    noStroke();

    pushMatrix();
    translate(x, y);
    rotate(r);
    ellipse(0, -200, d*2, d*2);
    popMatrix();
  }
}

void drawCirclesT(int[] terrorism) {
  for (int i = 0; i < terrorism.length; i++) {
    int n = terrorism[i];
    float x = width/2;
    float y = height/2;
    float d = map(sqrt(n), 0, sqrt(max(terrorism)), 0, sqrt(1000));
    color colT=getColorT(map(n, 0, max(terrorism), 0, 1));
    float r = map(i, 0, terrorism.length, 0, TAU);
    fill(colT, 150);
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(r);
    ellipse(0, -200, d*2, d*2);
    popMatrix();
  }
}

void loadDataC(String fileName) {
  String[]rows=loadStrings(fileName);
  communism=new int[rows.length];
  for (int i=0; i<rows.length; i++) communism[i]=int(rows[i]);
}

void loadDataT(String fileName) {
  String[]rows=loadStrings(fileName);
  terrorism=new int[rows.length];
  for (int i=0; i<rows.length; i++) terrorism[i]=int(rows[i]);
}

