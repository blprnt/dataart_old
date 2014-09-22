class Item {
  String name, units, image_url;
  float min_price, max_price, max_price_per_unit, min_order, w, h;
  int quantity;
  PVector loc = new PVector();
  PImage img;

  float c;

  Item(TableRow row) {
    name = row.getString(0);
    min_price = row.getFloat(1);
    max_price = row.getFloat(2);
    quantity = row.getInt(3);
    units = row.getString(4);
    max_price_per_unit = row.getFloat(5);
    min_order = quantity * max_price;

    String img_url = row.getString(9);
    if (img_url != null) {
      img = loadImage("../images/" + img_url);
    }

    if (img != null) {
      h = float(height) / float(quantity);
      w = (h/img.height) * img.width;
    }
  }

  void display() {

    fill(255);
    for (int i = 0; i < quantity; i++) {
      if (img != null) {
        image(img, 0, i * h, w, h);
      } else {
        rect(0, i*h, w, h);
      }
    }

    translate(w, 0);
  }

  void run() {
    display();
  }
}

