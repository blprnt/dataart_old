

String apiKey = "1825925a41f316cec43546a30217db21:7:69780968";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";
//String fq = "glocations:(\"JAPAN\")";
String beginDate = "20130613";
String endDate = "20140613";
int queryDelay = 1200;


JSONObject json;

void setup() {
  size(30, 30, P3D);
  smooth(8);
  background(255);
  
  //For all countries in the JSON file, 
  //get the number of hits/articles in the last year

  json = loadJSONObject("inputworld.json");

  JSONArray values = json.getJSONArray("countries");
  
  for (int i = 0; i < values.size(); i++) {
    
    JSONObject country = values.getJSONObject(i); 
    String name = country.getString("name");
    
    //call search function and return 'hits'
    int hits = search(name);
    
    country.setInt("hits", hits);
    
    delay(queryDelay);
  }
  
    //and update it to a new JSON file
  saveJSONObject(json, "data/outputworld.json");
}

void draw() {
}



