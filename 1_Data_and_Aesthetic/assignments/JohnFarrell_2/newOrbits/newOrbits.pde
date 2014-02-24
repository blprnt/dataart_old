/*

 New Orbits
 johnefarrell18@gmail.com
 Feb 22, 2014
 - The CSV can be replaced with any csv
 
 */

int[] answers;
import processing.pdf.*; 


void setup() {
  colorMode(HSB);
  //size(1280, 720, PDF, "uranus.pdf");
  size(1280, 720);
  background(255);

  loadData("uranus.csv");
  drawOutlineGraph(answers);
  smooth();
}

void draw() {
 // println("finished");
  //exit();
}

void loadData(String url) {
  Table data = loadTable(url);
  answers = new int[data.getRowCount()];
  for (int i=0; i < data.getRowCount(); i++) {
    //get the second column of each row and put it in the array
    answers[i] = data.getRow(i).getInt(0);
  }
}


void drawOutlineGraph(int[] numbers) {
  translate(width/2, height/2);
  float angle = 0;
  float increment = (float)PI*50/ (float)numbers.length;

  beginShape();
  int j = 300;
  for (int i = 0; i < numbers.length; i+=1) {
    int value = numbers[i];
    int radius = (int)map(value, 0, max(numbers), 100, j);
    float x = radius * cos(angle);
    float y = radius * sin(angle);
    
    angle += increment;

    strokeWeight(2);
    stroke(#48B4B7);
    noFill();
    vertex(x, y);
  }
  endShape(CLOSE);
}

