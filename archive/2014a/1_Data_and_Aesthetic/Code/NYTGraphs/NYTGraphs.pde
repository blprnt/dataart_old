int[] answers;

void setup() {
  size(1280, 720);
  smooth(8);
  loadData("electricityData.csv");
  //answers = sort(answers);
  println(max(answers));
  //println(answers);
}

void draw() {
  background(255);
  //drawCircles(answers);
  drawRadialGraph(answers);
}

void drawRadialGraph(int[] numbers) {
  for(int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = width/2;
    float y = height/2;
    float w = 5;
    float h = -map(n,0,max(numbers),0,height/2);
    float r = map(i, 0, numbers.length, 0, TAU);
    float c = map(n,0,max(numbers),0,255);
    fill(255,c,0);
    noStroke();
    
    pushMatrix();
    translate(x,y);
    rotate(r);
    rect(0,-50,w,h);
    popMatrix();
  }
}

void drawGraph(int[] numbers) {
  for(int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i,0,numbers.length,100,width - 100);
    float y = height - 100;
    float w = 5;
    float h = -map(n,0,max(numbers),0,height - 100);
    rect(x,y,w,h);
  }
}


void drawCircles(int[] numbers) {
  for(int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i,0,numbers.length,100,width - 100);
    float y = height/2;
    float d = map(sqrt(n),0,sqrt(max(numbers)),0,sqrt(300));
    fill(#ff6600,150);
    noStroke();
    ellipse(x,y,d,d);
  }
}

void loadData(String url) {
  Table data = loadTable(url);
  answers = new int[data.getRowCount()];
  
  for(int i = 0; i < data.getRowCount(); i++) {
    //get the first column of each row and put it in the array
    answers[i] = data.getRow(i).getInt(0);
  }
  
}









