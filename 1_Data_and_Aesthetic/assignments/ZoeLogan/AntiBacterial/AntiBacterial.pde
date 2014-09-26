/* Circles that represent the number of years (all the same size) filled with
 smaller circles representing the number of times that the search data was 
 mentioned
 I got a lot of help on classes from Mike Allison
 */


//This could change according to how many years of info there is.
int[] counts = new int[4];
Year[] years = new Year[4];
PVector[] centers = new PVector[4];
ArrayList <Rat> rats = new ArrayList<Rat>();

void setup() {
  size(700, 700);
  smooth();
  background(80);
  loadData();

  //hardcoded the centers for the year areas....
  centers[0] = new PVector( 0 + width/4, 0 +height/4 );
  centers[1] = new PVector( 0 + width/4, height/2 +height/4 );
  centers[2] = new PVector( width/2 + width/4, 0 +height/4 );
  centers[3] = new PVector( width/2 + width/4, height/2 +height/4 );

  //for each year take the center and the counts
  for (int i =0; i < 4; i++) {
    years[i] = new Year(centers[i], counts [i]);
  }
}


void draw() {

  for (int i = 0; i < 4; i++) {
    years[i].draw();
  }
}


void loadData() {

  //Get the Data into Processing from .csv file that was made by the API thing
  Table myTable = loadTable("bacteriaData.csv");


  //for getting ints incrementally through the rows in a .csv
  for (int i =0; i < myTable.getRowCount(); i++) {
    //get info from row i, int from col 0
    counts[i] = myTable.getRow(i).getInt(0);
    //print that shit
    println(myTable.getRow(i).getInt(0));
  }
}

