PImage espresso_icon; //icon svg
PImage espresso_txt; //Text svg
int espresso= 25; // hard coded, dollars I've spent on drink this year
int margin = 20;
int imgDim = 40;
int tileDim= imgDim + margin;
int yOffset= 35;
int cols;

void setup() {
  size(1400, 900);
  espresso_icon = loadImage("espresso_icon.png");
  espresso_txt = loadImage("espresso_txt.png");
}

void draw() {
  background(#FC4D22);
  tileCoffee();
  image(espresso_txt, -10, height-200);
}


void tileCoffee() {
  
  int cols = floor((width- margin)/tileDim);

  //Uses the 1D array --> 2D array formula to take index and dynamically determine placement
  // if index = (y*columns)+ x, then y = (index-x/columns), and x = index-( index- x)
  for (int i = 0; i < espresso; i ++) {
    image(espresso_icon, (i - (i - (i % cols)* tileDim) + margin), ((i - (i % cols)) / cols) *tileDim + margin, imgDim, imgDim);
    }
  }


