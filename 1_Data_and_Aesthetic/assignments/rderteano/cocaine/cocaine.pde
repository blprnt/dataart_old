/*

 ITP Data Art
 NYTimes Article Search v2 "Cocain" search 

  Data is retrieved and saved to JSON with the retreive_nytimes_articles project
  Then it is processed by a python script inside the data folder of this project (work in progress!)
 
 Rodrigo Derteano
 Feb 10 2014
 
 */
 
JSONObject lines;
int fontSize = 10;
int colWidth = 250;
int rowHeight = 11;
int offsetX = 60;

void setup(){
  size(3100, 6000);
  //smooth(8);
  background(255);
  
  lines = loadJSONObject("data/cocaine_processed.json");
  PFont font = createFont("Monospaced",64,true);
  //println(font.list());
  textFont(font,fontSize);
  background(255);
  fill(0);
  
  draw_cocaine_years2();
}

void draw() {
  saveFrame("output.png");
}


void draw_cocaine_years1() {
  int x = offsetX;
  int y = 20;   
  JSONArray years = lines.getJSONArray("years");
  
  for (int i = 0; i < years.size(); i++) {
    JSONArray year = years.getJSONArray(i);
    for (int j =0 ; j < year.size(); j++)  {
      if (y >= height - rowHeight) {
        y = 20;
        x = x + colWidth;
      }
      String verse = year.getString(j);
      int pos = verse.indexOf("cocaine");
      text(verse, x - (pos * 6), y);
      y = y + rowHeight;
    }
    y = y + rowHeight;
  }  
}


void draw_cocaine_years2() {
  int x = offsetX;
  int y = 20;   
  JSONArray years = lines.getJSONArray("years");
  
  for (int i = 0; i < years.size(); i++) {
    JSONArray year = years.getJSONArray(i);
    for (int j =0 ; j < year.size(); j++)  {
      String verse = year.getString(j);
      int pos = verse.indexOf("cocaine");
      text(verse, x - (pos * 6), y);
      y = y + rowHeight;
    }
    y = y + rowHeight;
    if (i % 10 == 9) {
      y = 20;
      x = x + colWidth;
    }
  }  
}
