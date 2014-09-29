//initialize the two arrays for data here so that they are available for use anywhere
int[] countLudd;
int[] countTech;

void setup() {
  size(680, 830);
  loadData();
}

void draw() {
  background(255);
  translate(40, -10);
  renderLines(countLudd, countTech);
}

void loadData() {
  //load the luddite csv
  Table myLudd = loadTable("ludditeData_50.csv");
  countLudd = new int[myLudd.getRowCount()];

  //load the technocrat csv
  Table myTech = loadTable("technocratData_50.csv");
  countTech = new int[myTech.getRowCount()];


  //turn the luddite data into an array for easy use
  for (int i = 0; i < myLudd.getRowCount (); i++) {
    println(myLudd.getRow(i).getInt(0)); //could use getString for that type
    countLudd[i] = myLudd.getRow(i).getInt(0);
  }

  //turn the technocrat data into an array for easy use
  for (int i = 0; i < myTech.getRowCount (); i++) {
    println(myTech.getRow(i).getInt(0)); //could use getString for that type
    countTech[i] = myTech.getRow(i).getInt(0);
  }
}

void renderLines(int[] numA, int[] numB) {

  for (int i = 0; i < numA.length; i++) {
    //adjust the padding vertically and horizontally
    int spaceV = 150;
    int spaceH = 60;

    //calculate the values for horizontal luddite lines
    //the offset for x1Ludd brings the first coordinate to the center of 'space' then subtracts half the array value
    float x1Ludd = ((i % 10) * (spaceH)) + ((spaceH / 2) - (numA[i] / 2));
    float x2Ludd = (x1Ludd + numA[i]);
    float y1Ludd = (floor(i / 10) * (spaceV)) + (spaceV / 2);

    //calculate the values for vertical technocrat lines
    float x1Tech = ((i % 10) * (spaceH)) + (spaceH / 2);
    //the offset for y1Tech brings the first coordinate to the center of 'space' then subtracts half the array value
    float y1Tech = (floor(i/10) * (spaceV)) + ((spaceV / 2) - (numB[i] / 2));
    float y2Tech = (y1Tech + numB[i]);

    
    //draw the red luddite line
    strokeWeight(3);
    stroke(255, 0, 0);
    line(x1Ludd, y1Ludd, x2Ludd, y1Ludd);
    //draw the blue technocrat line
    stroke(0, 0, 255);
    line(x1Tech, y1Tech, x1Tech, y2Tech);
    
    //circles to help me embroider
//    noStroke();
//    fill(0);
//    ellipse(((i % 10) * (spaceH)) + (spaceH / 2), (floor(i / 10) * (spaceV)) + (spaceV / 2), 20, 20);
    
  }
}

