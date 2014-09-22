/*
Data Art 
Assignment #1 : Data / Asthetics

Version 5 : color stripes poster 
  - frequency of use of words : 
    technology/ internet/ smartphone 
    data / social+network/ communication / privacy
  - landscape format
  - added color indication

woonyungchoi@gmail.com

*/

import processing.pdf.*;

String apiKey = "apikey";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

// design elements
int canvasWidth = 900;
int canvasHeight = 300;
int topMargin =200;
int bottomMargin = 30;
int leftMargin = 45;
int padding = 20; // padding bewteen color chips

// color palette
color color1 = #353147; // dark purple
color color2 = #5E4B78; // purple
color color3 = #395986; // blue
color color4 = #AAD175; // green
color color5 = #607A86; // gray
color color6 = #FDC461; // yellow
color color7 = #E46F7D; // red

// Parameters 
// period
int startDate = 1970;
int endDate = 2015;

// search term will be : internet / privacy/ social network/ communciation
String searchTerm1 = "technology";
String searchTerm2 = "internet";
String searchTerm3 = "smartphone";
String searchTerm4 = "data";
String searchTerm5 = "social+network";
String searchTerm6 = "communication";
String searchTerm7 = "privacy";


void setup(){
  size( canvasWidth + leftMargin * 2, topMargin + canvasHeight + bottomMargin );
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
