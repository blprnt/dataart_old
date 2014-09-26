
JSONObject json;
void setup() {
  size(30, 30, P3D);
  smooth(8);
  background(255);

  json = loadJSONObject("worldpath.json");

  JSONArray values = json.getJSONArray("countries");

  
  for (int i = 0; i < values.size(); i++) {
    
    JSONObject country = values.getJSONObject(i); 
    String name = country.getString("name");
    String center = country.getString("center");
    
    
     //String p = "35 00 N 105 00 E";
        String[] m = split(center, " ");
        float lat = float(m[0]) + (float(m[1])) / 60 ;
         
        float lon = float(m[3]) + (float(m[4])) / 60;

         int x = int(465.4 - (lon * 2.6938 + 465.4));
         int y = int(227.066 - (lat * -2.6938 + 227.066));

        if (m[2].charAt(0)=='S') {
            y = -1 * y;
            println("in N");
         }  
        if (m[2].charAt(0)=='E') {
             x = -1 * x;
            println("in W");
         }         
         country.setInt("x", x);
         country.setInt("y", y);
   
    println(name+" "+y+" "+x);
    


  }
  
  saveJSONObject(json, "data/outputworld.json");
 println("done");

}

void draw() {
}
/*
Float funtion getX(int lon) {
    return (lon * 2.6938 + 465.4);
}
Float funtion getY(int lat) {
    return (lat * -2.6938 + 227.066);
}
*/

