/*
NYT Article API Articles Mentioning Cocaine by Year
text/quantity
2/23/14
katieadee@gmail.com

*/
import processing.pdf.*;
int []  totals =  new int[0];
ArrayList <Line> lines = new ArrayList();
JSONObject myJSON;
void setup(){
  //since this needs higher vector resolution, final output is PDF not screen
  size(3000, 1000, PDF, "text.pdf");
  textMode(SHAPE);
  //beginRecord(PDF, "test.pdf"); 
  background(0);
  fill(255);
  stroke(255);
  textSize(5);
  textAlign(CENTER, CENTER);
  
  myJSON = loadJSONObject("cocaineParsed.json");
  JSONArray results = myJSON.getJSONArray("results");
  for (int i = 0; i < results.size(); i++) {
    JSONObject yearObject = results.getJSONObject(i);
    int year =  yearObject.getInt("year");
    int count =  yearObject.getInt("count");
   
    totals = append(totals,count);
    
    float x =  map(year,  1900,2013,  20,width-20);
    float y = height/2;
    Line l = new Line(x,y,count);
    lines.add(l);
    //println(year + " : " + count);
    
    
    // use this part if you want to see text of first article each year
    /*
    JSONArray headlines = yearObject.getJSONArray("titles");
    if (headlines.size() >0){
      String title = headlines.getString(0);
      pushMatrix();
      translate(x,y);
      rotate(-PI/2);    
      text(title, 0,0);    
      popMatrix();
    }//*/
   
         
  }
  
  
}

void draw(){
  //draw each line 
  for (Line l : lines){
   l.display(); 
  }
  // Exit the program 
  println("Finished.");
  exit();
}

void keyPressed() {
  if (key == ' ') {
    endRecord();
    exit();
  }
}


