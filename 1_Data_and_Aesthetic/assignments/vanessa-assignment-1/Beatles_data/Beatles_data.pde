/*

 ITP Data Art
 NYTimes Article Search v2 Simple Example
 
 **Note - you must put your API key in the first field for this to work!
 
 Article Search v2 docs: http://developer.nytimes.com/docs/read/article_search_api_v2 
 
 */

String apiKey = "C6ED51E1E5FD161A282B30A414762CA0:6:57885477";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

void setup() {
  size(1000, 720, P3D);
  smooth(8);
  background(#61B7CF);

   //This function returns a list of integers, counting a search term per year
int[] mccartney = doASearchYears("Paul McCartney", 1960, 1980);

  //Which we can draw a bar chart from:
  for (int i = 0; i < mccartney.length; i++) {
    int n = mccartney[i];
    fill(0, 150);
    float x = map(i, 0, mccartney.length, 0, width/4);
    float y = height;
    //float w = (width - 200)/monkeyCounts.length;
    float w = 5;
    float h = -map(mccartney[i], 0, max(mccartney), 0, height - 100);
    float c = map(n, 0, max(mccartney), 0, 255);
    noStroke();
    fill(205, c, c, 250);
    rect(x, y, w, h);
  }
 
   //This function returns a list of integers, counting a search term per year
  int[] lennon = doASearchYears("John Lennon", 1960, 1980);

  //Which we can draw a bar chart from:
  for (int i = 0; i < lennon.length; i++) {
    int n = lennon[i];
    fill(0, 150);
    float x = map(i, 0, lennon.length, width/4, width/2);
    float y = height;
    //float w = (width - 200)/monkeyCounts.length;
    float w = 5;
    float h = -map(lennon[i], 0, max(lennon), 0, height - 100);
    float c = map(n, 0, max(lennon), 0, 255);
    noStroke();
    fill(c, c, 205, 250);
    rect(x, y, w, h);
  }


//This function returns a list of integers, counting a search term per year
  int[] george = doASearchYears("George Harrison", 1960, 1980);

  //Which we can draw a bar chart from:
  for (int i = 0; i < george.length; i++) {
    int n = george[i];
    fill(0, 150);
    float x = map(i, 0, george.length, width/2, 750);
    float y = height;
    //float w = (width - 200)/monkeyCounts.length;
    float w = 5;
    float h = -map(george[i], 0, max(george), 0, height - 100);
    float c = map(n, 0, max(george), 0, 255);
    noStroke();
    fill(165, c, 100, 250);
    rect(x, y, w, h);
  }
 
  //This function returns a list of integers, counting a search term per year
  int[] ringo = doASearchYears("Ringo Starr", 1960, 1980);

  //Which we can draw a bar chart from:
  for (int i = 0; i < ringo.length; i++) {
    int n = ringo[i];
    fill(0, 150);
    float x = map(i, 0, ringo.length, 750, width);
    float y = height;
    //float w = (width - 200)/monkeyCounts.length;
    float w = 5;
    float h = -map(ringo[i], 0, max(ringo), 0, height - 100);
    float c = map(n, 0, max(ringo), 0, 255);
    noStroke();
    fill(105, 205, c, 250);
    rect(x, y, w, h);
  }
 
 //This function returns a list of integers, counting a search term per year
  int[] beatles = doASearchYears("Beatles", 1960, 2000);

 
  for (int i = 0; i < beatles.length; i++) {
    int n = beatles[i];
    float x = width/2;
    float y = height/2;
    float w = 6;
    float h = -map(n, 0, max(beatles), 0, 2*height);
    float r = map(i, 0, beatles.length, 0, TAU);
    float c = map(n, 0, max(beatles), 0, 255);
    fill(205, c, 150, 150);
    noStroke();

    pushMatrix();
    translate(x, y);
    rotate(r);
    ellipse(0, 0, w, h);
    popMatrix();
  }

  //It's often useful to save data like this (so we don't have to call the API every time once we're visualizing)
  PrintWriter writer = createWriter("data/radioData.csv");
  for (int i:lennon) writer.println(i);
  writer.flush();
  writer.close();


}

void draw() {
}


