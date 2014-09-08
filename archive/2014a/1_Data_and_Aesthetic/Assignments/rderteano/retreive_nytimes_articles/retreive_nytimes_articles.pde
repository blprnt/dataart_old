

void setup(){
  
  String term = "cocaine";
  String field = "headline";
  int start_year = 1851;
  int end_year = 2013;
  JSONArray result = get_year_range(term, field, start_year, end_year);
  JSONObject json = new JSONObject();
  json.setJSONArray("years", result);
  json.setInt("start_year", start_year);
  json.setInt("end_year", end_year);
  saveJSONObject(json, "data/"+term.replace(" ", "_")+"_"+str(start_year)+"-"+str(end_year)+".json");
  println("DONE!");
}


void draw(){


}
