class Stripe {

  float w, h;
  float x, y;

  color bg;
  color lifecolor;
  color events;

  float lifestart = 0;
  String text;

  float[] data;

  Stripe() {
    x = width/2;
    y = height/2;
    w = 100;
    h = 20;

    bg = color(200);
    lifecolor = color(10);
    events = color(0, 255, 255);

    stripeh = h*6;

    data = generateRandomData();
  }

  Stripe(float x_, float y_, float w_, float h_) {

    x = x_;
    y = y_;
    w = w_;
    h = h_;

    bg = color(200);
    lifecolor = color(10);
    events = color(0, 255, 255);

    stripeh = h*6;

    data = generateRandomData();
  }

  void setLifeStart(float ls) {
    lifestart = ls;
  }

  void setText(String txt) {
    text = txt;
  }

  void drawEvent( float start, float w1 ) {

    float xpos = x + start;

    fill(events);

    rect(xpos, y, w1, h);
  }

  void drawLife(float start) {

    float xpos = x + start;
    float w1 = w - start;

    fill(lifecolor);

    rect(xpos, y+ 4*h - h, w1, h);
  }

  void drawLife() {

    drawLife(lifestart);
  }

  void drawText(String txt) {

    //    fill(20);
    //    rect(x-10, y-45, w, h*3);

    //fill(255);
    noFill();
    stroke(100);
    strokeWeight(0.5);
    rect(x, y-40, w, stripeh);

    fill(100);
    stroke(0);
    text(txt, x+2, y-28);
  }

  void drawText() {

    drawText(text);
  }

  void draw() {
    noStroke();
    fill(bg);
    rect(x, y+ 4*h - h, w, h);

    drawLife();
    drawGraph(data);
    //drawEvent(50, 10);
  }

  void drawAt0() {
    noStroke();
    fill(bg);
    rect(0, 0, w, h);

    //drawLife(30);
    //drawEvent(50, 10);
  }

  void zoomIn() {

    if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
      //zoomedIn = true;

      pushMatrix();
      translate(x, y);
      scale(2);
      draw();
      popMatrix();
    }
  }

  boolean inBoundaries() {
    if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) return true;
    else return false;
  }

  void drawGraph(float[] values) {

    for (int i = 0; i < values.length; i++) {
      float x_ = map(i, 0, values.length, x+lifestart, x+w);
      float h_ = -map(values[i], 0, max(values), 0, 4*h - h);

      if (x_ < lifestart) continue;
      else {

        noStroke();
        fill(200, 255);
        rect(x_, y + 4*h - h, 1, h_);
      }
    }
  }

  float[] generateRandomData() {
    float[] data_ = new float[2014 - 1900];
    int index = 0;
    for (int i = 1900; i<=2013; i++) {
      float datum = random(0, 500);
      float[] datums = {datum, 0, 0};
      int randomindex = int(random(0, datums.length));
      datum = datums[randomindex];
      data_[index] = datum;
      index++;
    }

    return data_;
  }

  // void setRandomData(){
  //  data = generateRandomData(); 
  // }
}

