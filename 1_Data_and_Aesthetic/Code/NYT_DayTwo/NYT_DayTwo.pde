/*

 NYTimes Data Exploration
 jer@o-c-r.org
 February 2013
 
 - the CSV war.csv can be replaced with any int list
 
 */

int[] numbers;

String[] colorList = {
  "fffff7f3", 
  "fffde0dd", 
  "fffcc5c0", 
  "fffa9fb5", 
  "fff768a1", 
  "ffdd3497", 
  "ffae017e", 
  "ff7a0177", 
  "ff49006a"
};

color getColor(float f) {
  //f is a number between 0 and 1
  //so let's convert it to an int to pick from the array
  int i = floor(f * (colorList.length - 1));
  color col = unhex(colorList[i]);
  return(col);
}

void setup() {
  size(1280, 720, P3D);
  smooth();
  loadData("warData.csv");
}

void draw() {
  background(0);
  colorMode(HSB);
  drawGrid(numbers, 10, 30);
}

void drawGrid(int[] nums, int cols, float s) {
  for (int i = 0; i < nums.length; i++) {
    //Draw every block in the grid
    int n = nums[i];
    float x = (i % cols) * s;
    float y = floor(i / cols) * s;
    //float c = map(n, 0, max(nums), 0, 255);
    //fill(c);
    //fill(c, 255, 255);
    color col = getColor(map(n,0,max(nums),0,1));
    fill(col);
    rect(x, y, s, s);
  }
}

void loadData(String fileName) {
  String[] rows = loadStrings(fileName);
  numbers = new int[rows.length];
  for (int i = 0; i < rows.length; i++) numbers[i] = int(rows[i]);
}



