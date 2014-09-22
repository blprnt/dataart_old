/*

 ITP Data Art
 NYTimes Article Search v2 Simple Example
 
 **Note - you must put your API key in the first field for this to work!
 
 Article Search v2 docs: http://developer.nytimes.com/docs/read/article_search_api_v2 
 
 */

String apiKey = "9aa29c0b692aca2bbb36e2ff112c2a28:9:69804257";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";
String word = "epidemic";
int fromYear = 1915;
int toYear = 2015;

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  background(255);
  
  //This function returns a list of integers, counting a search term per year
  int[] monkeyCounts = doASearchYears(word, fromYear, toYear);
  
  //Which we can draw a bar chart from:
  for (int i = 0; i < monkeyCounts.length; i++) {
   fill(0,150);
   float x = map(i,0, monkeyCounts.length,100, width - 100);
   float y = height - 100;
   float w = (width - 200)/monkeyCounts.length;
   float h = -map(monkeyCounts[i], 0, max(monkeyCounts), 0, height - 200);
   rect(x, y, w, h);
   fill(255);
   pushMatrix();
   translate(x,y);
   rotate(PI/2);
   textSize(10);
   text(i + 1901, 0, 8);
   popMatrix();
  }
  
  //It's often useful to save data like this (so we don't have to call the API every time once we're visualizing)
  PrintWriter writer = createWriter("data/"+word+"_"+fromYear+"_"+toYear+".csv");
  for (int i:monkeyCounts) writer.println(i);
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



