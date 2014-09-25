import java.util.*;

String dataFile = "riot4.csv";

Table table;
ArrayList<Item> items = new ArrayList<Item>();
float prices[], orders[];
int quantities[]; 
float lowest_price, highest_price;
float lowest_order, highest_order;
int lowest_quantity, highest_quantity;

float total_width, zoom = 1;

void setup() {
  size(1280, 720);
  loadData();
}

void draw() {
  background(255);
  float translatex = -1 * map(mouseX, 0, width, 0, total_width);
  translate(translatex * zoom, 0);
  scale(zoom, zoom);

  for (Item item : items) {
    item.run();
  }
}

void loadData() {
  table = loadTable(dataFile, "header");
  quantities = new int[table.getRowCount()];
  prices = new float[table.getRowCount()];
  orders = new float[table.getRowCount()];

  for (int i = 0; i < table.getRowCount (); i++) {
    //cap the data
    if (i < 100) {
      Item item = new Item(table.getRow(i));
      items.add(item);
      total_width += item.w;

      quantities[i] = item.quantity;
      orders[i] = item.min_order;
      prices[i] = item.max_price_per_unit;
    }
  }

  lowest_price = min(prices);
  highest_price = max(prices);
  lowest_quantity = min(quantities);
  highest_quantity = max(quantities);
  lowest_order = min(orders);
  highest_order = max(orders);

  Collections.sort(items, new Comparator<Item>() {
    @Override
      public int compare(Item  item1, Item  item2) {
        
        //uncomment to change the order
        
        //lowest to highest price
        return  int(item2.min_order - item1.min_order);
        
        //highest to lowest price
        //return  int(item1.min_order - item2.min_order);
        
        //minimum quantity
        //return  int(item2.quantity - item1.quantity);
    }
  }
  );
}

void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  zoom += e;
  zoom = constrain(zoom, 1, 20);
}

void keyReleased() {
  if (keyCode == 32) saveFrame();
}
