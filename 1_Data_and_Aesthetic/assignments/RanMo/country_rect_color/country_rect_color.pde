float longti;
float lati;
FloatList Northernmostx;
FloatList Northernmosty;
FloatList Southernmostx;
FloatList Southernmosty;
FloatList Westernmostx;
FloatList Westernmosty;
FloatList Easternmostx;
FloatList Easternmosty;
FloatList Popdensity;
ArrayList<Rectangle> rectangles;
Table table;
StringList countries;

TableRow row;

void setup() {
  size (1440, 680);
  //background(255, 255, 255);

  table = loadTable("coordinates.csv", "header");
  println(table.getRowCount() + " total rows in table");

  rectangles = new ArrayList<Rectangle>();
  countries = new StringList();

  loadData();

  //println("I am done. Are You?");
  //println("rectangles size - " + rectangles.size());
  /*
  //============= map the coordinate window as the real map==========
   float lonstart = map(longti, -180, 180, 0, width);
   float latstart = map(lati, -60, 90, 400, 0);
   
   
   
   
   for(int i = 0; i < ; i++){
   drawRect();
   }
   */
}

void mapValues() {
}

//======= Load extreme points of each country from csv file=======
void loadData() {
  Northernmostx = new FloatList();
  Northernmosty = new FloatList();
  Southernmostx = new FloatList();
  Southernmosty = new FloatList();
  Westernmostx = new FloatList();
  Westernmosty = new FloatList();
  Easternmostx = new FloatList();
  Easternmosty = new FloatList();
  Popdensity = new FloatList();

  int counter = 0;
  float latitude, longtitude;
  for (TableRow row : table.rows()) {
    String c = row.getString("Country");
    countries.append(c);
    
    float temp_Northernmostx = row.getFloat("Northernmost.x");
    //println("temp_Northernmostx - " + temp_Northernmostx);
    latitude = map(temp_Northernmostx, -70, 100, height, 0);
    //println("latitude - " + latitude);
    Northernmostx.append(latitude);

    float temp_Northernmosty = row.getFloat("Northernmost.y");
    //println("temp_Northernmosty - " + temp_Northernmosty);
    longtitude = map(temp_Northernmosty, -180, 180, 0, width);
    //println("longtitude - " + longtitude);
    Northernmosty.append(longtitude);


    float temp_Southernmostx = row.getFloat("Southernmost.x");
    latitude = map(temp_Southernmostx, -70, 100, height, 0);
    Southernmostx.append(latitude);

    float temp_Southernmosty = row.getFloat("Southernmost.y");
    longtitude = map(temp_Southernmosty, -180, 180, 0, width);
    Southernmosty.append(longtitude);

    float temp_Westernmostx = row.getFloat("Westernmost.x");
    latitude = map(temp_Westernmostx, -70, 100, height, 0);
    Westernmostx.append(latitude);
    //println("latitude - " +  latitude);
    
    float temp_Westernmosty = row.getFloat("Westernmost.y");
    longtitude = map(temp_Westernmosty, -180, 180, 0, width);
    Westernmosty.append(longtitude);

    float temp_Easternmostx = row.getFloat("Easternmost.x");
    latitude = map(temp_Easternmostx, -60, 90, height, 0);
    Easternmostx.append(latitude);
    //println("latitude - " +  latitude);
    
    float temp_Easternmosty = row.getFloat("Easternmost.y");
    longtitude = map(temp_Easternmosty, -180, 180, 0, width);
    Easternmosty.append(longtitude);
    
    float temp_density = row.getFloat("Popdensity");
    Popdensity.append(temp_density);
    //println("This is popdensity: " + Popdensity);
    
    
    


    /*
    Southernmostx.append(temp_Southernmostx);
    Southernmosty.append(temp_Southernmosty);
    Westernmostx.append(temp_Westernmostx);
    Westernmosty.append(temp_Westernmosty);
    Easternmostx.append(temp_Easternmostx);
    Easternmosty.append(temp_Easternmosty);
    */



//    println("Easternmosty - " + Easternmosty.get(Easternmosty.size()-1));
//    println("Westernmosty - "+ Westernmosty.get(Westernmosty.size()-1));

    float rectwidth = Easternmosty.get(Easternmosty.size()-1) - Westernmosty.get(Westernmosty.size()-1);
    float rectheight = Southernmostx.get(Southernmostx.size()-1) - Northernmostx.get(Northernmostx.size()-1);
    float x = Northernmosty.get(Northernmosty.size()-1) - (rectwidth/2);
    float y = Westernmostx.get(Westernmostx.size()-1) - (rectheight/2);
    float density = Popdensity.get(Popdensity.size()-1);
    println("This is density value: " + Popdensity.size());
    

    Rectangle r = new Rectangle(x, y, rectwidth, rectheight, c, density);
    rectangles.add(r);

    counter++;
  }


  /*
  for (int i = 0; i< Northernmost.x.size(); i++) {
   float northx = Northernmostx.get(i);
   float northy = Northernmosty.get(i);
   float southx = Southernmostx.get(i);
   float southy = Southernmosty.get(i);
   float westx = Westernmostx.get(i);
   float westy = Westernmosty.get(i);
   float eastx = Easternmostx.get(i);
   float easty = Easternmosty.get(i);
   
   }
   */
}

void drawRect(float eastx, float easty, float westx, float westy, float southx, float southy, float northx, float northy) {

  float rectwidth = eastx - westx;
  float rectheight = southy - northy;
  float x = northx - (rectwidth/2);
  float y = westy - (rectheight/2);

  //rectangles.add(x, y, rectwidth, rectheight);
}

void draw() {

  for (int i=0 ; i < rectangles.size();++i) {

    Rectangle r = rectangles.get(i);
    r.rect_draw();
  }
}

