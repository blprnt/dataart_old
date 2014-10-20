import http.requests.*;

//URL for accessing spotify's API
String baseURL = "https://api.spotify.com/v1/artists/";

//Get the artist ID by right clicking on the artist (in spotify application) and copy spotify URI
String[] artistID = {
  "0TnOYISbd1XYRBk9myaseg", "66lH4jAE7pqPlOlzUKbwA0", "1HY2Jd0NmPuamShAr6KMms", "1vCWHaC5f2uS3yhpwWbIA6", "5J0dXmqEYctfFsmcakqZFH", "0LcJLqbBmaGUft1e9Mm8HV"
}; //artists in order {Pitbull, Miranda Lambert, Lady Gaga, Avicii, Lisa Miskovsky, ABBA } 
String countryID = "US";
JSONObject[] json;
JSONArray tracks;
String track;
int popularity, popcount;
float[] popcount_mapped;
float step;
PFont mono;
int[] x = new int[artistID.length] ;
int[] y = new int[artistID.length];

void setup() {
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  background(0);
  noStroke();

  mono = createFont("Arial", 15);
  textFont(mono);
  popcount = 0;
  step = 0;
  getData();
}

void draw() {
  background(0);
  translate(width/2, height/2);

  renderData();
}


//Gets the data from the spotify API
void getData() {
  json = new JSONObject[artistID.length];
  popcount_mapped = new float[artistID.length];

  for (int j = 0; j < artistID.length; j++) {
    json[j] = loadJSONObject(baseURL + artistID[j] + "/top-tracks?country=" + countryID);
    tracks = json[j].getJSONArray("tracks"); 
    popcount = 0;
    popularity = 0;
    for (int i = 0; i < tracks.size (); i++) {
      track = tracks.getJSONObject(i).getString("name"); //gets the track title
      popularity = tracks.getJSONObject(i).getInt("popularity"); //gets track popularity score, score based on how much a song has been played and how recently  
      popcount += popularity;

      println("track " + track + " popularity " + popularity + " popcount " + popcount );
    }
    println("artist " + artistID[j]);
    popcount_mapped[j] = map(popcount, 0, 1000, -400, 300);
    println("popcount_mapped: " + popcount_mapped[j]);
  }
}

void renderData() {
  step+=0.5;

  for (int j = 0; j < artistID.length; j++) {
    tracks = json[j].getJSONArray("tracks"); 
    //println();
    //println("artist " + artistID[j]);
    //println("popcount_mapped: " + popcount_mapped[j]);
    
    if (step==0.5) {
      x[j] = (int)random(-width/2+130, width/2-130);
      y[j] = (int)random(-height/2+130, height/2-130);
    }
    pushMatrix();
    translate(x[j], y[j], popcount_mapped[j]);

    for (int i = 0; i < tracks.size (); i++) {
      track = tracks.getJSONObject(i).getString("name"); //gets the track title

      String[] m1 = match(track, "[Yy]ou|[Yy]our| [Uu] |He |( he&&he )|[Ss]he| [Hh]er|[Hh]im|( [Mm]an&&[Mm]an )| [Mm]an |[Ww]oman]|[Gg]uy]|[Gg]irl|[Th]ey |[Th]eir| [Tt]hem ");
      String[] m2 = match(track, "I | I$|Me|( me&&me )|[Mm]yself|[Mm]ine");
      String[] m3 = match(track, "[Ww]e|[Uu]s |$[Oo]ur| [Oo]ur|[Tt]ogether");
      if (m1 != null && m2 == null && m3 == null) {  
        fill(255, 0, 0); //red
        //println("Found a match1 in: '" + track + "' " + m1[0]);
      } else if (m2 != null && m1 == null && m3 == null) {
        fill(0, 255, 0); //green
        //println("Found a match2 in: '" + track + "' " + m2[0]);
      } else if (m3 != null && m1 == null && m2 == null) {
        fill(0, 0, 255); //blue
        //println("Found a match3 in: '" + track + "' " + m3[0]);
      } else if (m1 != null && m2 != null && m3 == null) {
        fill(255, 255, 0); //yellow
        //println("Found a match1,2 in: '" + track + "' m1: " + m1[0] + " m2: " + m2[0]);
      } else if (m1 != null && m2 == null && m3 != null) {
        fill(255, 0, 255); //magenta
        //println("Found a match1,2 in: '" + track + "' m1: " + m1[0] + " m3: " + m3[0]);
      } else if (m1 == null && m2 != null && m3 != null) {
        fill(0, 255, 255); //cyan
        //println("Found a match1,2 in: '" + track + "' m2: " + m2[0] + " m3: " + m3[0]);
      } else {
        fill(255);
        //println("No match found in '" + track + "'");
      }

      pushMatrix();
      rotate(radians((360/10)*i + step)); //adds all the tracks in a circle shape to create a 'flower' look, step makes it rotate
      translate(25, 0); //translates the text to create bigger black hole in the middle of each 'flower'
      text(track, 0, 0); //draws the 'flowers' to the screen
      popMatrix();
      
      int popcount_temp  = (int)map(popcount_mapped[j],-400,300, 0, 1000);
      pushMatrix();
      fill(255);
      text(popcount_temp/10,-10,5);
      popMatrix();

      //println("track " + track + " popularity " + popularity + " popcount " + popcount );
    }

    popMatrix();
  }

}

