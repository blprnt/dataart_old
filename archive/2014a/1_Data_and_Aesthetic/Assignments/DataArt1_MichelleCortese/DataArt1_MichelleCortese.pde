/*
  Celebrity Death Match
  Michelle Cortese
  Monday, February 10th, 2014
  ------------
  Notes
  Compares social discussion arc of various musicians, 5 years after death.
*/

String apiKey = "YOUR API HERE";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";
PFont neutraFace;
PFont neutraFaceReg;

void setup() {
  size(1280,720,P2D);
  smooth(8);
  background(230,225,220);
  neutraFace = loadFont("Neutraface2Display-Thin-56.vlw");
  neutraFaceReg = loadFont("Neutraface2Text-Light-24.vlw");
  graphText();
  //graph
  getLife("Jimi Hendrix",1970,1975,
    200,60,150,255);
  getLife("Elvis Presley",1977,1982,
    255,128,0,255);
  getLife("Buddy Rich",1987,1992,
    150,50,250,210);
  getLife("Amy Winehouse",2011,2014,
    0,150,150,255);
  //custm index
  drawIndex("Jimi Hendrix",575,200,60,150,255);
  drawIndex("Elvis Presley",605,255,128,0,255);
  drawIndex("Buddy Rich",635,150,50,250,210);
  drawIndex("Amy Winehouse",665,0,150,150,255);
}

void draw() { 
}

void graphText(){
  textFont(neutraFace, 42);
  fill(10);
  text("CELEBRITY DEATH MATCH",100,600);
  textFont(neutraFaceReg,24);
  fill(60);
  text("Comparing social discussion arc of various musicians, 5 years after death.",100,640);
}

void drawIndex(String person, int locY, int hueR,int hueG,int hueB, int alpha){
  String term = person;
  int hueRTemp = hueR;
  int hueGTemp = hueG;
  int hueBTemp = hueB;
  int alphaTemp = alpha;
  int loc = locY;
  textFont(neutraFaceReg,18);
  fill(80);
  text(term,1050,loc);
  fill(hueRTemp,hueGTemp,hueBTemp,alpha);
  ellipse(1030,loc-5,15,15);
  
}

void getLife(String searchTerm,int dateOfBirth,int dateOfDeath,int hueR,int hueG,int hueB, int alpha){
  String termTemp = searchTerm;
  int birthTemp = dateOfBirth;
  int deathTemp = dateOfDeath;
  int hueRTemp = hueR;
  int hueGTemp = hueG;
  int hueBTemp = hueB;
  int alphaTemp = alpha;
  int[] popGraph = doASearchYears(termTemp, birthTemp, deathTemp);
  for (int i = 0; i < popGraph.length; i++) {
     noStroke();    
     fill(hueRTemp,hueGTemp,hueBTemp,alpha);
     float x = map(i,0,popGraph.length,50, width-50); //start
     float w = width/popGraph.length; //end
     float h = map(popGraph[i], 0, max(popGraph), 0, 500);
     makeWave(x,x+w,0.1,hueRTemp,hueGTemp,hueBTemp,h,50);
     println(h);
   }
}

void makeWave(float startPlace, float endPlace, float veloWave, int color1, int color2, int color3, float amountH,  float amountNegH){
 float angle = startPlace;
 float endTemp = endPlace; //width divided by years
 float heightTemp = amountH;
 float heightNegTemp = amountNegH;
 //loop, set promixity, style, generate
 for (int x = 0; x <= endTemp; x+= 2){ //horizontal range {
    float y = map(sin(angle),-1,1,heightNegTemp,heightTemp); //vertical range
    fill(color1,color2,color3,15);
    ellipse(x,y,12,12);
    angle += veloWave;
 }
}
