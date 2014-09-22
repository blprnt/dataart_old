int search(String name){

  
  String fq = "glocations:(\""+name+"\")";
  
  String getASURL = baseURL + "fq=" + java.net.URLEncoder.encode(fq) + "&begin_date=" + beginDate + "&end_date=" + endDate + "&api-key=" + apiKey;

  JSONObject result = loadJSONObject(getASURL);
  JSONObject response = result.getJSONObject("response");
  JSONObject meta = response.getJSONObject("meta");
  int hits = meta.getInt("hits");
  if(hits<100)
    hits = 0;
  println(hits);
  
  return hits;

}
