import http.requests.*;

String apiKey = ""; //INSERT API KEY HERE!!
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

JSONObject[] json_sum_sun, json_sum_rain;
JSONObject json_sun, json_rain;



void setup() {
  size(400, 400);
  smooth(8);
  background(0);
  noStroke();
  json_sum_sun = new JSONObject[10];
  json_sum_rain = new JSONObject[10];
  int[] data = getData();
  visualizeData(data[0],data[1]);
}
void draw() {
}

int[] getData() {
  int sunIndex = 0; //keeps track of the number of hits 
  for (int i = 1; i<6; i++) {
    //gets all the articles where "sun" is mentioned and has "Summer" in the headline for the year of 2014
    json_sun = loadJSONObject(baseURL+"q=sun&fq=headline:(Summer)&page="+i+"&begin_date=20140101&end_date=20141231&sort=newest&api-key=" + apiKey);
    json_sum_sun[i-1] = json_sun;

    JSONObject response_sun = json_sum_sun[i-1].getJSONObject("response");
    JSONArray docs_sun = response_sun.getJSONArray("docs");
    for (int j = 0; j < docs_sun.size (); j++) {
      JSONObject article = docs_sun.getJSONObject(j);
      JSONObject headline  = article.getJSONObject("headline");
      String main = headline.getString("main");
      //println(main);
      if (main!="") {
        sunIndex++;
      }
    }
  }

  int rainIndex = 0; //keeps track of the number of hits 
  for (int i = 1; i<5; i++) {
    //gets all the articles where "rain" is mentioned and has "Summer" in the headline for the year of 2014
    json_rain = loadJSONObject(baseURL+"q=rain&fq=headline:(Summer)&page="+i+"&begin_date=20130101&end_date=20131231&sort=newest&api-key=" + apiKey);
    json_sum_rain[i-1] = json_rain;

    JSONObject response_rain = json_sum_rain[i-1].getJSONObject("response");
    JSONArray docs_rain= response_rain.getJSONArray("docs");

    for (int j = 0; j < docs_rain.size (); j++) {
      JSONObject article = docs_rain.getJSONObject(j);
      JSONObject headline  = article.getJSONObject("headline");
      String main = headline.getString("main");
      //println(main);
      if (main!="") {
        rainIndex++;
      }
    }
  }
  int[] indexArray = {sunIndex,rainIndex};
  return indexArray;

}

void visualizeData(int data1,int data2){
  int sunIndex = data1;
  int rainIndex = data2;
  //visulizes the number of hits for sun
  for (int i = 0; i < sunIndex; i ++) {
    fill(255, 255, 0);
    int x = (int)random(1, width);
    int y = (int)random(1, height);
    ellipse(x, y, 15, 15);
  }
  //visaulizes the number of hits for rain
  for (int i = 0; i < rainIndex; i ++) {
    fill(0, 0, 255);
    int x = (int)random(1, width);
    int y = (int)random(1, height);
    rect(x, y, 5, 20);
  }
}

