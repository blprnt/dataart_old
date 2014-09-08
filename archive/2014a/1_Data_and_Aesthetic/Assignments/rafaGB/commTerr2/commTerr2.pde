/*

 "Wanted": communism and terrorism in the NYT
 
rafagrossbrown@gmail.com
 
feb 24 2014
 
 CSV war.csv can be replaced with any int list
 
 */
PImage img;
int[]communism;
int[]terrorism;
  
void setup() {
  size(1280, 720);
  smooth();
  loadDataC("communism.csv");
  loadDataT("terrorism.csv");
//load commTerr png
  img = loadImage("dart_backg_dark.png");
    
}

void draw() {
  background(255);
  image(img, 0, 0);
  noStroke();
  drawRectC(communism);
  drawRectT(terrorism);
  
  for(int i=0; i<width; i=i+5){
    strokeWeight(2);
    stroke(0,90);
  point(i,height/2);
  }
//    for(int i=0; i<height; i=i+5){
//    strokeWeight(2);
//    stroke(255,90);
//  point(width/2,i);
//  }
 
}

void drawRectC(int[] communism) {
  for (int i = 0; i < communism.length; i=i+1) {
    int n = communism[i];
    float x = width/2+200;
    float y = height/2;
    float d = map(sqrt(n), 0, sqrt(max(communism)), 0, sqrt(1000));
   fill(240,20,40,80);

    rect(20+i*10, height/2, 10, d*10);
  }
}

void drawRectT(int[] terrorism) {
  for (int i = 0; i < terrorism.length; i=i+1) {
    int n = terrorism[i];
    float x = width/2;
    float y = height/2;
    float d = map(sqrt(n), 0, sqrt(max(terrorism)), 0, sqrt(1000)); 
        fill(230,20,20,90);
    rect(20+i*10, height/2, 10, -(d*10));

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

