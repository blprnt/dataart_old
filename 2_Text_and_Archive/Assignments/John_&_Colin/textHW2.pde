/****
John Farrell & Colin Naver
Data Art - Text & Archive Concept Project
9/11 Pager Data Visualization Installation
March 10, 2014
*****/


import geomerative.*;

RShape shp;
RShape polyshp;
float w = width/2;
float h = height/2;
float a = 0;

void setup() {
  size(1280, 720);
  smooth();

  // VERY IMPORTANT: Allways initialize the library before using it
  RG.init(this);

  shp = RG.loadShape("messages.svg");
  shp = RG.centerIn(shp, g, h);
}

void draw() {
  background(255);

  // We decided the separation between the polygon points dependent of the mouseX

  float pointSeparation = map(constrain(mouseX, 100, width-100), 100, width-100, 5, 200);
  //float pointSeparation = w;

  println(pointSeparation);
  // We create the polygonized version
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pointSeparation);

  polyshp = RG.polygonize(shp);

  // We move ourselves to the mouse position
  //translate(mouseX+200, mouseY);
  translate(width/2, h);
  h++;
  if (h >= height + 350) {
    h = -300;
  }
  // We draw the polygonized group with the SVG styles
  RG.shape(polyshp);
}

