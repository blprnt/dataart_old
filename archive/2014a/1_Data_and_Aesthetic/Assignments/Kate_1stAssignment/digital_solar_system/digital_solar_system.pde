int[] answers;
int[] answers2;
int[] answers3;
int[] answers4;
int[] answers5;
int[] answers6;
int[] answers7;
int[] answers8;
int[] answers9;

PImage img;

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  answers = loadData("sun.csv");
  answers2 = loadData("earth.csv");
  answers3 = loadData("mercury.csv");
  answers4 = loadData("mars.csv");
  answers5 = loadData("venus.csv");
  answers6 = loadData("jupiter.csv");
  answers7 = loadData("neptune.csv");
  answers8 = loadData("saturn.csv");
  answers9 = loadData("uranus.csv");

  img = loadImage("tag.jpg");
}

void draw() {
  background(0);
  drawRadioGraph(answers7, 800, 1000, color(80, 195, 199));
  drawRadioGraph(answers9, 750, 900, color(40, 55, 136));
  drawRadioGraph(answers8, 650, 780, color(66, 111, 182));
  drawRadioGraph(answers6, 550, 750, color(100, 187, 84));
  drawRadioGraph(answers4, 500, 600, color(214, 215, 36));
  drawRadioGraph(answers2, 350, 550, color(254, 225, 0));
  drawRadioGraph(answers5, 300, 500, color(215, 129, 64));
  drawRadioGraph(answers3, 200, 400, color(239, 71, 34));
  drawRadioGraph(answers, 130, 280, color(203, 40, 38));
  
  image(img, 0, height-28.35, 1280, 28.35);
}

void drawRadioGraph(int[] numbers, int s, int b, color c) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = width/2;
    float y = height-28.35;
    float w = 4.5;
    float h = -map(n, 0, max(numbers), s, b);
    float r = map(i, 0, numbers.length, 0, PI);
    //    float c = map(n, 0, max(numbers), 0, 255);
    fill(c);
    noStroke();

    pushMatrix();
    translate(x, y);
    rotate(r);
    rotate(-HALF_PI);
    rect(0, 10, w, h, 2, 2, 2, 2);
    popMatrix();
  }
}

//void drawArc(int[] numbers, color c) {
//  for (int i = 0; i < numbers.length; i++) {
//    int n = numbers[i];
//    float ringSize = map(n, 0, max(numbers), 150, 250);
//    float ringDistance = 50;
//    strokeWeight(ringSize);
//    fill(c,100);
//    arc(int(50),int(50),int(100),int(100),PI);
//  }
//}

int[] loadData(String url) {
  Table data = loadTable(url);
  int[] array = new int[data.getRowCount()];

  for (int i = 0; i < data.getRowCount(); i++) {
    //get the second column of each row and put it in the array
    array[i] = data.getRow(i).getInt(0);
  }
  return array;
}

