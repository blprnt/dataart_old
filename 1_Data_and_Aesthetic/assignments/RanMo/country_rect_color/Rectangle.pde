class Rectangle {

  float x, y, rect_width, rect_height, density;
  String country;



  Rectangle(float _x, float _y, float _rect_width, float _rect_height, String _country, float _density) {
    x = _x;
    y = _y;
    rect_width = _rect_width;
    rect_height = _rect_height;
    country = _country;
    density = _density;
  } 



  void rect_draw() {
    
    //color c1 = color(0, 100, 100);

    if (density > 300 && density < 900) {
      
      color clr = color(255, 0, 0);
      fill(clr); 
      strokeWeight(5);
      rect(x, y, rect_width, rect_height);
    }

    if (density > 100 && density < 300) {
      
      color clr = color(255, 255, 0);
      fill(clr); 
      strokeWeight(5);
      rect(x, y, rect_width, rect_height);
    }

    if (density > 20 && density < 100) {
      
      color clr = color(0, 100, 0);
      fill(clr); 
      strokeWeight(5);
      rect(x, y, rect_width, rect_height);
    }

    if (density < 20) {
      
      color clr = color(0, 0, 255);
      fill(clr); 
      strokeWeight(5);
      rect(x, y, rect_width, rect_height);
    }

    fill(200, 5, 5);
    //text(country, x+(rect_width/2), y + (rect_height/2));
  }
}

