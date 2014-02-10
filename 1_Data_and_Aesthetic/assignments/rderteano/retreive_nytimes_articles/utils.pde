int queryDelay = 1500;
String ApiKey = "< YOUR API KEY HERE>";

String build_query_url(String term, String field, int year, int page) {
  String beginn = str(year) + "0101";
  String end = str(year) + "1231";
  term = term.replace(" ", "%20");
  return("http://api.nytimes.com/svc/search/v2/articlesearch.json?&fq="+field+":(%22"+term+"%22)&api-key="+ApiKey+"&begin_date="+beginn+"&end_date="+end+"&page="+str(page));
}

void random_delay() {
  int r = int(random(2000));
  delay(queryDelay+r);
}

JSONObject get_complete_year(String term, String field, int year) {
  int page = 0;
  String url = build_query_url(term, field, year, page);
  println(url);
  JSONObject obj = loadJSONObject(url);
  JSONObject meta = obj.getJSONObject("response").getJSONObject("meta");
  int hits = meta.getInt("hits");
  JSONArray result_objects = obj.getJSONObject("response").getJSONArray("docs");
  JSONObject partial;

  for (int i=0; i<hits/10; i++) {
     random_delay();
     page++;
     url = build_query_url(term, field, year, page);
     while (true) {
       try {
         partial = loadJSONObject(url);
         println(url);
         break;
       } catch (Exception e) {
         println(e);
         random_delay();
         random_delay();
       }
     }
     
     JSONArray partial_results = partial.getJSONObject("response").getJSONArray("docs");
     for (int j=0; j < partial_results.size(); j++) {
         result_objects.append(partial_results.getJSONObject(j));
     }
  }
  JSONObject result = new JSONObject();
  result.setJSONArray("docs", result_objects);
  result.setJSONObject("meta", meta);
  return(result);
}

JSONArray get_year_range(String term, String field, int start_year, int end_year){
  
  JSONArray result_objects = new JSONArray();
  for (int y = start_year; y <= end_year; y++) {
    random_delay();
    result_objects.append(get_complete_year(term, field, y));
    println(y);
  }
  return(result_objects);
  
}




