import processing.opengl.*;
import java.util.*;
import twitter4j.conf.*; 
import twitter4j.internal.async.*;
import twitter4j.internal.org.json.*;
import twitter4j.internal.logging.*;
import twitter4j.json.*;
import twitter4j.internal.util.*;
import twitter4j.management.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import twitter4j.util.*;
import twitter4j.internal.http.*;
import twitter4j.*;
import twitter4j.internal.json.*;
import processing.opengl.*;
import java.util.*;

//visual things
Sphere mySphere;
float opacity;

String[] colorList = {
  "ff8c510a", 
  "ffbf812d", 
  "ffdfc27d", 
  "fff6e8c3", 
  "fff5f5f5", 
  "ffc7eae5", 
  "ff80cdc1", 
  "ff35978f", 
  "ff01665e"
};

//twitter things
StatusListener listener;

boolean tweeted = false;

PFont font;

void setup() {
  size(500, 500, OPENGL);
  mySphere = new Sphere(250.0, 250.0, 250.0, 50.0);
  mySphere.init();

  background(255);
  opacity = 5; //opacity and color show recency b/c it's real time
  mySphere.addSphereItem();
  smooth();
  
  /*//font
  font = createFont("Helvetica Neue", 20, true);
  textFont(font);
  textMode(CENTER);
  textAlign(CENTER);*/

  //config Twitter
  //Configurations
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("APIKEY");
  cb.setOAuthConsumerSecret("APISECRET");
  cb.setOAuthAccessToken("TOKEN");
  cb.setOAuthAccessTokenSecret("TOKENSECRET");

  //init twitter
  TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();

  try {
    listener = new StatusListener() {
      public void onStatus(Status status) {
        println("status");
        tweeted = true;
      }
      public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
      }
      public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
      }
      public void onStallWarning(StallWarning warning) {
      }
      public void onScrubGeo(long x, long y) {
      }
      public void onException(Exception ex) {
        ex.printStackTrace();
      }
    };
  }
  catch (Exception ex) {
    println("Couldn't connect.");
  }

  //add listener to the stream
  twitterStream.addListener(listener);

  //init filtering
  FilterQuery filter = new FilterQuery();
  String[] keywordsArray = { 
    "food", "hungry", "meal", "yum", "eat", "nom", "dinner", "tasty", "delicious", "halal", "restaurant", "food truck", "want food"
  };
  filter.track(keywordsArray);
  twitterStream.filter(filter);
}

void draw() {
  fill(#d1e5f0);
  //text("twitter is hungry", width/2, height/7, 20);
  if (tweeted) {
    yes();
    tweeted = false;
  }
}

void yes() {
  println("yes called");
  //white overlay for fade effect
  fill(255, opacity);
  rect(0, 0, width, height);

  //parameters change the drawing
  float size = 1.9;
  color c = getColor(.3); //chosen based on taste when the program runs but can be any num b/ween 0 and 1
  float tS = 2; //chosen by taste but can be any float pos or neg
  float pS = -1.001; //chosen by taste
  mySphere.update(size, c, tS, pS); //size mapped from 1.6 to 2.6, getColor(map(f, 0, 100, 0, 1)), theta, phi
  mySphere.render();
};

color getColor(float f) {
  //f is a number between 0 and 1
  //convert it to an int to pick from the array
  int i = floor(f * (colorList.length - 1));
  color col = unhex(colorList[i]);
  return(col);
}

