/* Second Assignment for Data Art Course with Jer Thorp, March 2014.
 by rafagrossbrown@gmail.com
 rafagb.com
 */

import rita.render.*;
import rita.json.*;
import rita.support.*;
import rita.*;

ArrayList<Question> displayKillBill= new ArrayList();
ArrayList<Question> displayPulpFiction= new ArrayList();
ArrayList<Question> displayDjango= new ArrayList();

HashMap<String, String> stopList= new HashMap();

PFont swiss911;

boolean rectOver = false;

color red=color(197, 44, 17);
void setup() {
  size(1280, 893);
  background(red);
  smooth(6);
  noStroke();

  swiss911 = createFont("swiss911-ucm-bt", 40);
  textFont(swiss911);
  textAlign(CENTER, CENTER);

  rectMode(CENTER); 

  makeStopList("stop.txt");
  //load questions
  makeQuestionList("questionsPulp.txt");
}

void draw() {
  //draw each question
  //  translate((width/2)-100, (height/2)-500);
  for (Question qN:displayKillBill) {
    qN.update();
    //   println(qN.sentenceQ);
    qN.render();
  }
}

void makeQuestionList(String url) {
  String[] rows= loadStrings (url);
  String doc= join(rows, " ");
  String[] questions= RiTa.splitSentences(doc);
  processQuestions(questions);
}

void processQuestions(String[] qq) {
  //Take out stopList words
  ArrayList<String> goodWords = new ArrayList();
  for (String q:qq) {
    if (checkStop(q)) goodWords.add(q);

    for (String q2:goodWords) {
      //println(q2+"end");
      Question qN= new Question(q2);  
      displayKillBill.add(qN);
    }
  }
  for (int i =0;i< displayKillBill.size();i++) {
    Question qN=displayKillBill.get(i);
    qN.y= i*70;
  }
}
//
//void arrangeQuestions() {
//  for (int i =0;i< displayKillBill.size();i++) {
//
//    Question qN=displayKillBill.get(i);
//    qN.pos.x= i*5;
//  }
//}

void makeStopList(String url) {
  String[] rows= loadStrings(url);
  for (String qq:rows) {
    //add to hash map stop list to then checkStop()
    stopList.put(qq, qq);
  }
}

boolean checkStop(String qq) {
  return(!stopList.containsKey(qq));
}

