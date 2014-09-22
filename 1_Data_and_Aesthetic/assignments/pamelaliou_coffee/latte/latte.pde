PImage latte_icon; //icon svg
PImage latte_txt; //Text svg
int latte= 36; // hard coded, dollars I've spent on drink this year
int margin = 20;
int imgDim = 40;
int tileDim= imgDim + margin;
int yOffset= 35;
int cols;

void setup() {
  size(1400, 900);
  latte_icon = loadImage("latte_icon.png");
  latte_txt = loadImage("latte_txt.png");
}

void draw() {
  background(#FC4D22);
  tileCoffee();
  image(latte_txt, -10, height-200);
}


void tileCoffee() {
  
  int cols = floor((width- margin)/tileDim);

  //Uses the 1D array --> 2D array formula to take index and dynamically determine placement
  // if index = (y*columns)+ x, then y = (index-x/columns), and x = index-( index- x)
  for (int i = 0; i < latte; i ++) {
    image(latte_icon, (i - (i - (i % cols)* tileDim) + margin), ((i - (i % cols)) / cols) *tileDim + margin, imgDim, imgDim);
    }
  }


