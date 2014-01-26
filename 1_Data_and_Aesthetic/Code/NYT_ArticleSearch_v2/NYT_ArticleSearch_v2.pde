/*

 ITP Data Art
 NYTimes Article Search v2 Simple Example
 
 **Note - you must put your API key in the first field for this to work!
 
 Article Search v2 docs: http://developer.nytimes.com/docs/read/article_search_api_v2 
 
 */

String apiKey = "YOUR_API_KEY_HERE";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  
  //This function returns a list of integers, counting a search term per year
  int[] monkeyCounts = doASearchYears("monkey", 1901, 1911);
  println(monkeyCounts);
  
  //It's often useful to save data like this (so we don't have to call the API every time once we're visualizing)
  PrintWriter writer = createWriter("data/monkeyData.csv");
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

int[] doASearchYears(String q, int startYear, int endYear) {
  int[] counts = new int[endYear - startYear];
  for (int i = startYear; i < endYear; i++) {
    println(i);
    ASResult r = doASearch(q, i + "0101", i + "1231");
    counts[i - startYear] = r.hits;
  }
  return(counts);
}

ASResult doASearch(String q, String beginDate, String endDate) {
  ASResult result = new ASResult();
  result.resultJSON = loadJSONObject(getASURL(q, beginDate, endDate));
  result.parse();
  return(result);
}

String getASURL(String q, String beginDate, String endDate) {
  return(baseURL + "q=" + java.net.URLEncoder.encode(q) + "&begin_date=" + beginDate + "&end_date=" + endDate + "&api-key=" + apiKey);
}

class ASResult {
  JSONObject resultJSON; 
  ASDoc[] docs;
  int hits;

  void parse() {
    JSONObject response = resultJSON.getJSONObject("response");
    JSONObject meta = response.getJSONObject("meta");
    hits = meta.getInt("hits");

    JSONArray docArray = response.getJSONArray("docs");
    int totalDocs = docArray.size();
    docs = new ASDoc[totalDocs];

    for (int i = 0; i < totalDocs; i++) {
      JSONObject doco = docArray.getJSONObject(i);
      ASDoc doc = new ASDoc();
      doc.docJSON = doco;

      docs[i] = doc;
      doc.parse();
    }
  }
}

class ASDoc {
  JSONObject docJSON;

  //** Note - all other fields of the documents can be fished out manually from the docJSON object. ie. docJSON.getString("web_url");
  //          I've just built in these three for convenience sake
  String headline;
  int page;
  String snippet;


  void parse() {
    headline = docJSON.getJSONObject("headline").getString("main");
    try {
      page = int(docJSON.getString("print_page"));
    } 
    catch(Exception e) {
      //Sometimes pages are null. In this case, we'll set it to -1
      page = -1;
    }

    try {
      snippet = docJSON.getString("snippet");
    } 
    catch (Exception e) {
      //Sometimes the snippets are null. In this case we'll set it to "";
      snippet = "";
    }
  }
}

