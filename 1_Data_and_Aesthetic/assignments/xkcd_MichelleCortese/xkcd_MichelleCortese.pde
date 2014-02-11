import java.util.Map;
import java.util.HashSet;

JSONObject xkcdRaw;
JSONArray comics;
HashMap<String, Word> wordMap;
PFont xkcdScript;
int i = 0;

void setup() {
  size(1240,750,P2D);
  background(255);
  smooth(8);
  xkcdRaw = loadJSONObject("1-1325.json");
  comics = xkcdRaw.getJSONArray("comics");
  wordMap = loadWords();
  xkcdScript  = loadFont("HumorSans-48.vlw");
}

void draw() {
  struct(255,1);
  drawStrip();
}

void drawStrip(){
    fill(255,255,204,10);
  rect(0,0,1240,750);
  if (i < comics.size()) {
    for (String s: parseComic(i)) {
      if (wordMap.containsKey(s)) {
          int x = wordMap.get(s).x;
          int w = int(random(0, 1240));
          int h = int(map(wordMap.get(s).count,0,550,0,750));
          int y = s.length() * 2;
          color c = wordMap.get(s).value;
          noStroke();
          fill(c,20);
          rect(w-20,h,100,100);
          fill(c);
          textFont(xkcdScript,8);
          text(s, w, h);
          fill(0,200);
          textFont(xkcdScript,48);
          text("xkcd word occurence",365,628);
      }
    }
  }
}

void struct(int stroke, int point){
  int strokeTemp = stroke;
  int pointTemp = point;
  stroke(stroke,10);
  strokeWeight(point);
  for(int i=0; i<1240; i=i+20){
    line(0,i,1240,i);
    line(i,0,i,750);
  }
}

class Word {
  int count = 0;
  color value;
  int x = 0;
  HashSet<Integer> in = new HashSet<Integer>();  // FIXME: size?
}

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

