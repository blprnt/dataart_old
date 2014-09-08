/*
 ITP Data Art 2014
 NYTimes Article Search v2 Simple Example
 
 **Note - you must put your API key in the first field for this to work!
 
 Rafael Gross-Brown
 rafagrossbrown@gmail.com 
 Article Search v2 docs: http://developer.nytimes.com/docs/read/article_search_api_v2 
 
 */

String apiKey = "Your API key here";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";
String keyQuery = "sex";
int[] answers;
//monkeys are sexy?
int[] monkeyCounts;
PFont f;

void setup() {
  size(1280, 720,P3D);
  smooth(4);
 // background(0);
 background(255,0,128);

  //This function returns a list of integers, counting a search term per year
  
  loadData("sexData_longer.csv"); 
 
 

  int[] monkeyCounts = answers;
 
  drawText();
}

void drawText() {

 

  for (int i=0; i<answers.length; i++) {
    //text size var mapping to max size 100
    float   size= map(answers[i], 240, 7304, 8, 99);
    //println(max(answers));
    size= round(size);
    //println(size);
    //set up grid to draw text "sex"
    int col= i%14;
    int row= i/14;
    float x= map(col, 0, 14, 40, width);
    float y= map(row, 0, 8, 0, height);
    
    //choose font style/type
    f = loadFont("Helvetica-Light-48.vlw");
    textFont(f);
    textAlign(CENTER,BASELINE);
  fill(0);
//    fill(255,0,128);
    textSize(size);
    text("sex", x, y );
 
  }
 textSize(16);
  text("\"sex\" in the New York Times, 1901-2012.", width/2, height-20);
}

void loadData(String fileName) {
  Table data = loadTable(fileName);
  answers = new int[data.getRowCount()];

  for (int i = 0; i < data.getRowCount(); i++) {
 
    answers[i] = data.getRow(i).getInt(0);
  }
 
  }


  void draw() {
  }

