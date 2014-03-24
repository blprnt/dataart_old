class Question {
  String sentenceQ;
  PVector pos= new PVector();
  //text width var
  float tWidth;
  int tw;

  boolean hover;


  int x=width/2;

  int y;

  Question(String qN) {
    sentenceQ = qN;
    hover = false;
  }

  void update() {
    tWidth=textWidth(sentenceQ);
    tw= int(tWidth);
    println(tw);

    if (mouseX >= x-tw/2 && mouseX <= x+tw/2 && mouseY >= y-30 && mouseY <= y+30) {
      hover = true;
    } 
    else {
      hover = false;
    }
  }

  //  void update(int x, int y) {
  //    tWidth=textWidth(sentenceQ);
  //    tw= int(tWidth);
  //    println(tw);
  //    
  //    if (overRect(x, y, tw, 40) ) {
  //      rectOver = true;
  //    } 
  //    else {
  //      rectOver = false;
  //    }
  //  }
  void render() {
    //    tw=textWidth(sentenceQ);

    //    println(tw);
    //    pushMatrix();
    //translate se usa por que "ellipse" no acepta PVectors como parametros
    //    translate(pos.x, pos.y);
    //    println(pos.y);

    if (hover) {
      fill(251, 211, 16);
      rect(x, y, tw, 40);
      fill(0);
      text(sentenceQ, x, y);
      fill(0, 30);
      //      rect(width/2, height-70, textWidth("A FILM BY QUENTIN TARANTINO"), 40);
      //      fill(255);
      textSize(20);
      text("A FILM BY QUENTIN TARANTINO", width/2, height-70);
    } 
    else {
      fill(251, 211, 16);
      rect(x, y, tw, 60);
      fill(251, 211, 16);
      text(sentenceQ, x, y);
      //      fill(0,30);
      //      rect(width/2, height-70, textWidth("A FILM BY QUENTIN TARANTINO"), 40);
      fill(0, 30);
      textSize(20);
      text("A FILM BY QUENTIN TARANTINO", 200, height-70);
    }


    //    popMatrix();
  }

  //  boolean overRect(int x, int y, int width, int height) {
  //    if (mouseX >= x && mouseX <= x+width && 
  //      mouseY >= y && mouseY <= y+height) {
  //      return true;
  //    } 
  //    else {
  //      return false;
  //    }
  //  }
}

