/* 
 
 ITP Data Art
 Julia Irwin
 jairwin06@gmail.com
 
 Frequency of God (NYTimes); visuals created with bible verses
 
 Sources code from Jer Thorpe
 Uses data pulled by Colin Narver
 
 */

int[] numbers;

void setup() {
  size(1280, 720);
  background(#FFFFD9);
  smooth();

  loadData("God2.csv");
  drawText();
}

void draw() {
}


void drawText() {
  float x = 0;
  float y = 10;
  int count = 0;
  
  PFont f = loadFont("Courier-24.vlw");
  PFont b = loadFont("Courier-Bold-24.vlw");

  String[] test = loadStrings("matthew.csv");

  for (int i=0; i<test.length; i++) {    
    int index = int(random(test.length));
    text(test[index], x, y);
    x += textWidth(test[index] + 10);
    count++;
    //    println(count);

//    for (int j=0; j<numbers.length; j++) {
//      int n = numbers[j];
//      float boldText = map(i, 0, numbers.length, 0, count);

      if (x < i) {
        fill(255, 0, 0);
        textFont(b, 11);
      }

      else {
        fill(0);
        textFont(f, 11);
      }
//    }
    if (x > width - 20) {
      x = 0;
      y+= 15;
      count = 0;
      //      println(count);
    }
  }
}


void loadData(String filename) {

  String[] rows = loadStrings(filename);
  numbers = new int[rows.length];
  for (int i=0; i<rows.length; i++) numbers[i] = int(rows[i]);
}

