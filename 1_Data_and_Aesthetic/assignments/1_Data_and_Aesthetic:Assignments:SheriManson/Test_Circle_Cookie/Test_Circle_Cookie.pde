
import processing.pdf.*;
int [] counts;

void setup() {
  size (4000, 2000);
  beginRecord(PDF, "circlesTest.pdf");
  loadData();
}

void draw() {
  background (255);
  renderCircles(counts);
  translate (50, 50);
}
// get info into Processing
void loadData() {
  Table myTable  = loadTable("deathData1.csv");
  counts = new int[myTable.getRowCount()];

  /*for (TableRow row:myTable.rows()) {
   println (row.getInt(0));
   
   }*/

  for (int i = 0; i < myTable.getRowCount(); i++) {
    counts[i] = myTable.getRow(i). getInt(0);
    //println (myTable.getRow(i).getInt(0));
  }
}

//void keyPressed() {
//  if (key == 's') {
//    saveFrame("frame.jpg");
// }
//}

void renderCircles(int[] nums) {

  float x = 50;
  float d_temp = 0;
  float y = 80;
  float biggest_circle = 0;

  for (int i = 0; i < nums.length; i++) {
    //for (int i = 0; i < nums.length/2; i++) {
    //for (int i = nums.length/2; i < nums.length; i++) {

    float d = map((nums[i]), 0, (max(nums)), 0, 135);

    if (d > biggest_circle) {
      biggest_circle = d;
    }


    x += d + d_temp;

    d_temp = d;
    d_temp += 10; 

    //float x = map(i, 0, nums.length, 0, width-125);

    if (x + d + 30 > width) {

      y += (2*d) + (biggest_circle) ;

      x = d + 20;

      //biggest_circle = 0;
    }      
    //draw mapped circles
    noFill();
    stroke (255, 0, 0);

    ellipseMode (RADIUS);// can I do this?
    ellipse (x, y, d, d);
  }
  endRecord();
}

