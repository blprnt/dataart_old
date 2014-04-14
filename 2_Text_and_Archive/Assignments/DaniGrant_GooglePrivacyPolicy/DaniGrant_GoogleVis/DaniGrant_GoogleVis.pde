/*
 * Dani Grant
 * Google Privacy Policy Vis
 * danigrant@nyu.edu
 *
 * naming of txt files by year of privacy policy
 * 0 = 1999
 * 1 = 2001
 * 2 = 2004
 * 3 = 2008
 * 4 = 2009
 * 5 = 2010
 * 6 = 2011
 * 7 = 2012
 * 8 = 2013
 *
 */

ArrayList<WordObject>[] docs; //in here, store 9 arraylists, each with all the word objects
//wordobjects is data structure to hold the word, count, and strength of connection to the word "information"

//manually enter in the "information" count in this array:
int[] infoCount = {13, 17, 37, 51, 54, 39, 40, 77, 77};

void setup() {
  //format canvas and style
  size(1280, 720);
  background(255);
  noStroke();
  smooth(4);


  //init the docs
  docs = new ArrayList[9];
  for (int i = 0; i < docs.length; i++) {
    docs[i] = new ArrayList<WordObject>();
  }

  //create the WordObjects and fill in the ArrayLists in doc[]
  createWordObjects();

  //draw the circles for each year of privacy policy
  for (int i = 0; i < docs.length; i++) {
    drawCircles(docs[i], i);
  }
  
  drawInfoCount();
  
}

void draw() {
  //in mouseover, should iterate through everything based on which quadrant of screen on?
  if (mouseX < 1280 % 9 && mouseX > 0) {
    mouseOver(docs[0]);
  } 
  else if (mouseX < 1280 % 18 && mouseX > 1280 % 9) {
    mouseOver(docs[1]);
  } 
  else if (mouseX < 1280 % 27 && mouseX > 1280 % 18) {
    mouseOver(docs[2]);
  } 
  else if (mouseX < 1280 % 36 && mouseX > 1280 % 27) {
    mouseOver(docs[3]);
  } 
  else if (mouseX < 1280 % 45 && mouseX > 1280 % 36) {
    mouseOver(docs[4]);
  } 
  else if (mouseX < 1280 % 54 && mouseX > 1280 % 45) {
    mouseOver(docs[5]);
  } 
  else if (mouseX < 1280 % 63 && mouseX > 1280 % 54) {
    mouseOver(docs[6]);
  } 
  else if (mouseX < 1280 % 72 && mouseX > 1280 % 63) {
    mouseOver(docs[7]);
  } 
  else if (mouseX < 1280 % 81 && mouseX > 1280 % 72) {
    mouseOver(docs[8]);
  }
}

void createWordObjects() {
  //need to do this once per year. 9 years. 9 slots in docs[]
  for (int i = 0; i < docs.length; i++) {
    //load up the strings and parse the info and create the word objects out of them
    String[] thecounts = loadStrings(i + "wordcount.txt");
    String[] theconn = loadStrings(i + "wordnetworkstrength.txt"); //these two files are the same length
    for (int j = 0; j < thecounts.length; j++) {
      String[] tempWordCount = thecounts[j].split(",");
      String[] tempConnCount = theconn[j].split(",");
      WordObject wo = new WordObject(tempWordCount[0], Integer.parseInt(tempWordCount[1].trim()), Integer.parseInt(tempConnCount[1].trim()));
      docs[i].add(wo);
    }
  }
}

void drawCircles(ArrayList<WordObject> wos, int row) {
  //loop through the entire arraylist
  for (int i = 0; i < wos.size(); i++) {
    WordObject wo = wos.get(i);
    fill(calculateFill(wo, row));
    wo.xPos = random(-55, 55) + 128 * row + 110;
    ellipse(wo.xPos, calculateY(wo), calculateSize(wo), calculateSize(wo));
  }
}

color calculateFill(WordObject wo, int row) {
  float o = map(wo.conn_info, 1, 50, 90, 160);
  color[] colors = {
    color(51, 105, 232, o), 
    color(213, 15, 37, o), 
    color(238, 178, 17, o), 
    color(0, 153, 57, o)
  };
  //return colors[abs(row % 4)];
  return colors[int(random(4))];
}

float calculateY(WordObject wo) {
  //y is calculated based on network connection to the word information, which is centered at height/2
  int direction;
  int rand = int(random(2));
  if (rand == 0) {
    direction = -1;
  } 
  else {
    direction = 1;
  }  
  float tempY = height/2 + (direction * pow(wo.conn_info, 1.69));
  wo.yPos = tempY;
  return tempY;
}

float calculateSize(WordObject wo) {
  return pow(wo.count, 1.16);
}

void drawInfoCount() {
  for (int i = 0; i < infoCount.length; i++) {
    fill(0, 8);
    ellipse(128 * i + 110, height/2, 2, pow(infoCount[i], 1.5));
  }
}

void mouseOver(ArrayList<WordObject> wos) {
  //iterate through wos and see which object mouse is on
  for (int i = 0; i < wos.size(); i++) {
    WordObject wo = wos.get(i);
    println("dist(mouseX, mouseY, wo.xPos, wo.yPos is " + dist(mouseX, mouseY, wo.xPos, wo.yPos));
    if (dist(mouseX, mouseY, wo.xPos, wo.yPos) < 800) {
      //println("got here!");
      //text(wo.word, wo.xPos, wo.yPos + 30);
    }
  }
}
