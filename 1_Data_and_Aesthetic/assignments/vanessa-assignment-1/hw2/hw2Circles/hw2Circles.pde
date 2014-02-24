/* 
Solar System - Circles Aligned
vanessajoho@gmail.com  
 2/21/14
 */

int[] earth;
int[] jupiter;
int[] mars;
int[] mercury;
int[] neptune;
int[] saturn;
//int[] solarSystem;
int[] sun;
int[] uranus;
int[] venus;

void setup() {
  size(1000, 360);
  smooth(8);

  noStroke();
  //fill each array with data we want
  earth = loadData("earth.csv");
  jupiter =loadData("jupiter.csv");
  mars = loadData("mars.csv");
  mercury = loadData("mercury.csv");
  neptune = loadData("neptune.csv");
  saturn = loadData("saturn.csv");
  //  solarSystem = loadData("solarSystem.csv");
  sun = loadData("sun.csv");
  uranus = loadData("uranus.csv");
  venus = loadData("venus.csv");
}

void draw() {

  background(0,0,0);

  //draw bands for each disease, this could be done in setup as well
  drawStats(earth, 20);
  drawStats(jupiter, 60);
  drawStats(mars, 100);
  drawStats(mercury, 140);
  drawStats(neptune, 180);
  drawStats(saturn, 220);
//  drawStats(solarSystem, 260);
  drawStats(sun, 260);
  drawStats(uranus, 300);
  drawStats(venus, 340);
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

void drawStats(int[] numbers, float ypos) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 0, width);
    float y = ypos;
    float w = (width)/numbers.length;
    float h1 = map(n, 0, max(numbers), 0, height);

    //map alph to hits
    float a = map(n, 0, max(numbers), 0, 255);
    noStroke();
    //more opaque = more hits

    ellipse(x, y, h1/15, h1/15);

    if (ypos == 20) {
      fill(25,55,90, a);
    }
    else if(ypos == 60){
      fill(170,160,140, a);
    }
    else if(ypos == 100){
      fill(220, 170, 107, a);
    }
   else if(ypos == 140){
      fill(145, a);
    }
    else if(ypos == 180){
      fill(140, 135, 250, a);
    }
   else if(ypos == 220){
      fill(230, 200, 150, a);
    }
    else if(ypos == 260){
      fill(130, 80, 40, a);
    }
    else if(ypos == 300){
      fill(190, 215, 250, a);
    }
    else {
      fill(200, 100, 50, a);
    }
  }
}

