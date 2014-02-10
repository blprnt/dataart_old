/*
  Ju Young Park
  Feb 10 2014
  ITP NYU
*/
import processing.opengl.*;
int[] answers;
int[] colorValue = {
    #FFE78F,
    #FDDF87,
    #FBD77F,
    #F9D077,
    #F8C86F,
    #F6C167,
    #F4B95F,
    #F2B257,
    #F1AA4F,
    #EFA347,
    #ED9B3F,
    #ED9863,
    #EB9134,
    #E9892D,
    #E88225,
    #E67B1E,
    #E47416,
    #E36D0F,
    #E16607,
    #E05F00
    
};
boolean on = true;
void setup(){
  
  size(1280, 720, OPENGL);
  smooth(0);
  loadData();
  answers = sort(answers);

}


void draw(){
  background(0, 11, 49);
  stroke(255);
  line(0, height/2, 1631, height/2);
  drawLine(answers, colorValue);
  displayYears(answers);
}


void drawLine(int[] numbers, int[] list){
  for(int i=0; i<numbers.length; i++){
    int n = numbers[i];
    float x = 100; 
    float d = map(n, 0, max(numbers), 0, width-100);
    float y = height/2;
    //fill(#ff6600, 150);
    
    if(i == 0 || i == numbers.length-1){
      pushMatrix();
      noStroke();
      //fill(colorValue[i]);
      if(frameCount% 15 == 0) {
        if(on)
          fill(0);
        else
          fill(255);
        on = !on;
      }
      ellipse(d+50, y, 30, 30);
      popMatrix();
    } else{
      pushMatrix();
      noStroke();
      fill(colorValue[i]);
      ellipse(d+50, y, 10, 10);
      popMatrix();
    }

    
    //translate(300, 0);
    pushMatrix();
    noFill();
    //strokeWeight(1);
    stroke(colorValue[i], 150);
    translate(d/2, 0);
    arc(50, y, d, y, -PI, PI);
    popMatrix();
    
    pushMatrix();
    noStroke();
    fill(#FC3F19, 200);
    translate(d+50, y);
    ellipse(0, 0, 20, 20);
    popMatrix();
    
  }
}

void displayYears(int[] numbers){
  for(int i=0; i<numbers.length; i++){
    int year = 1994+i;
    String s = str(year);
    int n = numbers[i];
    float x = 100; 
    float d = map(n, 0, max(numbers), 0, width-100);
    float y = height/2;
    
    if(year == 1995){
      pushMatrix();
      textSize(14);
      fill(255);
      //rotate(radians(90));
      textAlign(CENTER, BOTTOM);
      translate(d+50, y+40);
      rotate(-HALF_PI);
      text(s, 0, 0);
      //textAlign(CENTER, BOTTOM);
      //rotate(0);
      popMatrix();
    } else if(year == 1996){
      pushMatrix();
      textSize(14);
      fill(255);
      //rotate(radians(90));
      textAlign(CENTER, BOTTOM);
      translate(d+58, y+40);
      rotate(-HALF_PI);
      text(s, 0, 0);
      //textAlign(CENTER, BOTTOM);
      //rotate(0);
      popMatrix();
    } else if(year == 1997){
      pushMatrix();
      textSize(14);
      fill(255);
      //rotate(radians(90));
      textAlign(CENTER, BOTTOM);
      translate(d+60, y+40);
      rotate(-HALF_PI);
      text(s, 0, 0);
      //textAlign(CENTER, BOTTOM);
      //rotate(0);
      popMatrix();
    }else{
      pushMatrix();
      textSize(14);
      fill(255);
      //rotate(radians(90));
      textAlign(CENTER, BOTTOM);
      translate(d+55, y+40);
      rotate(-HALF_PI);
      text(s, 0, 0);
      //textAlign(CENTER, BOTTOM);
      //rotate(0);
      popMatrix();
    }
    

  }
}
//void loadData(String url){ Table data = loadTable(url);
void loadData(){
  //Table data = loadTable("answers.csv", "header");
  Table data = loadTable("stemData.csv");
  
  answers = new int[data.getRowCount()];  
  
  for(int i =0; i<data.getRowCount(); i++){
    //get the second column of each row and put it in the array
    //answers[i] = data.getRow(i).getInt(1);
    answers[i] = data.getRow(i).getInt(0);
    
  }
}




