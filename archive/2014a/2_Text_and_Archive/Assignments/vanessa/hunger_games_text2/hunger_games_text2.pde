//Data Art - ITP NYU 2014
//Text/Archive Assignment
//Vanessa Joho
//vanessajoho@gmail.com
//www.vanessajoho.com

IntDict words;
float i=0;
float x, y;
void setup() {                            
  size(550, 800);
  loadWords("count.txt");
  x = x + 2;
}

void draw() {
  background(0);
  y = y + 0.01;

  if (y > height) {
    y=0;
  }
  for (String w:words.keys()) {
    textSize(words.get(w) * 0.5);
    if (words.get(w) >= 0 && words.get(w) < 60) {
      fill(233, 229, 178, 40);
    }
    else if (words.get(w) >= 60 && words.get(w) < 120) {
      fill(155, 197, 133, 80);
    }
    else if (words.get(w) >= 120 && words.get(w) < 180) {
      fill(60, 142, 119, 120);
    }
    else if (words.get(w) >= 180 && words.get(w) < 240) {
      fill(26, 93, 101, 160);
    }
    else {
      fill(29, 46, 76, 200);
    }

    translate(x, y);
    text(w, 0, 100);


    //println(textWidth(w)*y);
  }
}

void loadWords(String url) {
  words = new IntDict();
  String[] rows = loadStrings(url);
  for (String row:rows) {
    String[] cols = split(row, ",");
    words.add(cols[0], int (cols[1]));
  }
}

