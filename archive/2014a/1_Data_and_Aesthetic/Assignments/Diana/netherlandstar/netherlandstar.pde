/*ITP Data Art
Diana F
2/24/14
This sketch is a variation of John Farrells data representation*/

int[] answers;
int maxNumberOfStars = 6;

void setup() {
  println("---");
  size(1280, 720);
  smooth(10);
  loadData("netherlandsData.csv");
  //answers = sort(answers);
  println(max(answers));
  //println(answers);
}

void draw() {
  background(20);
  //drawCircles(answers);
  drawRadialGraph(answers);
}

void drawRadialGraph(int[] numbers) {
  
  //figure out how to arrange all graphs in a square arrangement
 int count = 1;
  float pow = 0;
 while ((pow = pow(count++,2)) < maxNumberOfStars) { }

  int rows = (int)sqrt(pow);
  int columns = (int)sqrt(pow);

  if (maxNumberOfStars <= columns * (rows - 1)) { rows--; }

  //size of 'box'/area/cell each graph will occupy
  int cellWidth = width / columns;
  int cellHeight = height / rows;

  //keep track of which box we're in doing the graph

  int row = rows -1;
  int column = 0;



  for(int starNumber = 0; starNumber < maxNumberOfStars; starNumber++) {
    int multiply= starNumber*2;
    for(int i = 0; i < numbers.length; i++) {
      int n = numbers[i];
      float x = column * cellWidth + (cellWidth / 2);
      float y =  row * cellHeight + (cellHeight / 2);
       
     // float w = 15; 
      float h = -1;
      //float h = -map(n,0,max(numbers),0,height/2);
      float w = -map(n,0,max(numbers),0,(cellWidth/2));
      float r = map(i, 0, numbers.length, -1300, TAU);
      float c = map(n,0,max(numbers),0,800);
     stroke(120,c,400, 50);
     fill(120,c,400, 25);
      strokeWeight(multiply/3);
    //stroke(0);
     // strokeWeight(.5);
      pushMatrix();
      translate(x,y);
      rotate(r*multiply);
      rect(0,0,w*multiply,h*multiply);
      popMatrix();
    }

    if (++column >= columns) {
        column = 0;
        row--;
    }    
  }
}

/*void drawGraph(int[] numbers) {
  for(int i = 0; i < numbers.length; i++) {
    int n = numbers[i];
    float x = map(i,0,numbers.length,100,width -10);
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
    float d = map(sqrt(n),0,sqrt(max(numbers)),0,sqrt(200));
    fill(#ff6600,250);
    noStroke();
    ellipse(x,y,d,d);
  }
}*/

void loadData(String url) {
  Table data = loadTable(url);
  answers = new int[data.getRowCount()];
  
  for(int i = 0; i < data.getRowCount(); i++) {
    //get the first column of each row and put it in the array
    answers[i] = data.getRow(i).getInt(0);
  }
  
}









