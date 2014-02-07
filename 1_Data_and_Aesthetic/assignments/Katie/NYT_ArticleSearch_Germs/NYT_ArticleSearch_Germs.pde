/*

 ITP Data Art
 NYTimes Article Search v2 Simple Example
 
 **Note - you must put your API key in the first field for this to work!
 
 Article Search v2 docs: http://developer.nytimes.com/docs/read/article_search_api_v2 
 
 */

String apiKey = "Your API goes here";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  background(255);
  
  //This function returns a list of integers, counting a search term per year
  int[] germCounts = doASearchYears("chicken pox", 1900, 2000);
  
  //Which we can draw a bar chart from:
  for (int i = 0; i < germCounts.length; i++) {
   fill(0,150);
   float x = map(i,0, germCounts.length,100, width - 100);
   float y = height - 50;
   float w = (width - 200)/germCounts.length;
   float h = -map(germCounts[i], 0, max(germCounts), 0, height - 100);
   rect(x, y, w, h);
  }
  
  //It's often useful to save data like this (so we don't have to call the API every time once we're visualizing)
  PrintWriter writer = createWriter("data/chickenpox01Data.csv");
  for (int i:germCounts) writer.println(i);
  writer.flush();
  writer.close();
  
  /*
  //There is really a lot more we can do with this.
  //Here, a search for 'bin laden' on the day he was killed
  ASResult osama = doASearch("bin laden", "20110502", "20110502");
  //Find out how many articles
  println(osama.hits);
  //Get the headline of the fourth one
  println(osama.docs[3].headline);
  //And a snippet from the second one
  println(osama.docs[2].snippet);
  //We can get access to any of the fields that are returned (see API docs). For example the URL to the first story:
  println(osama.docs[0].docJSON.getString("web_url"));
  //Or, a JSON list of the keywords associated with the story
  JSONArray keyWords = osama.docs[0].docJSON.getJSONArray("keywords");
  for(int i =0; i < keyWords.size(); i++) {
   JSONObject keyWord = keyWords.getJSONObject(i); 
   println(keyWord.getString("name"), keyWord.getString("value"));
  }
  */
  
}

void draw() {
}



