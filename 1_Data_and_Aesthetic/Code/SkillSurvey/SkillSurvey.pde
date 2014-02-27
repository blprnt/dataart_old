int[] answers;

void setup() {
  size(1280, 720);
  smooth(8);
  loadData();
  answers = sort(answers);
  println(answers);
}

void draw() {
  background(255);
  drawLineGraph(answers);
}

void drawGraph(int[] numbers) {
  for(int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i,0,numbers.length,100,width - 100);
    float y = height - 100;
    float w = 5;
    float h = -map(n,0,10,0,height - 100);
    rect(x,y,w,h);
  }
}

void drawLineGraph(int[] numbers) {
  beginShape();
  for(int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i,0,numbers.length,100,width - 100);
    float y = height - 100;
    float w = 5;
    float h = -map(n,0,10,0,height - 100);
    curveVertex(x,y + h);
    //rect(x,y,w,h);
  }
  endShape();
}


void drawCircles(int[] numbers) {
  for(int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i,0,numbers.length,100,width - 100);
    float y = height/2;
    float d = map(n,0,sqrt(10),0,sqrt(300));
    fill(#ff6600,150);
    noStroke();
    ellipse(x,y,d,d);
  }
}

void loadData() {
  Table data = loadTable("answers.csv", "header");
  answers = new int[data.getRowCount()];
  
  for(int i = 0; i < data.getRowCount(); i++) {
    //get the second column of each row and put it in the array
    answers[i] = data.getRow(i).getInt(1);
  }
  
}









