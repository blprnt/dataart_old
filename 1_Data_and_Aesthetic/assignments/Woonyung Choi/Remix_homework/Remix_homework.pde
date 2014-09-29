
// solved one
// draw salad - frequency pie graphs

import processing.pdf.*;

//===========color list ==============//
color redColor = color(251, 143, 131);
color orangeColor = color(253, 209, 135);
color yellowColor = color(254, 243, 129);
color yellowGreenColor = color(171, 251, 133);
color GreenColor = color(99, 232, 145);
color brownColor = color(225, 201, 157);
color darkBrownColor = color(181, 168, 141);

color[] colorArray = { 
  redColor, brownColor, yellowGreenColor, yellowColor, orangeColor, GreenColor, darkBrownColor
};
//color[] colorArray =  { color(254, 237, 104), color(208, 212, 216)};


//====== variables for pie graphs ===============//
float startAngle = 0;
float actualAngles = 0;
float endAngle = 0;
//float total = 0; // total sum of dataset
float num = 0;



// dummy dataset
// int[] counts;
Table data;


void setup() {
  size(800, 1400);
  //beginRecord(PDF, "Salad_Data.pdf");
  background(255, 255, 248);
  smooth();
  noStroke();
  noLoop();
 
  beginRecord(PDF, "filename.pdf"); 
  
  // load table
  //loadData();
  data = loadTable("saladData.csv");
  float x = 100;
  float y = 100;
  for (TableRow row : data.rows()) { // load table and loop through each rows
    drawPieChart(row, x, y); // everytime you draw the pie chart
    
    x = x + 150; // give me a padding
    // if x is greater than 700
    if (x > 700) {
        x = 100;
        y = y +150;  // increment y
    }
  }
  
  
}


void drawPieChart(TableRow data, float x, float y) { // passing the table data(array), graphs' x/y position
  // get total sum of dataset
  float total = 0;
  for ( int i = 0; i < data.getColumnCount(); i++) {
    total += data.getFloat(i);
  }
  
  num = 360.0/total;

  // looping through all dataset
  float startAngle = -90;
  float actualAngles = 0;
  float endAngle = -90;
  for (int i = 0; i < data.getColumnCount(); i++) { 
    startAngle = endAngle; // when next data set is loaded start from last's angle
    actualAngles = data.getFloat(i) * num; // calculate actual angles
    //println("actual angles: " + actualAngles);
    endAngle += actualAngles; 
    //println("end angle: " + endAngle);

    /*
    // pie graphs
    fill(colorArray[i]);
    arc(x, y, 80, 80, radians(startAngle), radians(endAngle));
    */
    
    stroke(colorArray[i]);
    strokeWeight(20);
    strokeCap(SQUARE);
    noFill();
    arc(x, y, 60, 60, radians(startAngle), radians(endAngle));
  }
}




void draw() {
  endRecord();
}
