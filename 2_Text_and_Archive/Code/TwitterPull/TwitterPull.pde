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


StatusListener listener;
PrintWriter writer;

boolean tweeted = false;

//This is the phrase we're looking for
String phrase = "selfie";
//This is how many tweets we're collecting
int max = 1000;
//counter for Tweets
int c = 0;

void setup() {
  size(500, 500, OPENGL);
  
  writer = createWriter(phrase + ".txt");

  //Initiate a configuration builder with our OAuth info.
  ConfigurationBuilder cb = new ConfigurationBuilder();

  cb.setOAuthConsumerKey("KEY");
  cb.setOAuthConsumerSecret("SECRET");
  cb.setOAuthAccessToken("KEY");
  cb.setOAuthAccessTokenSecret("SECRET");

  //Request a Twitter Stream
  TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();

  //Start the Twitter Stream
  try {
    listener = new StatusListener() {
      public void onStatus(Status status) {
        if (status.getText().toLowerCase().indexOf(phrase) != -1) {
          writer.println(status.getText());
          c++;
        }
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
  String[] keywordsArray = split(phrase, " ");
  filter.track(keywordsArray);
  twitterStream.filter(filter);
}

void draw() {
  //Only draw a counter
  background(0);
  fill(255);
  text(c, 50, 50);
  
  //When we have enough tweets, close the writer and quit
  if (c >= max) {
   writer.flush();
   writer.close();
   exit(); 
  }
  
}



