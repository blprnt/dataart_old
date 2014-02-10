class Cube {

  String text = " ";
  float x, y, z, w, h, depth;
  

  Cube() {
    x = width/2;
    y = height/2;
    z = 0;
    w = 60;
    h = 60;
    depth = 100;
  }


  Cube(float x_, float y_, float z_, float w_, float h_, float depth_) {
    x = x_;
    y = y_;
    z = z_;
    h = h_;
    w = w_;
    depth = depth_;
  }

  void setText(String text_) {
    text = text_;
  }

  void draw() {

    stroke(200);
    fill(0, 200);
    pushMatrix();
    translate(x, y, z-w);
    rotateY(radians(map(mouseX, 0, width, 0, 90)));
    //box(50, 50, map(mouseY, 0.25*height , 0.75*height, 0, 400));
    box(w, h, depth);
    stroke(255);
    fill(255);
    //rect(50, 50, 100, 100);

    fill(0);
    textLeading(12);
    text(text, -50, +45, 50);

    popMatrix();
  }

  void drawText() {
  }
}

