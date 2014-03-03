import rita.render.*;
import rita.json.*;
import rita.support.*;
import rita.*;

HashMap<String,NetworkWord> wordMap = new HashMap();
ArrayList<NetworkWord> allWords = new ArrayList();
ArrayList<NetworkWord> displayWords = new ArrayList();

HashMap<String, String> stopList = new HashMap();

void setup() {
  size(1280,720,P3D);
  
  makeStopList("../../../data/lyrics/stop.txt");
  makeTextNetwork("../../../data/lyrics/bible.txt");
  //showTopWords(20);
  showFromWord("sheep");
  
  arrangeWords();
  
  println(allWords.size());
  println(wordMap.get("god").linkMap.get("heaven"));
}

void draw() {
  background(255);
  translate(width/2, height/2);
  for(NetworkWord nw:displayWords) {
    nw.update();
    nw.render();
    nw.renderLinks();
  }
}


void showTopWords(int num) {
  displayWords = new ArrayList();
  for(int i = 0; i < num; i++) {
    displayWords.add(allWords.get(i));
  }
}

void showFromWord(String s) {
  displayWords = new ArrayList();
  for(String w:wordMap.get(s).linkMap.keys()) {
    if (wordMap.get(s).linkMap.get(w) > 3) {
      displayWords.add(wordMap.get(w));
    }
  }
}

void arrangeWords() {
  for(int i = 0; i < displayWords.size(); i++) {
    NetworkWord nw = displayWords.get(i);
    float theta = map(i, 0, displayWords.size(), 0, TAU);
    float rad = 300;
    nw.rot = theta;
    nw.pos.x = cos(theta) * rad;
    nw.pos.y = sin(theta) * rad;
  }
}

void makeTextNetwork(String url) {
  String doc = join(loadStrings(url), " ");
  String[] sentences = RiTa.splitSentences(doc);
  for(String s:sentences) {
    String[] words = RiTa.tokenize(s);
    processWords(words);
  }
}

void processWords(String[] words) {
  
  ArrayList<String> goodWords = new ArrayList();
  for(String w:words) {
    if (checkStop(trim(w)) && w.length() > 2) goodWords.add(w);
  }
  
  //1. Make new NetworkWords where necessary, update counts
  for(String w:goodWords) {
    //Have we seen this word before?
    w = RiTa.stripPunctuation(w).toLowerCase();
    if(wordMap.containsKey(w)) {
      //The word is already in the hashmap
      NetworkWord nw = wordMap.get(w);
      nw.count ++;
    } else {
      //The word is not already in the hashmap
      //Make a new word
      NetworkWord nw = new NetworkWord();
      nw.word = w;
      nw.count = 1;
      //Put it in the hashmap
      wordMap.put(w, nw);
      allWords.add(nw);
    }
  }
  
  //2. Make the network connections
  for(String w:goodWords) {
    //Pick each word
    w = RiTa.stripPunctuation(w).toLowerCase();
    NetworkWord startWord = wordMap.get(w);
    //Link to every other word
    for(String w2:goodWords) {
      w2 = RiTa.stripPunctuation(w2).toLowerCase();
      NetworkWord endWord = wordMap.get(w2);
      linkWords(startWord, endWord);
    }
  }
}

void linkWords(NetworkWord w1, NetworkWord w2) {
  if(w1 != w2) {
    w1.linkMap.add(w2.word, 1);
  }
}

void makeStopList(String url) {
  String[] rows = loadStrings(url);
  for (String s:rows) {
    stopList.put(s,s);
  }
}

boolean checkStop(String w) {
  return(!stopList.containsKey(w));
}




