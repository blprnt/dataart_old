/* 
 Top 10 Infectious Disease of 20th Century
 NYTime Article Count by Year
 katieadee@gmail.com  
 2/6/14
 */
import processing.pdf.*;
boolean record;

//cound have done this in a 2D array but needed to test a few things
int[] typhoid;
int[] tetanus;
int[] polio;
int[] pneumonia;
int[] pertussis;
int[] measles;
int[] malaria;
int[] influenza;
int[] diptheria;
int[] pox;


void setup() {
  //used this line to save a quick static pdf after 
  size(1000, 1000);
  smooth(8);

  noStroke();
  //fill each array with data we want
  typhoid = loadData("typhoid10Data.csv");
  tetanus =loadData("tetanus09Data.csv");
  polio = loadData("polio08Data.csv");
  pneumonia = loadData("pneumonia07Data.csv");
  pertussis = loadData("pertussis06Data.csv");
  measles = loadData("measles05Data.csv");
  malaria = loadData("malaria04Data.csv");
  influenza = loadData("hflu03Data.csv");
  diptheria = loadData("diptheria02Data.csv");
  pox = loadData("chickenpox01Data.csv");
}

void draw() {
  if (record) {
    // record frame as a pdf for editing inillustrator
    beginRecord(PDF, "germBandsColor2.pdf");
  }

  background(0);

  //draw bands for each disease, this could be done in setup as well
  drawBands(typhoid, 0);
  drawBands(tetanus, 100);
  drawBands(polio, 200);
  drawBands(pneumonia, 300);
  drawBands(pertussis, 400);
  drawBands(measles, 500);
  drawBands(malaria, 600);
  drawBands(influenza, 700);
  drawBands(diptheria, 800);
  drawBands(pox, 900);

  if (record) {
    endRecord();
    record = false;
  }
}

int[] loadData(String url) {
  // load the file as a table
  Table data = loadTable(url);
  int[] answers = new int[data.getRowCount()];
  //for each table row as rows in data
  for (int i=0; i<data.getRowCount(); i++) {
    //get the row, then get the first and only column for this data set
    answers[i] = data.getRow(i).getInt(0);
  }
  return answers; //return it so we can seperate counts with seperate arrays
}

void drawBands(int[] numbers, float ypos) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 0, width);
    float y = ypos;
    float w = width/numbers.length;
    //map alph to hits
    float a = map(n, 0, max(numbers), 0, 255);
    noStroke();
    //more opaque = more hits
    fill(5,255,240, a);
    rect(x, y, w, 100);
  }
}

void drawRadialGraph(int[] numbers, float cx, float cy) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x =0;
    float y = 0;
    float w = 5;
    float h = -map(n, 0, max(numbers), 0, height/2);
    float r = map(i, 0, numbers.length, 0, TAU);
    float c = map (n, 0, max(numbers), 0, 255);
    //red-yellow color range
    fill(255, c, 0);
    pushMatrix();
    translate(cx, cy);
    rotate(r);
    rect(0, -50, w, h);
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's')  record = true;
}
/* these options are not used for this sketch
 void drawGraph(int[] numbers, float y) {
 for (int i = 0; i < numbers.length; i++) {
 int n = numbers[i];
 float x = map(i, 0, numbers.length, 100, width-100);
 //float y = height-100;
 float w = 5;
 float h = -map(n, 0, max(numbers), 0, height-100);
 rect(x, y, w, h);
 }
 }
 
 void drawCircles(int[] numbers) {
 for (int i = 0; i < numbers.length; i++) {
 int n = numbers[i];
 float x = map(i, 0, numbers.length, 100, width-100);
 float y = height/2;
 //square root all THREE numbers. fix in other file
 float d = map(sqrt(n), 0, sqrt(max(numbers)), 0, sqrt(500));
 ellipse(x, y, d, d);
 }
 }
 
 //*/
