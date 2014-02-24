// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// An XML object
XML headlines;
int counter;   // Where are we in the text (start later b/c Project Gutenberg has licensing info at beginning)

void setup() {
  size(1000, 500);
  background(0);

  // Call function that loads the XML
  loadData();

  // Find all the children marked "item"
  XML[] children = headlines.getChild("channel").getChildren("item");

  // Loop through them all and get each "title"
  for (int i = 0; i < children.length; i++) {
    String headline = children[i].getChild("title").getContent();
    String[] list = split(headline, " ");

    // Draw each title as a String
    fill(200, 200, random(255));
    //text(headline, 10, 16+i*16);
    for (int j = 0; j < list.length; j++) {
      text(list[j], random(width), random(height));
    }
  }
}

void draw() {
}

void loadData() {
  headlines = loadXML("http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml" );
}

// Reload the headlines by clicking the mouse
void mousePressed() {
  loadData();
}

