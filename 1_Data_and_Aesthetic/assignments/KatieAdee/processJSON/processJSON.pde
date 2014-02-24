/*

NYT API Parse JSON for Headlines
This sketch takes the json returned from a NYT APIT V2 query and 
pulls out the year, number of articles per year, and the titles of the articles and 
writes a smaller cleaner JSON file
2/20/14
katieadee@gmail.com

*/

import java.io.*;
PrintWriter output ;
JSONObject myJSON;
//easier than grabbing year out of datetime,  increment it by one after getting all articles for each year
int year = 1900;

void setup() {
  // create a output file and write to it
  output = createWriter("cocaineParsed.json");  
  output.print("{\"results\": [\n");
  
  
  //load the JSON file, I am using cocaine.json retreived by Rodrigo
  myJSON = loadJSONObject("cocaine.json");
  //get the years array
  JSONArray years = myJSON.getJSONArray("years");
  //loop through each year
  for (int i = 0; i < years.size(); i++) {
    JSONObject yearObject = years.getJSONObject(i);
    //get the articles and count them
    JSONArray docs = yearObject.getJSONArray("docs");
    output.print("{ \n");
    output.print("\"year\": " + year + ", \n");
    int count =  docs.size();
    output.print("\"count\": " + count + ", \n");
    output.print("\"titles\":  [ \n");
     if (count == 0){
        output.print ("] \n");
      }
    for(int j = 0; j <docs.size(); j++){
      JSONObject article = docs.getJSONObject(j);
      JSONObject headline = article.getJSONObject("headline");
      String title = headline.getString("main");
      //A lot of the titles had quotes in them, so we have to frind and replace 
      title = title.replaceAll("\"", "'");
      
      if (j < docs.size()-1){
        output.print("\"" +title+"\" , " );   
      }else{
        output.print("\"" +title+"\" ] \n" );
      }
    }
    if ( i < years.size()-1 ){
      output.print(" },");
    } else{
      output.print(" }");
    }
    year++;
  }  
  output.print(" ] \n }");
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}



void draw() {
}

