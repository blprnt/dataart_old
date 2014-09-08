class WordObject {
  String word;
  int count;
  int conn_info; //short for connection_to_info;
  
  float xPos;
  float yPos;
  
  WordObject(String w, int c, int conn) {
    word = w;
    count = c;
    conn_info = conn;
  }
}
