/*

invisible cities by Italo Calvino visualization (work in progress)

Rodrigo Derteano
March 10th 2014

Project for the Data Art class with Jer Thorp @ ITP - NYU
*/


import rita.render.*;
import rita.json.*;
import rita.support.*;
import rita.*;
import java.util.*;

HashMap<String,NetworkWord> wordMap = new HashMap();
HashMap<String, String> stopList = new HashMap();
ArrayList<NetworkWord> allWords = new ArrayList();
ArrayList<NetworkWord> displayWords = new ArrayList();
ArrayList<ComutingWord> comutingWords = new ArrayList();
IntDict CountRank = new IntDict();

int iter = 0;

float FrameStep = 0.5;
float gridSize = 15.0;

void setup() {

  size(1280, 720, P3D);
  frameRate(8);
  makeStopList("stop2.txt");
  makeTextNetwork("invisible_cities_clean.txt");
  showTopWords(80);
  //showFromWord("ec");
  arrangeWords();
}

void arrangeWords() {
  for (int i=0; i<displayWords.size(); i++) {
    NetworkWord nw = displayWords.get(i);
    /*
    float theta = map(i, 0, displayWords.size(), 0, TAU);
    float rad = 300;
    nw.pos.x = cos(theta) * rad;
    nw.pos.y = sin(theta) * rad;
    nw.rot = theta;
    */
    
    nw.pos.x = random(- width/2.5, width/2.5);
    nw.pos.y = random(- height/2.5, height/2.5);
    //println(nw.pos);
    background(255);
  }
}

void draw() {
  background(255);
  translate(width/2, height/2);
  for (NetworkWord nw:displayWords) {
    nw.update();
    nw.render();
    //nw.renderLinks();
    nw.createComunters(0);
  }
  
  for (int i=0; i<comutingWords.size(); i++) {
    ComutingWord cw = comutingWords.get(i);
    cw.update();
    cw.render();
    if (cw.pos.dist(cw.destination) < gridSize) comutingWords.remove(i);
  }
  iter++;
}

void showTopWords(int num) {
  displayWords = new ArrayList();
    
  int i = 0;
  
  for (String w:CountRank.keys()) {
    displayWords.add(wordMap.get(w));
    //println(w);
    i++;
    if (i >= num) {
      break;
    }
  }
}

void showFromWord(String word) {
  displayWords = new ArrayList();
  for(String w:wordMap.get(word).linkMap.keys()) {
    displayWords.add(wordMap.get(w)); 
  }
}

boolean checkStop(String w){
  return(!stopList.containsKey(w));
}

void makeStopList(String url) {
  String[] rows = loadStrings(url);
  for (String s:rows) {
    stopList.put(s,s);
  }
}

void makeTextNetwork(String url) {
  String doc = join(loadStrings(url), " ");
  String[] sentences = RiTa.splitSentences(doc);
  for (String s:sentences) {
    String[] words = RiTa.tokenize(s.toLowerCase());
    processWords(words);
  }
}

void processWords(String[] words) {
  
  ArrayList<String> goodWords = new ArrayList();
  for (String w:words) {
    if (checkStop(trim(w)) && trim(w).length() > 1) goodWords.add(w);
  }
  
  //1. Make new NetworkWords, update counts
  for (String w:goodWords) {
    // Have we seeen this word before
    w = RiTa.stripPunctuation(w).toLowerCase();
    if (wordMap.containsKey(w)) {
      NetworkWord nw = wordMap.get(w);
      nw.count++;
    }else{
      NetworkWord nw = new NetworkWord();
      nw.word = w;
      nw.count = 1;
      wordMap.put(w, nw);
      allWords.add(nw);
    }
  }
  // 2. Make the network connections
  for (String w:goodWords) {
    w = RiTa.stripPunctuation(w).toLowerCase();
    NetworkWord startWord = wordMap.get(w);
    // Link to every other word
    for (String w2:goodWords) {
       w2 = RiTa.stripPunctuation(w2).toLowerCase();
       NetworkWord endWord = wordMap.get(w2);
       linkWords(startWord, endWord);
    }
  }
  // Create count ranking dict
  for (NetworkWord nw:allWords) CountRank.add(nw.word, nw.count);
  CountRank.sortValuesReverse();
}

void linkWords(NetworkWord w1, NetworkWord w2) {
  if (w1.word != w2.word) {
    w1.linkMap.add(w2.word, 1);
  }
}

