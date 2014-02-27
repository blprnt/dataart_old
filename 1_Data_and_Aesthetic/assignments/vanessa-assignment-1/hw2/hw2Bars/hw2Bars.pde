/* 
 Communism vs Terrorism - Bars
 vanessajoho@gmail.com  
 2/20/14
 */
import processing.pdf.*;
boolean record;

//cound have done this in a 2D array but needed to test a few things
int[] communism;
int[] terrorism;

void setup() {
  //used this line to save a quick static pdf after 
  size(1000, 500);
  smooth(8);

  noStroke();
  //fill each array with data we want
  communism = loadData("communism.csv");
  terrorism =loadData("terrorism.csv");
  
  }

void draw() {
  if (record) {
    // record frame as a pdf for editing inillustrator
    beginRecord(PDF, "communismTerrorims.pdf");
  }

  background(26, 29, 48);

  //draw bands for each disease, this could be done in setup as well
  drawStats(communism, height/2);
  drawStats(terrorism, height/2+1);

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

void drawStats(int[] numbers, float ypos) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 0, width);
    float y = ypos;
    float w = (width/2)/numbers.length;
    float h1 = -map(n, 0, max(numbers), 0, height);
    float h2 = map(n, 0, max(numbers), 0, height);

    //map alph to hits
    float a = map(n, 0, max(numbers), 0, 255);
    noStroke();
    //more opaque = more hits
    if (ypos == height/2) {
      fill(100, 150, 200, a);
      rect(x, y, w, h1/2);
    }
    else{
      fill(100, 40, 40, a);
      rect(x, y, w, h2/2);
      rect(x, y, w, h2/2);
    }
  }
}

