
import rita.*;

String dataPath = "../../../data/";
HashMap<String, String> stopList = new HashMap();

IntDict counter = new IntDict();
float left = 0;

PFont label;

void setup() {
  size(1280,720);
  makeStopList("stop.txt");
  countWords("mobydick.txt");
  
  label = createFont("Helvetica", 120);
  textFont(label);
  
}

void draw() {
  background(0);
  float xOffset = map(mouseX, 0, width, 0, left - width);
  
  pushMatrix();
    translate(-xOffset, 0);
    //println(xOffset);
    renderWords();
  popMatrix();
  
  
}

void renderWords() {
  randomSeed(1);
  String[] theKeys = counter.keyArray();
  
  left = 0;
  for (int i = 0; i < 100; i++) {
    String word = theKeys[i];
    int count = counter.get(word);
    float x = i * 50;
    float y = height/2;
    float s = sqrt(count) * 5;
    
    
    fill(255,100);
    textSize(s);
    
    float w = textWidth(word);
    
    text(word, 0, y);
    fill(255);
    textSize(16);
    text(count, 0, y + 20);
    
    //rotate(map(mouseX, 0, width, 0, 1));
    translate(w,0);
    left += w;
  }
}

void makeStopList(String url) {
  String[] stops = loadStrings(dataPath + url);
  for(String s:stops) {
   stopList.put(s,s); 
  }
}

boolean checkStop(String word) {
  return(stopList.containsKey(word.toLowerCase())); 
}

void countWords(String url) {
  
  
  String[] rows = loadStrings(dataPath + url);
  String text = join(rows,"");
  String[] sentences = RiTa.splitSentences(text);
  
  for (String s:sentences) {
    String[] words = RiTa.tokenize(RiTa.stripPunctuation(s));
    for (String w:words) {
       //counter.add(w.toLowerCase(), 1);
       if(!checkStop(w)) counter.increment(w.toLowerCase());
    }
  }
  
  counter.sortValuesReverse();
  

  
}


