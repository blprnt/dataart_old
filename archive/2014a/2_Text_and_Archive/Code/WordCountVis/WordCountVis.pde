IntDict words;

void setup() {
  size(1280, 720);
  loadWords("count.txt");
}

void draw() {
  background(255);
  fill(0);
  int x = 50;
  translate(map(mouseX, 0, width, 0, 500), 300);
  int c = 0;
  for (String w:words.keys()) {
    if (c < 100) {
      textSize(words.get(w) * 0.1);
      text(w, 0, 0);
      translate(textWidth(w), 0);
      rotate(map(mouseX, 0, width, 0, 1));
    }
    c++;
  }
}

void loadWords(String url) {
  words = new IntDict();
  String[] rows = loadStrings(url);
  int c = 0;
  for (String row:rows) {
    String[] cols = split(row, ",");
    if(c < 1000) words.add(cols[0], int(cols[1]));
    c++;
  }
}

