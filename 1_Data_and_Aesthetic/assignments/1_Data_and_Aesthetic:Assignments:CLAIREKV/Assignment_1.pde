
int num=50;
float[]maleBT;
float[]femaleBT;
int[]maleHR;
int[]femaleHR;

import processing.pdf.*;

void setup() {
  strokeCap(SQUARE);
  background(0);
  stroke(0);
  size (900, 900);
  loadMData ();
  loadFData ();
  colorMode(HSB, 100);
  
  beat1(maleHR);
  heat1(maleBT);
//  heat2(femaleBT);
//  beat2(femaleHR);
//  
}

void draw() {
}

void loadMData() {
  Table myTable= loadTable ("tempMF.csv");
  maleBT= new float[myTable.getRowCount()];
  maleHR= new int[myTable.getRowCount()];
  for (int i=0; i<65; i++) {
    TableRow row = myTable.getRow(i);
    maleBT[i]=row.getFloat(0);
    maleHR[i]=row.getInt(1);

  }
}


void loadFData() {
  Table myTable= loadTable ("tempMF.csv");
  femaleBT= new float[myTable.getRowCount()];
  femaleHR= new int[myTable.getRowCount()];
  for (int i=0; i< myTable.getRowCount(); i++) {
    TableRow row = myTable.getRow(i);
    femaleBT[i]=row.getFloat(2);
    femaleHR[i]=row.getInt(3);
  }
}




void heat1(float[]vals) {
  for (int i=0; i<vals.length; i++) {
    stroke(255);
    fill(100, 0, 100, 5);
    float d=map(vals[i], 96, 99.5, 0, 150);
    ellipse(width/2, height/2, d*2,d*2);
  }
}

void beat1(int[]vals){
 for (int i=0;i<vals.length; i++){
    float y=map(vals[i], 58, 82, 0, 350);
    stroke(100, 0, 100,random(10,25));
    strokeWeight(random(5));
    pushMatrix();
    translate(width/2, height/2);
    rotate(TWO_PI/vals.length*i);
    line(0,0,y,0);
    popMatrix();
    println(y+"y val");
    

 }
 
}


void heat2(float[]vals) {
  for (int i=0; i<vals.length; i++) {
    stroke(255);
    fill(100, 0, 100, 5);
    float d=map(vals[i], 96, 100.8, 0, 180);
    ellipse(width/2, height/2, d*2, d*2);
//    println(vals[i]+ " " + d);
  }
}




void beat2(int[]vals){
 for (int i=0;i<vals.length; i++){
    float y=map(vals[i], 58, 82, 0, 320);
    stroke(100, 0, 100,random(10,25));
    strokeWeight(random(5));
    pushMatrix();
    translate(width/2, height/2);
    rotate(TWO_PI/vals.length*i);
    line(0, 0,y,0);
    println(y+"y val");
    popMatrix();

 }
 
}
// float y=map(vals[i], 58, 82, 0, height/2-50);
//  stroke(100, 0, 100,10);
//  strokeWeight(22);
//  line(i*16.5, height, i*16.5, y+410);
//  stroke(100, 0, 100,20);
//  strokeWeight(21);
//  line(i*16.5, height, i*16.5, y+410);
//  stroke(100, 0, 100);
//  strokeWeight(15);
//  line(i*16.5, height, i*16.5, y+410);
//noStroke();
//fill(100, 0, 100);
//ellipse(i*16.5, y+random(410,700), 1, 1);
//ellipse(i*16.5, y+random(410,700), 1, 1);
// } 
//}




