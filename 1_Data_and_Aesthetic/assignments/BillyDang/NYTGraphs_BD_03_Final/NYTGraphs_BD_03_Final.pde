/*
 20140208
 NYTimes Data Exploration
 Billy Dang
 binhdang555@gmail.com
 
 */
import processing.pdf.*;
boolean numbers[][] = new boolean[10][10];
int[] answers;
int[] answers2;
int[] answers3;

void setup() {
  size(720, 720);
  smooth(8);
  answers = loadData("redData.csv");
  answers2= loadData("greenData.csv");
  answers3= loadData("blueData.csv");

  println(max(answers));
  
  beginRecord(PDF, "RGB_blue.pdf");


}

void draw() {

  background(0);
  blendMode(BLEND);
//  drawRadialGraph(answers, 10, 50, 1); //red
//  drawRadialGraph(answers2, 10, 50, 2); //green
  drawRadialGraph(answers3, 10, 50, 3); //blue
  

}


void drawRadialGraph(int[] numbers, int cols, float s, int dir) {
  for (int i = 0; i < numbers.length; i++) {
    //Draw every block in the grid
    int n = numbers[i];
    float x = (i % cols) * s +130;
    float y = floor(i / cols) * s +130;
    float d = -map(n, 0, max(numbers), 0, height/8);
    float c = map(n, 0, max(numbers), 0, 255);

    if (dir==1) // red
      fill(255, 0, 0, c);
    else if (dir==2)// green
      fill(0, 255, 0, c);
    else // blue
    fill(0, 0, 255, c);

    ellipseMode(CENTER);
    ellipse(x, y, d, d);
    noStroke();
  }
  
    endRecord();

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

//void keyPressed() {
//  switch (key) {
//  case 'p': 
//    saveFrame("NYT_RGB_Grid-#####.png"); 
//  }
//}





