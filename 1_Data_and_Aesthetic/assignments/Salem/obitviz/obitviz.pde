import processing.pdf.*;


PFont font, monthfont;

String[][] all;

Cube c;
Cube[] cubes;

Stripe s;
float stripew = 100;
float stripeh;

Stripe[] stripes;

boolean zoomedIn;
int zoomedInIndex;


void setup() {
  //size(1440, 800, P3D);
  //size(1440, 800);
  size(3000, 7000);

  //addNamesAndAgeAndDates();

  beginRecord(PDF, "test.pdf"); 

  font = createFont("Gotham-Light-10", 10);
  monthfont = createFont("Gotham-Light-20", 20);

  textFont(font);

  //loadData("deadPeople2014Data1.tsv");
  //loadData2("dp-edited-2.csv");
  loadData2("dp-cleaned4.csv");
  for (int i = 0; i < all.length; i++) {
    //    println(i);
    //    println("name is " + all[i][0]);
    //    println("age is " + all[i][1]);
    //    println("desc is " + all[i][2]);
  }

  //c = new Cube();

  s = new Stripe();
  stripes = visualizeAllLoadOnly();
}

void draw() {

  //lights();
  //ortho();

  //  noStroke();
  //  fill(100);
  //  pushMatrix();
  //  translate(width/2, height/2, 0);
  //  //rotateY(radians(map(mouseX, 0, width, 0, 90)));
  //  //box(50, 50, map(mouseY, 0.25*height , 0.75*height, 0, 400));
  //  box(2, height, 2);
  //  popMatrix();




  //  stroke(200);
  //  fill(0, 200);
  //  pushMatrix();
  //  translate(width/2, height/2, 0);
  //  rotateY(radians(map(mouseX, 0, width, 0, 90)));
  //  //box(50, 50, map(mouseY, 0.25*height , 0.75*height, 0, 400));
  //  box(60, 60, 100);
  //  stroke(255);
  //  fill(255);
  //  //rect(50, 50, 100, 100);
  //
  //  fill(0);
  //  textLeading(12);
  //  text("One of the Original Seven Astronauts", -50, +45, 50);
  //
  //  popMatrix();

  //  s.draw();
  //  s.drawText("One of the Original \nSeven Astronauts");
  //
  //  visualizeOne(all[2], 100, 100);

  //visualizeAll();
  //c.draw();
  //drawCubes();

  //  if (!zoomedIn) {
  background(255); 
  drawAllStripes(stripes);
  //  }
  //  else {
  //    background(255);
  //    pushMatrix();
  //    //scale(2.0);
  //    translate(30,30);
  //    stripes[zoomedInIndex].drawAt0();
  //    
  //    popMatrix();
  //  }

  endRecord();

  //  fill(0, 0, 200, 200);
  //  pushMatrix();
  //  translate(width/2, height/2, -100);
  //  rotateY(radians(map(mouseX, 0, width, 0, 90)));
  //  box(50, 50, -100);
  //  popMatrix();
  //
}

String[] getDetails(String headline) {
  String[] tokens =  split(headline, ",");

  String name = tokens[0];
  //String age = headline.replaceAll("[^0-9]+", " ");
  //age = age.trim();
  String age = "" + ageFinder(headline);
  //age = (int(age) > 0 && int(age) < 150)? age: 1;
  String desc = (tokens.length>1)? tokens[1]: " ";

  String[] output = {
    name, age, desc
  };

  return output;
}


void loadData(String url) {
  Table data = loadTable(url, "header, tsv");


  all = new String[data.getRowCount()][3];


  for (int i = 0; i < data.getRowCount(); i++) {
    //get the first column of each row and put it in the array
    all[i] = getDetails(data.getRow(i).getString(0));
  }
}

void loadData2(String url) {
  //Table data = loadTable(url, "header, tsv");
  Table data = loadTable(url, "header, csv");

  all = new String[data.getRowCount()][data.getColumnCount()];


  for (int i = 0; i < data.getRowCount(); i++) {
    //get the first column of each row and put it in the array

    String[] temp = { 
      data.getRow(i).getString(0), 
      data.getRow(i).getString(4), 
      data.getRow(i).getString(8)
      };
      all[i] = temp;
  }
}


void visualizeOne(String[] data, float x, float y) {

  Stripe stripe = new Stripe(x, y, stripew, 20);

  String age = data[1];
  String desc = data[2];


  float yearofbirth = 2013 - float(age);
  float lifestart = map(yearofbirth, 1890, 2014, 0, stripew);

  stripe.draw();
  stripe.drawLife(lifestart);
  stripe.drawText(breakDownText(desc));
}

Stripe visualizeOneLoadOnly(String[] data, float x, float y) {

  Stripe stripe = new Stripe(x, y, stripew, 20);

  String age = data[1];
  String desc = data[2];


  float yearofbirth = 2013 - float(age);
  float lifestart = map(yearofbirth, 1890, 2014, 0, stripew);

  //stripe.draw();
  stripe.setLifeStart(lifestart);
  stripe.setText(restrictString2(desc, 16));

  return stripe;
}

String breakDownText(String txt) {

  String[] tokens = split(txt, " ");

  String returned = "";
  for (int i = 0; i < tokens.length; i++) {
    returned += tokens[i];
    returned += " ";
    if ((i > 0) && (i % 2 == 0)) returned += "\n ";
  }

  return returned;
}

void visualizeAll() {

  //for every 5 elements, go to a new row
  //start at x = 30, y = 30, x-gap = 30, y-gap = 30;
  //increment x by stripew + x-gap within a row
  //increment y by stripeh + y-gap

  int elementsperrow = 10;
  float startx = 30;
  float starty = 60;
  float xgap = 30;
  float ygap = 30;

  float xincrement = stripew + xgap;
  float yincrement = stripeh + ygap;

  float x = startx;
  float y = starty;


  for (int i = 0; i < all.length; i++) {


    visualizeOne(all[i], x, y);

    x += xincrement; 
    if ( i > 0 && i % elementsperrow == 0 ) 
    {

      y += yincrement;
      x = startx;
    }
  }
}

Stripe[] visualizeAllLoadOnly() {

  //for every 5 elements, go to a new row
  //start at x = 30, y = 30, x-gap = 30, y-gap = 30;
  //increment x by stripew + x-gap within a row
  //increment y by stripeh + y-gap

  Stripe[] stripes_ = new Stripe[all.length];

  int elementsperrow = 21;
  float startx = 30;
  float starty = 60;
  float xgap = 30;
  float ygap = 50;

  float xincrement = stripew + xgap;
  float yincrement = stripeh + ygap;

  float x = startx;
  float y = starty;


  for (int i = 0; i < all.length; i++) {


    Stripe stripe_ = visualizeOneLoadOnly(all[i], x, y);
    stripes_[i] = stripe_;

    x += xincrement; 
    if ( (i > 0) && (i % elementsperrow == 0) ) 
    {
      
      y += yincrement;
      x = startx;
    }
  }

  return stripes_;
}


void drawStripe(Stripe str) {
  str.draw();
  str.drawLife();
  str.drawText();
}

void drawAllStripes(Stripe[] str) {

  for (int i = 0; i < str.length; i++) {
    drawStripe(str[i]);
  }
}

float ageFinder(String headline) {
  //go through strings, and find any that have numbers

  float age = 0;


  if (headline.matches(".*\\d+.*")) {
    //there is a digit
    println("there is a digit!");
    String digits = headline.replaceAll("\\D+", "");
    float digit = float(digits);
    println("there is a digit! " + digit);

    //check  if the digit is between 10 and 140
    if (digit >= 10 && digit <= 150) {
      //we've got our digits!

      age = digit;
      println("\t digit is between 10 and 150! It is " + age);
    } 
    else {
      //      //check whether the digit in the form YYYY-YYYY //TOO LATE, dash was removed in previous step
      //      //check whether the number is 8 digits?
      //      String digitstr = "" + digit;
      //      if (digitstr.length() == 8) {
      //        //do year age detection stuff
      //        println("\t number is8 character long! It is " + digitstr);
      //        float yearofbirth = float(digitstr.substring(0, 3));
      //        float yearofdeath = float(digitstr.substring(4, 7));
      //        age = yearofdeath - yearofdeath;
      //      }
      age = 0;
    }
  }

  return age;
}

//void mouseClicked() {
//  for (int i = 0; i < stripes.length; i++) {
//    stripes[i].inBoundaries();
//    zoomedIn = true;
//    zoomedInIndex = i;
//    //stripes[i].zoomIn();
//  }
//}

int getMonth(String date) {
  //from date format: 2013-01-05T00:00:00Z

  int month = int(date.substring(5, 7));

  return month;
}

int getDay(String date) {

  //from date format: 2013-01-05T00:00:00Z

  int day = int(trim(date.substring(8, 10)));

  return day;
}

int getYear(String date) {

  //from date format: 2013-01-05T00:00:00Z

  int year = int(date.substring(0, 4));

  return year;
}

String restrictString(String str, int chars) {
  String newstr = str.substring(0, Math.min(str.length(), chars));

  if (str.length() > chars) newstr += "...";

  return newstr;
}

String restrictString2(String str, int chars) {

  String newstr = "";
  if (str.length() > chars) {

    for (int i = 0; i < str.length(); i++) {
      char c = str.charAt(i);
      newstr += c;
      if ( i != 0 && i % chars == 0) newstr += "-\n"; 

      //Process char
    }
    return newstr;
  } else return str;

  
}


//void drawCubes() {
//  cubes = new Cube[all.length];
//
//  float w = 40;
//  float h = 40;
//
//  float startingx = width/12;
//  float startingy = h;
//
//  float xmargin = w;
//  float ymargin = h;
//
//  //float cubesperrow = width / ( startingx + w + xmargin);
//  float cubesperrow = 12;
//
//  int rowindex = 0;
//
//  float x = startingx;
//  float y = startingy;
//
//  for (int i = 0; i < all.length; i++) {
//
//    cubes[i] = new Cube(x, y, 0, w, h, map(float(all[i][1]), 0, 100, 0, w));
//    //cubes[i].setText(all[i][2]);
//    cubes[i].draw();
//    x +=  w + xmargin;
//
//    if ( i > 0 && (i + 1) % cubesperrow == 0) {
//      rowindex++;
//      x = startingx;
//      y += h + ymargin;
//    }
//  }
//}

void drawMonth(float x, float y, float number) {
  fill(0);
  textFont(monthfont);

  rect(x, y, stripew, stripeh);
  fill(255);
  text(number, x + 10, y + 0.75*stripeh );
}

