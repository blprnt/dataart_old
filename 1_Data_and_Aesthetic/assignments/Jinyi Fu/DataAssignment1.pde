/*

 Data art Assignment 1: Working with the NYTimes API, create a visualizaiton of how many times the main characters were mentioned since 1989;
 
 */

String apiKey = "f359c6078d29973b5763b95dd0319d5d:11:69839108";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";
int beginYear = 1989;
int currentYear = 2015;
int[] years = {1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014};
int[] homerCounts = doASearchYears("Homer Simpson", beginYear, currentYear);
int[] margeCounts = doASearchYears("Marge Simpson", beginYear, currentYear);
int[] bartCounts = doASearchYears("Bart Simpson", beginYear, currentYear);
int[] lisaCounts = doASearchYears("Lisa Simpson", beginYear, currentYear);
int[] maggieCounts = doASearchYears("Maggie Simpson", beginYear, currentYear);
drawHomer homerSimpson;
drawMarge margeSimpson;
drawBart bartSimpson;
drawLisa lisaSimpson;
drawMaggie maggieSimpson;
float h = 8, h1 = 320, w = 20.8;
drawAll all;

characterImg characters;
PImage characterSet, characterSetL;
boolean clicked;

String s = "Pixelated Simpsons visualization";
drawText titleText;

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  background(250, 245, 225);
  characterSet = loadImage("simpsons.png");
  characterSetL = loadImage("simpsonsL.png");
   
  //create new objects for the visualization 
  homerSimpson = new drawHomer(110, 30);
  margeSimpson = new drawMarge(250, 30);
  bartSimpson = new drawBart(390, 30);
  lisaSimpson = new drawLisa(530, 30);
  maggieSimpson = new drawMaggie(670, 30);
  titleText = new drawText();
  all = new drawAll();
  characters = new characterImg();

  //Export the data into csv files
  PrintWriter homerWriter = createWriter("data/HomerData.csv");
  for (int i:homerCounts) homerWriter.println(i);
  homerWriter.flush();
  homerWriter.close();

  PrintWriter margeWriter = createWriter("data/MargeData.csv");
  for (int i:margeCounts) margeWriter.println(i);
  margeWriter.flush();
  margeWriter.close();

  PrintWriter bartWriter = createWriter("data/BartData.csv");
  for (int i:bartCounts) bartWriter.println(i);
  bartWriter.flush();
  bartWriter.close();

  PrintWriter lisaWriter = createWriter("data/LisaData.csv");
  for (int i:lisaCounts) lisaWriter.println(i);
  lisaWriter.flush();
  lisaWriter.close();

  PrintWriter maggieWriter = createWriter("data/MaggieData.csv");
  for (int i:maggieCounts) maggieWriter.println(i);
  maggieWriter.flush();
  maggieWriter.close();

}

void draw() {
  
  homerSimpson.display();
  margeSimpson.display();
  bartSimpson.display();
  lisaSimpson.display();
  maggieSimpson.display();
  
  titleText.display();
  all.display();
  characters.display();
  characters.mousePressed();
  
  //Text shows the data of years and the detail information, leave for further improvement
//  stroke(126);
//  line(10, height-30, width-250, height-30);
//  for(int i = 0; i<years.length; i++){
//  textSize(10);
//  fill(0);
//  text(years[i], 20+i*5, height-20, 20, 10);
//  }
}

//Create classes to draw pixelated characters using the data obtained
class drawHomer {
  float y_, w_;
  drawHomer(float y, float w) {
    y_ = y;
    w_ = w;
  }
  void display() {
    for (int i = 0; i < homerCounts.length; i++) {
      float x = map(i, 0, homerCounts.length, -30, width-250);
      float h = -map(homerCounts[i], 0, max(homerCounts), 0, homerCounts[i]*2);
      noStroke();
      rect(x, y_, w_, (0.333)*h);
      fill(232, 222, 222);
      rect(x, y_+((0.333)*h), w_, (0.333)*h);
      fill(250, 194, 82);
      rect(x, y_+((0.666)*h), w_, (0.333)*h);
      fill(59, 112, 156);
    }
  }
}

class drawMarge {
  float y_, w_;
  drawMarge(float y, float w) {
    y_ = y;
    w_ = w;
  }
  void display() {
    for (int i = 0; i < margeCounts.length; i++) {
      float x = map(i, 0, margeCounts.length, -30, width-250);
      float h = -map(margeCounts[i], 0, max(margeCounts), 0, margeCounts[i]*2.5);
      noStroke();
      rect(x, y_, w_, (0.333)*h);
      fill(250, 194, 82);
      rect(x, y_+((0.333)*h), w_, (0.333)*h);
      fill(7, 79, 153);
      rect(x, y_+((0.666)*h), w_, (0.333)*h);
      fill(176, 186, 97);
    }
  }
}

class drawBart {
  float y_, w_;
  drawBart(float y, float w) {
    y_ = y;
    w_ = w;
  }
  void display() {
    for (int i = 0; i < bartCounts.length; i++) {
      float x = map(i, 0, bartCounts.length, -30, width-250);
      float h = -map(bartCounts[i], 0, max(bartCounts), 0, bartCounts[i]*2.5);
      noStroke();
      rect(x, y_, w_, (0.333)*h);
      fill(184, 46, 38);
      rect(x, y_+((0.333)*h), w_, (0.333)*h);
      fill(250, 194, 82);
      rect(x, y_+((0.666)*h), w_, (0.333)*h);
      fill(56, 107, 148);
    }
  }
}

class drawLisa {
  float y_, w_;
  drawLisa(float y, float w) {
    y_ = y;
    w_ = w;
  }
  void display() {
    for (int i = 0; i < lisaCounts.length; i++) {
      float x = map(i, 0, lisaCounts.length, -30, width-250);
      float h = -map(lisaCounts[i], 0, max(lisaCounts), 0, lisaCounts[i]*2.5);
      noStroke();
      rect(x, y_, w_, (0.666)*h);
      fill(250, 194, 82);
      rect(x, y_+((0.666)*h), w_, (0.333)*h);
      fill(212, 92, 51);
    }
  }
}

class drawMaggie {
  float y_, w_;
  drawMaggie(float y, float w) {
    y_ = y;
    w_ = w;
  }
  void display() {
    for (int i = 0; i < maggieCounts.length; i++) {
      float x = map(i, 0, maggieCounts.length, -30, width-250);
      float h = -map(maggieCounts[i], 0, max(maggieCounts), 0, maggieCounts[i]*2.5);
      noStroke();
      rect(x, y_, w_, (0.666)*h);
      fill(250, 194, 82);
      rect(x, y_+((0.666)*h), w_, (0.333)*h);
      fill(105, 145, 191);
    }
  }
}

//Text on the right side as the Title
class drawText{
void display(){
  textSize(30);
  fill(0, 102, 153, 204);
  text(s, width-200, 120, 200, 200);
}
}

//Normal pixelated Simpsons family as a reference
class drawAll{
void display(){
      //Homer
      noStroke();
      fill(250, 194, 82);
      rect(width-190, h1, w, 2*h);
      fill(232, 222, 222);
      rect(width-190, h1+(2*h), w, 2*h);
      fill(59, 112, 156);
      rect(width-190, h1+(4*h), w, 2*h);
      
      //Marge
      fill(7, 79, 153);
      rect(width-160, h1-4*h, w, 4*h);
      fill(250, 194, 82);
      rect(width-160, h1, w, 2*h);
      fill(176, 186, 97);
      rect(width-160, h1+(2*h), w, 4*h);
      
      //Bart
      fill(250, 194, 82);
      rect(width-130, h1+(2*h)+(4/3)*h, w, (4/3)*h);
      fill(184, 46, 38);
      rect(width-130, h1+((10/3)*h)+(4/3)*h, w, (4/3)*h);
      fill(56, 107, 148);
      rect(width-130, h1+((14/3)*h)+(4/3)*h, w, (4/3)*h);
      
      //Lisa
      fill(250, 194, 82);
      rect(width-100, h1+((2)*h)+(4/3)*h, w, (4/3)*h);
      fill(212, 92, 51);
      rect(width-100, h1+((10/3)*h)+(4/3)*h, w, (4/3)*h);
      rect(width-100, h1+((14/3)*h)+(4/3)*h, w, (4/3)*h);
      
      //Maggie
      fill(250, 194, 82);
      rect(width-70, h1+((4)*h), w, h);
      fill(105, 145, 191);
      rect(width-70, h1+(5*h), w, h);
      
}
}

//Normal Simpsons family as a reference
class characterImg{

  void display(){  
      image(characterSet, width-220, h1+(10*h), characterSet.width, characterSet.height);
  }
  
  //leave for further improvement
  void mousePressed(){
  }
}
