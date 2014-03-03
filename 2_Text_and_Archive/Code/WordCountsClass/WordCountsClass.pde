import rita.render.*;
import rita.json.*;
import rita.support.*;
import rita.*;

HashMap<String, String> stopList = new HashMap();

void setup() {
  size(1280,720);
  makeStopList("../../../data/stop.txt");
  //doWordCount("../../../data/mobydick.txt");
  //makeSentenceList("../../../data/mobydick.txt", "whale");
  //makeSentenceList("../../../data/mobydick.txt", "ahab");
  //makePosList("../../../data/mobydick.txt", "the very brown rock");
  //makeStressList("../../../data/mobydick.txt", "unbelievable");
  makeQuestionList("../../../data/mobydick.txt");
 
}

void draw() {
  
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

void makePosList(String url, String pos) {
  String[] rows = loadStrings(url);
  String doc = join(rows, " ");
  //Split into sentences using RiTa
  String[] sentences = RiTa.splitSentences(doc);
 
  //Get the Pos string
  String match = join(RiTa.getPosTags(pos), " ");
  
  //Make a print writer
  PrintWriter writer = createWriter(match + ".txt");
  
  for (String s:sentences) {
    if(join(RiTa.getPosTags(s), " ").indexOf(match) != -1) writer.println(RiTa.stripPunctuation(s));
  }
  
  writer.flush();
  writer.close();
}

void makeQuestionList(String url) {
  String[] rows = loadStrings(url);
  String doc = join(rows, " ");
  //Split into sentences using RiTa
  String[] sentences = RiTa.splitSentences(doc);
  
  //Make a print writer
  PrintWriter writer = createWriter("questions.txt");
  
  for (String s:sentences) {
    if(RiTa.isW_Question(s) && s.indexOf("?") != -1) writer.println(s);
  }
  
  writer.flush();
  writer.close();
}

void makeStressList(String url, String stress) {
  String[] rows = loadStrings(url);
  String doc = join(rows, " ");
  //Split into sentences using RiTa
  String[] sentences = RiTa.splitSentences(doc);
 
  //Get the Pos string
  String match = RiTa.getStresses(stress);
  
  //Make a print writer
  PrintWriter writer = createWriter(stress + ".txt");
  
  for (String s:sentences) {
    String[] words = RiTa.tokenize(s);
    for (String w:words) {
     try {
       if (RiTa.getStresses(w).equals(match)) writer.println(w);
     } catch(Exception e) {
       
     }
    }
  }
  
  writer.flush();
  writer.close();
}


void makeSentenceList(String url, String w) {
  String[] rows = loadStrings(url);
  String doc = join(rows, " ");
  //Split into sentences using RiTa
  String[] sentences = RiTa.splitSentences(doc);
  
  //Make a print writer
  PrintWriter writer = createWriter(w + ".txt");
  
  for (String s:sentences) {
    if(s.toLowerCase().indexOf(w) != -1) writer.println(RiTa.stripPunctuation(s));
  }
  
  writer.flush();
  writer.close();
}

void doWordCount(String url) {
  
  //This is a counter for the words
  IntDict counter = new IntDict();
  
  String[] rows = loadStrings(url);
  String doc = join(rows, " ");
  //Split into sentences using RiTa
  String[] sentences = RiTa.splitSentences(doc);
  //Split each sentence into words
  for (String s:sentences) {
    String[] words = RiTa.tokenize(RiTa.stripPunctuation(s));
    for(String w:words) {
      if (checkStop(w.toLowerCase())) counter.add(w.toLowerCase(),1); 
    }
  }
  
  //Make a print writer
  PrintWriter writer = createWriter("count.txt");
  
  counter.sortValuesReverse();
  int c = 0;
  for(String k:counter.keys()) {
   if (c < 100) println(k + ":" + counter.get(k)); 
   writer.println(k + "," + counter.get(k));
   c++;
  }
  
  writer.flush();
  writer.close();
  
}




