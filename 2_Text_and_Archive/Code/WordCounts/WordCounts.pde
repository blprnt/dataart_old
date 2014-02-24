
import rita.*;

String dataPath = "../../../data/";

void setup() {
  size(1280,720);
  countWords("mobydick.txt");
}

void draw() {
  
}

void countWords(String url) {
  IntDict counter = new IntDict();
  
  String[] rows = loadStrings(dataPath + url);
  String text = join(rows,"");
  String[] sentences = RiTa.splitSentences(text);
  
  for (String s:sentences) {
    String[] words = RiTa.tokenize(RiTa.stripPunctuation(s));
    for (String w:words) {
       counter.add(w.toLowerCase(), 1);
    }
  }
  
  counter.sortValuesReverse();
  String[] theKeys = counter.keyArray();

  for (int i = 0; i < 100; i++) {
    println(theKeys[i]);
  }
}


