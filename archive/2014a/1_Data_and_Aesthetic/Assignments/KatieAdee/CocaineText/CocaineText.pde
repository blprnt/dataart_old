/*
NYT Article API Articles Mentioning Cocaine by Year
 This Sketch Writes a Text File of All Articles in Order
 2/23/14
 katieadee@gmail.com
 
 */

import java.io.*;
PrintWriter output ;
JSONObject myJSON;
void setup() {
  output = createWriter("articles.txt");
  size(200, 200);
  background(0);
  fill(255);
  stroke(255);
  textSize(5);
  textAlign(CENTER, CENTER);

  myJSON = loadJSONObject("cocaineParsed.json");
  JSONArray results = myJSON.getJSONArray("results");
  for (int i = 0; i < results.size(); i++) {
    JSONObject yearObject = results.getJSONObject(i);
    int year =  yearObject.getInt("year");
    output.print(" • " +year);
    JSONArray headlines = yearObject.getJSONArray("titles");
    if (headlines.size() >0) {
      for (int j =0; j<headlines.size(); j++) {
        String title = headlines.getString(j);
        output.print(" • " + title );
      }
    }
  }
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}

void draw() {
}




