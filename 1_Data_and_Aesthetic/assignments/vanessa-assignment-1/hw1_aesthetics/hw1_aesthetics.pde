String apiKey = "DE0DBB5735A38A1F720D0B5AFEA9799F:13:58890198";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

int[] answers;

void setup() {
  size(1280, 720);
  smooth(8);
  stroke(0);

  loadData("electricityData.csv");
  loadData("electricityData.csv");
  //answers = sort(answers);
  //println(max(answers));
  //println(answers);
  
  //This function returns a list of integers, counting a search term per year
  int[] numbers = doASearchYears("John Lennon", 1960, 1970);

//Which we can draw a bar chart from:
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 0, width/2);
    float y = height;
    float w = 3;
    float h = -map(n, 0, max(numbers), 0, height - 100);
    float c = map(n, 0, max(numbers), 0, 255);
    fill(c, c, 205, 130);
    rect(x, y, w, h);
  }
}

void draw() {
  background(#61B7CF);
  //drawCircles(answers);
  drawRadialGraph(answers);
  drawGraph(answers);
  drawGraph2(answers);
  drawGraph3(answers);
  drawGraph4(answers);
}



void drawGraph(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 0, width/2);
    float y = height;
    float w = 3;
    float h = -map(n, 0, max(numbers), 0, height - 100);
    float c = map(n, 0, max(numbers), 0, 255);
    fill(c, c, 205, 130);
    rect(x, y, w, h);
  }
}

void drawGraph2(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, width/2, width);
    float y = height;
    float w = 3;
    float h = -map(n, 0, max(numbers), 0, height - 100);
    float c = map(n, 0, max(numbers), 0, 255);
    fill(205, c, c, 130);
    rect(x, y, w, h);
  }
}

void drawGraph3(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 0, width/2);
    float y = 0;
    float w = 3;
    float h = map(n, 0, max(numbers), 0, height - 100);
    float c = map(n, 0, max(numbers), 0, 255);
    fill(c, 150, c, 130);
    rect(x, y, w, h);
  }
}

void drawGraph4(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, width/2, width);
    float y = 0;
    float w = 3;
    float h = map(n, 0, max(numbers), 0, height - 100);
    float c = map(n, 0, max(numbers), 0, 255);
    fill(165, c, 100, 130);
    rect(x, y, w, h);
  }
}

void drawCircles(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i, 0, numbers.length, 100, width - 100);
    float y = height/2;
    float d = map(sqrt(n), 0, sqrt(max(numbers)), 0, sqrt(300));
    fill(#ff6600, 150);
    noStroke();
    ellipse(x, y, d, d);
  }
}

void drawRadialGraph(int[] numbers) {
  for (int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = width/2;
    float y = height/2;
    float w = 5;
    float h = -map(n, 0, max(numbers), 0, 2*height);
    float r = map(i, 0, numbers.length, 0, TAU);
    float c = map(n, 0, max(numbers), 0, 255);
    fill(255, c, 0);
    noStroke();

    pushMatrix();
    translate(x, y);
    rotate(r);
    ellipse(0, -50, w, h);
    popMatrix();
  }
}

void loadData(String url) {
  Table data = loadTable(url);
  answers = new int[data.getRowCount()];

  for (int i = 0; i < data.getRowCount(); i++) {
    //get the first column of each row and put it in the array
    answers[i] = data.getRow(i).getInt(0);
  }
}








