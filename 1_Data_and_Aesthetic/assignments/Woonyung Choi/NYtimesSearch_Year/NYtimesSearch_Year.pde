/*
Data Art 
Assignment #1 : Data / Asthetics

Version 1 : color stripes poster
  - frequency of use of word "internet" - in NYtimes
    from 1970 to 2014

woonyungchoi@gmail.com

*/

import processing.pdf.*;


String apiKey = "key";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

// Parameters 
// search term will be : internet / privacy/ social network/ communciation
String searchTerm = "internet";

// period
int startDate = 1970;
int endDate = 2015;

// color palette
color color1 = #000000; // black
color color2 = #EA481D; // red
color color3 = #136E8F; // blue
color color4 = #8DB823; // green

void setup(){
  size(720, 900);
  smooth(8);
  background(255);
  beginRecord(PDF, "NYtimes-4.pdf");
  
  // This function returns a list of integers, counting a search term per year
  int[] dataCounts = doASearchYears(searchTerm, startDate, endDate);
  
  
  /////////////// bar charts /////////////////
  for ( int i = 0; i < dataCounts.length; i++){
    float x = 0;
    float y = i*height/dataCounts.length;
    float w = width;
    float h = height/dataCounts.length;
    
    float percent = map(dataCounts[i], 0, max(dataCounts), 0,1);
    color between = lerpColor(#FFFFFF, color1, percent);
    
    fill(between);
    noStroke();
    rect( x, y, w, h);
    
    /*
    //////// draw the text//////
    // fill(255,255,0);
    pushMatrix();
    color textType1 = color(255,0,0);
    color textType2 = color(255,255,0);
    if ( c > 220){
      fill(textType1);
    } else {
      fill(textType2);
    }
    
    fill(255,255,0);
    translate(x, y);
    textSize(10);
    text( i + startDate, 650 , 20);
    popMatrix();
    */
    
  }
  
  

  
  //================ writing in csv file =================== //
  // It's often useful to save data like this
  // so we don't hvae to call the API everytime once we're visualizing 
  PrintWriter writer = createWriter("data/dummyData.csv");
  for ( int i:dataCounts)  writer.println(i);
  writer.flush();
  writer.close();
}

void draw(){
  
}

// when you press q key, end record and save pdf file 
void keyPressed(){
  if ( key == 'q'){
    endRecord();
    exit();
  }
}
