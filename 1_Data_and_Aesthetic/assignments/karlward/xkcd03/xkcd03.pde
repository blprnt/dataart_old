import beads.*;

import java.util.Map;
import java.util.HashSet;

JSONObject xkcdRaw;
JSONArray comics;
HashMap<String, Word> wordMap;
//ArrayList<WordBar> wordBars;

void setup() {
  size(1280, 768, P3D);
  background(150);
  smooth();
  xkcdRaw = loadJSONObject("1-1325.json");
  comics = xkcdRaw.getJSONArray("comics");
  wordMap = loadWords();
  //wordBars = new ArrayList<WordBar>();
}

void draw() {
  //lights();

  int i = floor(millis() / 10);
  //println(i);
  if (i < comics.size()) {
    rotateZ(i * PI / 6 / comics.size());
    for (String s: parseComic(i)) {
      if (wordMap.containsKey(s)) {
        try {
          int x = wordMap.get(s).x;
          int w = 6;
          int h = wordMap.get(s).count;
          int d = 1;
          int y = s.length() * 2;
          int z = round(-2 * comics.size() + 2 * i);
          color c = wordMap.get(s).value;
          pushMatrix();
          translate(x*w, height/2, z);
          fill(c);
          box(w, h, d);
          //wordBars.add(new WordBar(s, x, y, z, w, h, d, c)); 
          text(s, w, y);
        }
        catch (Exception e) { 
          println(e);
          popMatrix();
        }
        finally {
          popMatrix();
        }
      }
    }
  }
  

}

class Word {
  int count = 0;
  color value;
  int x = 0;
  HashSet<Integer> in = new HashSet<Integer>();  // FIXME: size?
}

/*
class WordBar {
  String word;
  int x, y, z, w, h, d;
  color c;

  WordBar(String word, int x, int y, int z, int w, int h, int d, color c) {
    this.word = word;
    this.x = x;
    this.y = x;
    this.z = x;
    this.w = x;
    this.h = x;
    this.d = x;
    this.c = c;
  }

  void draw() {
    //unimplemented
  }
}
*/

HashSet<String> parseComic(int i) {
  HashSet<String> comicStrings = new HashSet<String>();
  String[] tokens = comics.getJSONObject(i).getString("transcript").split("\\s+");
  for (String t: tokens) {
    t = t.replaceAll("(^\\W+)|(\\W+$)", "");
    comicStrings.add(t);
  }
  return comicStrings;
}

HashMap loadWords() {
  HashMap<String, Word> w = new HashMap<String, Word>();
  for (int i = 0; i < comics.size()-2; i++) {
    if (comics.getJSONObject(i) != null) {
      String[] tokens = comics.getJSONObject(i).getString("transcript").split("\\s+");
      for (String t: tokens) {
        t = t.replaceAll("(^\\W+)|(\\W+$)", "");
        if (w.containsKey(t)) {
          w.get(t).in.add(i);
          w.get(t).count = w.get(t).count + 1;
        }
        else {
          Word tw = new Word();
          tw.x = i;
          tw.value = color(floor(random(255)), floor(random(255)), floor(random(255)));
          tw.count = 1;
          tw.in.add(i);
          w.put(t, tw);
        }
      }
    }
  }
  return w;
}

