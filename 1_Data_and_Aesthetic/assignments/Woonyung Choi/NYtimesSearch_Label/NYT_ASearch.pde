int queryDelay = 1200;

int[] doASearchYears(String q, int startYear, int endYear) {
  int[] counts = new int[endYear - startYear];
  int i = startYear;
  while (i < endYear) {
     println(i);
    try {
      ASResult r = doASearch(q, i + "0101", i + "1231");
      println(r.hits);
      counts[i - startYear] = r.hits;
      delay(queryDelay);
      i++;
    } catch (Exception e) {
     println("FAILED ON " + i + ". IF YOU SEE THIS MESSAGE A BUNCH OF TIMES IN A ROW, TRY AGAIN LATER, OR WITH A DIFFERENT QUERY. \n AND MAKE SURE YOU'VE ENTERED YOUR API KEY!"); 
    }
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
