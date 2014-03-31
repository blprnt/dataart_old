void nextCorpus() {
  corpIndex ++;
  if (corpIndex > corpii.length) corpIndex -= corpii.length;
  corpIndex = corpIndex % corpii.length;
  //activeTokens = new ArrayList();
  //tokenMap = new HashMap();
  makeTextNetwork(corpii[corpIndex]);
  
}

void prevCorpus() {
  corpIndex --;
  if (corpIndex < 0) corpIndex += corpii.length;
  //activeTokens = new ArrayList();
  //tokenMap = new HashMap();
  makeTextNetwork(corpii[corpIndex]);
}


void showFromWord(String s, int num) {
  matchWords = new ArrayList();
  println(s);
  for (String w:wordmap.get(s).linkMap.keys()) {
    if(wordmap.get(s).linkMap.get(w) >2){
    matchWords.add(wordmap.get(w));
    }
  }
  displayWords = new ArrayList();
  if (num > matchWords.size()) num = matchWords.size()-1;
  for (int i =0; i < num; i++) {
    displayWords.add(matchWords.get(i));
  }
}



void showTopWords(int num) {
  displayWords = new ArrayList();
  for (int i =0; i < num; i++) {
    displayWords.add(allWords.get(i));
  }
}

void arrangeWords() {
  for (int i = 0; i < displayWords.size(); i++) {
    NetworkWord nw = displayWords.get(i);
    float theta = map(i, 0, displayWords.size(), 0, TAU);
    float rad = 300;
    nw.rot = theta;
    nw.pos.x = cos(theta)*rad;
    nw.pos.y = sin(theta)*rad;
  }
}

void makeTextNetwork(String url) {
  //join whole body of text
  String doc = join(loadStrings(url), " ");
  //split into sentences
  String[] sentences = RiTa.splitSentences(doc);
  //println(sentences.length);
  //tokenize
  for (String s :sentences) {
    String[] words = RiTa.tokenize(s);
    processWords(words);
  }
}

void processWords(String[] words) {
  // remove stop list words 
  ArrayList <String>  goodWords = new ArrayList();
  for (String w:words) {
    w=RiTa.stripPunctuation(w.toLowerCase());
    if (checkStop(trim(w))&&w.length()>2 ) goodWords.add(w);
  }
  //1. make new network words where necessary, update counts
  //for each new word we see create an object, object keeps track of how many times its been used
  for (String w : goodWords) {
    w = RiTa.stripPunctuation(w).toLowerCase();
    //have we seen this word before?
    if (wordmap.containsKey(w)) {
      //word is already in hashmap
      NetworkWord nw = wordmap.get(w);
      nw.count++;
    }
    else {
      //word is new, not already in hash map
      NetworkWord nw = new NetworkWord();
      nw.word = w;
      nw.count = 1;
      //put it in hashmap //word:wordobject
      wordmap.put(w, nw);
      allWords.add(nw);
    }
  }

  //2.Make the network connections
  for (String w:goodWords) {
    //pick each words
    w = RiTa.stripPunctuation(w).toLowerCase();
    NetworkWord startWord = wordmap.get(w);
    //link it to every other word
    for (String w2:goodWords) {
      w2 = RiTa.stripPunctuation(w2).toLowerCase();
      NetworkWord endWord = wordmap.get(w2);
      linkWords(startWord, endWord);
    }
  }
}

void linkWords(NetworkWord w1, NetworkWord w2) {
  if (w1 != w2) {
    w1.linkMap.add(w2.word, 1);
  }
}

void makeStopList(String url) {
  String [] rows = loadStrings(url);
  for (String s : rows) {
    stopList.put(s, s);
  }
}

boolean checkStop(String w) {
  //return true if its not in the stop list
  return(!stopList.containsKey(w));
}
