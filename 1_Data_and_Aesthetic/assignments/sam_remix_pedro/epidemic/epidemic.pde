// move the mouse to change the size of the ellipses and the spacing of the grid
// mousewheel to change the speed of the animation

DataLoader myData;
int index = 0, nextIndex = 1;
float interval = 50.0;


void setup() {
  myData = new DataLoader("epidemic_1815_2015.csv");
  colorMode(HSB);
  ellipseMode(CENTER);
  size(800, 800);
}

void draw() {
  background(250);

  int divider = (int)map(mouseY, 0, width, 10, 300);
  int grid = width / divider;
  int center = width / 2;

  float threshold = map(myData.getValue(index), myData.getMin(), myData.getMax(), 0, center);
  float nextThreshold =  map(myData.getValue(nextIndex), myData.getMin(), myData.getMax(), 0, center);
  float currentThreshold =  lerp(threshold, nextThreshold, (frameCount % interval) / interval);
  if (frameCount % interval == 0) currentThreshold = nextThreshold;

  float r = grid * map(mouseX, 0, width, .5, 10);

  for (int x = grid/2; x < width; x += grid) {
    for (int y = grid/2; y < height; y += grid) {
      noStroke();
      float d = dist(x, y, center, center);
      if (d < currentThreshold) {
        fill(map(d, 0, center, 255, 50), 255, 255);
        ellipse(x, y, r, r);
      }
    }
  }
  
  
  int year = 1851 + index;
  fill(255, 255, 255);
  textAlign(CENTER);
  text(year, width/2, height - 20);


  if (frameCount % interval == 0) {
    index ++;
    if (index >= myData.getSize()) {
      index = 0;
    }
    
    nextIndex ++;
    if (nextIndex >= myData.getSize()) nextIndex = 0;
  }
}


void mouseWheel(MouseEvent e) {
 interval += e.getAmount();
 interval = constrain(interval, 10.0, 500.0);
 println(interval);
}
