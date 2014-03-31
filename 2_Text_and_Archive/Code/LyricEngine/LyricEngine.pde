import rita.render.*;
import rita.json.*;
import rita.support.*;
import rita.*;

HashMap<String, String> stopList = new HashMap();
String doc;
String[] sentences;
String[] posArray;
String[] stressArray;
String[] countArray;

ArrayList<WordToken> activeTokens = new ArrayList();
ArrayList<WordToken> newTokens = new ArrayList();
HashMap<String, String> tokenMap = new HashMap();

float tol = 0.1;

ArrayList<String> out = new ArrayList();

String dataPath = "../../../data/lyrics/";
String dl = "|~~|";

String currentText = "";
float cursorPos = 0;

float xoff = 0;
float txoff = 0;

float yoff = 0;
float tyoff = 0;

int keyCount = 0;
int keyTarget = 100;

PFont labelText;

String[] corpii = {
  "bible", "shakes", "mobydick", "bieber"
};
int corpIndex = 0;

void setup() {
  size(displayWidth, displayHeight, P3D);

  labelText = createFont("ChunkFive", 36);
  textFont(labelText);


  loadCorpus(corpii[corpIndex]);
}

void nextCorpus() {
  corpIndex ++;
  if (corpIndex > corpii.length) corpIndex -= corpii.length;
  corpIndex = corpIndex % corpii.length;
  activeTokens = new ArrayList();
  tokenMap = new HashMap();
  loadCorpus(corpii[corpIndex]);
}

void prevCorpus() {
  corpIndex --;
  if (corpIndex < 0) corpIndex += corpii.length;
  activeTokens = new ArrayList();
  tokenMap = new HashMap();
  loadCorpus(corpii[corpIndex]);
}

void processCorpus(String url) {
  //Make word count doc
  IntDict wc = doWordCount(dataPath + url + ".txt");

  //Fetch the unprocessed corpus
  String[] rows = loadStrings(dataPath + url + ".txt");
  //Make the outgoing array


  String[] out = new String[rows.length];
  for (int i = 0; i < rows.length; i++) {
    //println(i);
    String row = rows[i];
    //Parts of Speech
    String pos = join(RiTa.getPosTags(row), " ");
    //Stresses
    String stress = "";
    try {
      stress = RiTa.getStresses(row);
    } 
    catch (Exception e) {
      println("FAILED on " + row);
    }
    //Word counts
    String[] words = RiTa.tokenize(row);
    String[] counts = new String[words.length];
    for (int j = 0; j < words.length; j++) {
      int c = wc.get(RiTa.stripPunctuation(words[j]).toLowerCase()); 
      counts[j] = str(c);
    }
    String countList = join(counts, " ");

    out[i] = row + dl + pos + dl + stress + dl + countList;
  }


  //Save
  saveStrings(dataPath + url + "_processed.txt", out);
}

void loadCorpus(String url) {
  String[] rows = loadStrings(dataPath + url + "_processed.txt");
  sentences = new String[rows.length];
  posArray = new String[rows.length];
  stressArray = new String[rows.length];
  countArray = new String[rows.length];

  for (int i = 0; i < rows.length; i++) {
    String row = rows[i];
    String[] cols = split(row, dl);
    sentences[i] = cols[0];
    posArray[i] = cols[1];
    stressArray[i] = cols[2];
    countArray[i] = cols[3];
  };
}

void pickText() {
  ArrayList<WordToken> tokens = getPosMatch(currentText);
  java.util.Collections.sort(tokens);
  java.util.Collections.reverse(tokens);
  int c = 0;
  int max = 18;
  for (WordToken wt:tokens) {
    if (c < max) dropToken(wt);
    println(wt.word);
    c++;
  }
  arrangeTokens();
}

void dropToken(WordToken wt) {
  if (!tokenMap.containsKey(wt.word)) {
    newTokens.add(wt); 
    tokenMap.put(wt.word, wt.word);
  }
}

void arrangeTokens() {
  for (int i = 0; i < newTokens.size(); i++) {
    WordToken wt = newTokens.get(i);
    //float th = map(i, 0, activeTokens.size(),0, TAU);
    //float rad = 100;
    wt.tpos.set(0, 60 + (i * 24));
    activeTokens.add(wt);
  }
  tyoff = -newTokens.size() * 12;
  newTokens = new ArrayList();
}

void draw() {

  xoff = lerp(xoff, txoff, 0.1);
  yoff = lerp(yoff, tyoff, 0.1);

  background(0);

  textSize(18);
  fill(255, 100, 0);
  text(corpii[corpIndex], 50, 50);

  textSize(36);

  int c = 0;
  pushMatrix();
  translate(width/2 + xoff, height/2 + yoff);
  fill(255, 255, 0);
  text(currentText, 0, 30);
  cursorPos = textWidth(currentText);
  translate(cursorPos + 5, 0);

  float ca = map(frameCount % 50, 0, 50, 0, TAU);
  fill(255, 255 * ((sin(ca) + 1) * 0.5));
  rect(0, 0, 5, 36);
  popMatrix();

  if (currentText.length() == 0 && activeTokens.size() > 0) {
    activeTokens = new ArrayList();
    tokenMap = new HashMap();
    tyoff = 0;
  }

  translate(width/2 + xoff, height/2 + yoff);
  for (WordToken wt:activeTokens) {
    wt.update();
    wt.render();
  }

  txoff = -cursorPos * 0.5;

  if (keyCount < keyTarget) {
    keyCount ++;
    if (keyCount == keyTarget && currentText.length() > 0 ) pickText();
  }
}

void convertLyrics(String token, String url) {
  /*
  String[] original = loadStrings(dataPath + url);
   String[] newsong = new String[original.length];
   for (int i = 0; i < original.length; i++) {
   String n1 = getPosMatch(original[i]);
   String n2 = getPosMatch(original[i]);
   String n3 = getPosMatch(original[i]);
   newsong[i] = (n1.length() == 0) ? original[i]:(n1 + "/" + n2 + "/" + n3);
   }
   saveStrings(dataPath + token + "_" + url, newsong);
   */
}

void makeStopList(String url) {
  String[] rows = loadStrings(url);
  for (String s:rows) {
    stopList.put(s, s);
  }
}

boolean checkStop(String w) {
  return(!stopList.containsKey(w));
}

ArrayList<WordToken> getPosMatch(String pos) {

  ArrayList<WordToken> tokens = new ArrayList();

  //Get the Pos string
  String[] matchList = RiTa.getPosTags(pos);
  String match = join(matchList, " ");
  String stress = RiTa.getStresses(pos);

  int syllables = 0;
  String[] sswords = pos.split(" ");
  for (String w:sswords) {
    syllables += w.split("/").length;
  }

  boolean isQ = RiTa.isQuestion(pos);

  //Find candidate string that match the POS somewhere
  ArrayList<String[]> candidates = new ArrayList();

  for (int i = 0; i < sentences.length; i++) {
    String s = sentences[i];
    String p = posArray[i];
    if (p.indexOf(match) != -1) {
      String[] sa = {
        s, p, stressArray[i], countArray[i]
      };
      candidates.add(sa);
    }
  }

  //Get the pieces
  HashMap<String, String> wordMap = new HashMap();
  ArrayList<String> returnSegments = new ArrayList();
  for (String[] s:candidates) {
    String ss = RiTa.stripPunctuation(s[0]);
    String[] words = RiTa.tokenize(s[0]);
    String[] spos = s[1].split(" ");
    String[] stressa = s[2].split(" ");
    String[] counta = s[3].split(" ");

    for (int i = 0; i < words.length - matchList.length + 1; i++) {
      String sss = join(java.util.Arrays.copyOfRange(spos, i, i + matchList.length), " ");

      int posdist = computeEditDistance(sss, match);
      float posfdist = (float) posdist / sss.length();

      if (posfdist < tol && stressa.length >= words.length) {

        String seg = join(java.util.Arrays.copyOfRange(words, i, i + matchList.length), " ");

        String sstress = join(java.util.Arrays.copyOfRange(stressa, i, i + matchList.length), " ");
        boolean sisQ = RiTa.isQuestion(s[0]);

        String scounts = join(java.util.Arrays.copyOfRange(counta, i, i + matchList.length), " ");
        String[] clist = scounts.split(" ");
        int scoreCount = 0;
        for (String c:clist) {
          scoreCount += int(c);
        }

        int ssyllables = 0;
        String[] swords = seg.split(" ");
        for (String w:swords) {
          ssyllables += w.split("/").length;
        }

        int dist = computeEditDistance(stress, sstress);
        float stol = (float) dist/stress.length();

        if ((stol < tol || stress.length() == sstress.length()) && !wordMap.containsKey(seg)) {
          tokens.add(new WordToken(seg, pos, scoreCount));
          wordMap.put(seg, seg);
        }
      };
    }
  }

  return(tokens);
}



IntDict doWordCount(String url) {

  //This is a counter for the words
  IntDict counter = new IntDict();

  String[] rows = loadStrings(url);
  String doc = join(rows, " ");
  //Split into sentences using RiTa
  String[] sentences = RiTa.splitSentences(doc);
  //Split each sentence into words
  for (String s:sentences) {
    String[] words = RiTa.tokenize(RiTa.stripPunctuation(s));
    for (String w:words) {
      if (checkStop(w.toLowerCase())) counter.add(w.toLowerCase(), 1);
    }
  }

  /*
  //Make a print writer
   PrintWriter writer = createWriter("count.txt");
   
   counter.sortValuesReverse();
   int c = 0;
   for (String k:counter.keys()) {
   if (c < 100) println(k + ":" + counter.get(k)); 
   writer.println(k + "," + counter.get(k));
   c++;
   }
   
   
   writer.flush();
   writer.close();
   
   */

  return(counter);
}

int computeEditDistance(String s1, String s2) {
  s1 = s1.toLowerCase();
  s2 = s2.toLowerCase();

  int[] costs = new int[s2.length() + 1];
  for (int i = 0; i <= s1.length(); i++) {
    int lastValue = i;
    for (int j = 0; j <= s2.length(); j++) {
      if (i == 0)
        costs[j] = j;
      else {
        if (j > 0) {
          int newValue = costs[j - 1];
          if (s1.charAt(i - 1) != s2.charAt(j - 1))
            newValue = Math.min(Math.min(newValue, lastValue), 
            costs[j]) + 1;
          costs[j - 1] = lastValue;
          lastValue = newValue;
        }
      }
    }
    if (i > 0)
      costs[s2.length()] = lastValue;
  }
  return costs[s2.length()];
}

void keyPressed() {
  keyCount = 0;
  if (keyCode == 8) {
    if (currentText.length() > 0) currentText = currentText.substring(0, currentText.length() - 1);
  } 
  else if (keyCode == RIGHT) {
    nextCorpus();
  } 
  else if (keyCode == LEFT) {
    prevCorpus();
  }
  else {
    currentText += key;
  }
}

class WordToken implements Comparable {

  String word;
  String match;
  int score; 

  PVector pos = new PVector();
  PVector tpos = new PVector();

  PVector rot = new PVector();
  PVector trot = new PVector();

  float a = 0.1;
  float ta = 1;

  WordToken(String w, String m, int s) {
    word = w;
    score = s;
    match = m;
  }

  int compareTo(Object o) {
    return(score - ((WordToken) o).score);
  }

  void update() {
    pos.lerp(tpos, 0.1);
    rot.lerp(trot, 0.1);
    a = lerp(a, ta, 0.1);
    ta = match.equals(currentText) ? 1:0;
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    textSize(18);
    fill(255, a * 255);
    text(word, 0, 0);
    popMatrix();
  }
}

