
JSONObject path, hits;


void setup() {
  size(30, 30, P3D);
  smooth(8);
  background(255);

  path = loadJSONObject("path.json");
  hits = loadJSONObject("hits.json");

  JSONArray pathAr = path.getJSONArray("countries");
  JSONArray hitsAr = hits.getJSONArray("countries");
  
  PrintWriter writer = createWriter("data/final.svg");

  
  
  for (int i = 0; i < pathAr.size(); i++) {
    
    JSONObject country = pathAr.getJSONObject(i); 
    int id = country.getInt("id");
    String name = country.getString("name");
    String d = country.getString("path");
    int x = country.getInt("x");
    int y = country.getInt("y");
    
    JSONObject colorcountry = hitsAr.getJSONObject(i);
    int hits = colorcountry.getInt("hits");
    //String stroke;
    int stroke = int(map(hits, 100, 2000, 0, 360));
    println(stroke);
    float strokewidth = map(hits, 100, 2000, 0, 1);
    
    String pass = "<path id=\""+id+"\" title=\""+name+"\" class=\"land\" d=\""+d+"\" transform=\"translate("+x+","+y+") \" style=\"stroke:hsla("+stroke+", 30%, 0%, 1); stroke-width:"+strokewidth+";\" />";
   writer.println(pass);

    


  }
    writer.flush();
  writer.close();
 println("done");

}

void draw() {
}

