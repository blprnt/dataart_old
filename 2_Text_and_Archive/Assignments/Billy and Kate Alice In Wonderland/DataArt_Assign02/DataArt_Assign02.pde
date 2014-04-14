IntDict words;
float dp = 0.77;
float d = 0;
float a = 0;
float x = 0;
float y = 0;

PImage img;

//float T;

void setup() {
  size(1280, 720);
  loadWords("count.txt");
  textAlign(CENTER);
  img = loadImage("hole.jpg");
}

void draw() {
//  background(0);
  image(img, 0, 0);
  //  int x = 50;
  //The position of the text now if off-screen, move it first!
  translate(map(mouseX-200, 0, 50, 0, 500), mouseY);
  //c = count; c < 100 means 100 top words
  int c = 0;
  for (String w:words.keys()) {
    if (c < 800) {

      textSize(words.get(w) * 0.5);
      //display the text
      fill(255);
      text(w, 0, 0);
      translate(textWidth(w), 0);

      translate(d * cos(mouseX)/2, d * sin(mouseY)/2);
      rotate(PI);

      //spiral  
      //    pushMatrix();
      //    translate(x,y);
      rotate(map(mouseX, 0, width, 0, 1));
      //   popMatrix();
    }
    c++;
  }
  pushMatrix();
  if (abs(d-0)<0.5) d+=1;
  d+=dp;
  a+=0.5;
  popMatrix();
}

void loadWords(String url) {
  words = new IntDict();
  String[] rows = loadStrings(url);
  for (String row:rows) {
    String[] cols = split(row, ",");
    words.add(cols[0], int(cols[1]));
  }
}


void reset() {
  this.x = width/2;
  this.y = height/2;

//  this.rot = random(0, 2*PI);

  this.a = PI;
//  this.norm = random(0.005, 0.03);
//  this.q = random(minVal, maxVal);
  this.d = 10;

//  cn++;
//  cn%=cs.length;
}

void mousePressed() {
  //reset whole values
  fill(random(200, 255));
  rect(0, 0, width, height);
  reset();
}

