/* 

Michelle Chandra
Data Art - ITP NYU
February 2014
michelle.chandra@gmail.com

This sketch was created by altering code written by Jer Thorp 
for ITP's Data Art Course at NYU (Spring 2014).

Note: This sketch creates an abstract data rep of
the frequency of the words cyan, magenta, and yellow in the 
New York Times. 

Any data set can be swapped in.

*/

int[] magenta;
int[] cyan;
int[] yellow;

int[] sum = new int[100];
float[] normalizeCyan = new float[100];
float[] normalizeYellow = new float[100];
float[] normalizeMagenta = new float[100];

void setup() {
  size(1000, 800);
  smooth(8);
// Load the data files
  magenta = loadData("magenta100.csv");
  cyan = loadData("cyan100.csv");
  yellow = loadData("yellow100.csv"); 
}

void draw() {
 background(30);
 drawSpiroGraph();
}


void drawSpiroGraph() {
  
   for (int i = 0; i < 100; i++) {

    sum[i] = cyan[i] + magenta[i] + yellow[i];

    normalizeCyan[i] = float(cyan[i]) / float(sum[i]);

    normalizeYellow[i] = float(yellow[i]) / float(sum[i]);

    normalizeMagenta[i] = float(magenta[i]) / float(sum[i]);
 
    float n = normalizeCyan[i];
    float w = map(n,0,1,50,300);
    float h = map(n,0,1,50,300);
    float r = map(i, 0, normalizeCyan.length, 0, TAU);
    float c = map(n,0,1,60,100);

   stroke(0,255,255,c);
   strokeWeight(1);
   noFill();
   
   pushMatrix();
   translate(width/2, height/2);
   rotate(r);
   ellipse(0,20,w,h);
   popMatrix();
  
    float n1 = normalizeMagenta[i];
    float w1 = map(n1,0,1,50,300);
    float h1 = map(n1,0,1,50,300);
    float r1 = map(i, 0, normalizeMagenta.length, 0, TAU);
    float c1 = map(n1,0,1,50,100);

   stroke(225,0,255,c1);
   strokeWeight(1);
   pushMatrix();
   translate(width/2, height/2);
   rotate(r1);
   ellipse(0,25,w1,h1);
   popMatrix();

    float n2 = normalizeYellow[i];
    float w2 = map(n2,0,1,50,300);
    float h2 = map(n2,0,1,50,300);
    float r2 = map(i, 0, normalizeYellow.length, 0, TAU);
    float c2 = map(n1,0,1,50,100);

    stroke(255,255,0,c2);
    strokeWeight(1.5);
    noFill();
    pushMatrix();
    translate(width/2, height/2);
    rotate(r2);
    ellipse(0,200,w2,h2);
    popMatrix(); 
  
}
}

// Load the Data into an array
int[] loadData(String url) {
  Table data = loadTable(url);
  int[] array = new int[data.getRowCount()];

  for (int i = 0; i < data.getRowCount(); i++) {
    //get the second column of each row and put it in the array
    array[i] = data.getRow(i).getInt(0);
  }
  return array;
}

void keyPressed() {
  saveFrame("file######.jpg");
}

