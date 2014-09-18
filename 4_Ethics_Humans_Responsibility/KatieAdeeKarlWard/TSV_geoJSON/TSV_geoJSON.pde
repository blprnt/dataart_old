/*
TSV -> GeoJSON
Pedestrian/Traffic Deaths
*/
PrintWriter output ;

void setup(){
  output = createWriter("pedDeaths2.json"); 
  output.print("{    \"type\": \"FeatureCollection\", \n\"features\": [\n");
  
  
  
  loadTSV("nyc_traffic_fatals_2014.tsv");
}
void draw(){
  
}

void loadTSV(String url){

  Table dTable = loadTable(url, "header");
  for (int i = 0; i<dTable.getRowCount(); i++) {
    TableRow r = dTable.getRow(i);
    float lat = (r.getFloat("lat"));
    float lon = (r.getFloat("lng"));
    String vic = (r.getString("victim"));
    String age = (r.getString("age"));
    String name = (r.getString("name"));
    String sex = (r.getString("gender"));
    String date = r.getString("date")+" "+r.getString("time");
    String desc = r.getString("short_headline");
   
    
    //if (vic.equals("cyclist")) println(vic);
    output.print("{\n  \"properties\": { ");
    output.print("\"name\": \"" + name + "\", \n");
    output.print("\"age\": \"" + age + "\", \n");
    output.print("\"sex\": \"" + sex + "\", \n");
    output.print("\"date\": \"" + date + "\", \n");
    output.print("\"victim\": \"" + vic + "\", \n");
    output.print("\"desc\": \"" + desc + "\" \n");
    output.print("}, \n");
    
    output.print("\"type\": \"Feature\", \n");
    
    output.print("\"geometry\": { \n  \"type\": \"Point\", \n ");
    output.print("\"coordinates\": [" +lon+ "," +lat+ "]\n }");
    output.print("},\n");
  }
  
}



void keyPressed() {
  output.print("{}]}");
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}
