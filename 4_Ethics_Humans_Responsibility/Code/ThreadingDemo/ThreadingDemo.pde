void setup() {
  size(1280,720);
  background(0);
  
  SimplestThread testThread = new SimplestThread("test");
  testThread.start();
}

void draw() {
  
}
