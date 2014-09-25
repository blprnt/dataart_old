/*
Data Art 
Assignment #1 : Data / Asthetics

Version 5 : color stripes poster 
  - frequency of use of words : 
  - changed the color scheme
  - changed keywords : based on the comments/feedback
    

woonyungchoi@gmail.com

*/

import processing.pdf.*;


String apiKey = "dc4bd4ca77e7e5cce579554df40426ff:16:68849491";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

// period
int startDate = 1970;
int endDate = 2015;

float canvasHeight = 300;
float topMargin = 0;

// color palette
color color1 = #FDBB6E; 
color color2 = #D8737F; 
color color3 = #AB6D82; 
color color4 = #685D78; 
color color5 = #465D7A; 
color color6 = #96D0B5; 
color color7 = #929497; 

// Parameters 
// search term will be : internet / privacy/ social network/ communciation
String searchTerm1 = "human";
String searchTerm2 = "genome";
String searchTerm3 = "ethical";
String searchTerm4 = "stem+cell+research";
String searchTerm5 = "DNA";
String searchTerm6 = "genetics";
String searchTerm7 = "biology";


void setup(){
  size(900, 300);
  smooth(8);
  background(255);
  beginRecord(PDF, "NYtimes-4.pdf");
  
  loadData();

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
