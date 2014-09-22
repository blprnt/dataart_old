PImage cortado_icon; //icon svg
PImage cortado_txt; //Text svg
int cortado= 341; // hard coded, dollars I've spent on cortados this year
int margin = 20;
int imgDim = 30;
int tileDim= imgDim + margin;
int yOffset= 35;
int cols;

void setup() {
  size(1400, 900);
  cortado_icon = loadImage("cortadoicon.png");
  cortado_txt = loadImage("cortado_txt.png");
}

void draw() {
  background(#FC4D22);
  tileCoffee();
  image(cortado_txt, -30, height-200);
}


void tileCoffee() {
  
  int cols = floor((width- margin)/tileDim);

  //Uses the 1D array --> 2D array formula to take index and dynamically determine placement
  // if index = (y*columns)+ x, then y = (index-x/columns), and x = index-( index- x)
  for (int i = 0; i < cortado; i ++) {
    image(cortado_icon, (i - (i - (i % cols)* tileDim) + margin), ((i - (i % cols)) / cols) *tileDim + margin, imgDim, imgDim);
    }
  }


