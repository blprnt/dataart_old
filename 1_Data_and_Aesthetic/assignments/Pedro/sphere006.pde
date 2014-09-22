import javax.media.opengl.*;
import processing.opengl.*;

//-------------------------------------------------------- Global Variables
float rotX, rotY = 0.0;
int fromYear = 1815;
int toYear = 2015;
boolean record = false;
PFont font;

// Data
DataLoader myData;

// GUI Elements
Sphere mySphere;
GUI myGUI;

//-------------------------------------------------------- setup();

void setup() {
  size(1280, 720, OPENGL);
  smooth(8);
  font = loadFont("KlavikaMedium-OSF-48.vlw");
  fill(0);
  stroke(150);
  
  myData = new DataLoader("epidemic_1815_2015.csv");
  mySphere = new Sphere(250);
  myGUI = new GUI();
  myGUI.currentYear = toYear-fromYear-1;

}

//-------------------------------------------------------- draw();

void draw() {
  
  background(222);
  screen();

}

//-------------------------------------------------------- draw screen elements;
void screen(){
  pushMatrix();
  //Change Main Axis
  mainAxis(width*0.5,height*0.5);
  //Draw Sphere
  mySphere.display();
  //Select random Year over time
  if(frameCount%600 == 0){
    myGUI.currentYear = floor( random( 0 , myData.getSize() ));
  }
  mySphere.select(myGUI.currentYear);
  
  popMatrix();
 
  //Draw GUI Elements
  myGUI.display();
  myGUI.curve();
}


//-------------------------------------------------------- Main Axis
void mainAxis(float x, float y){

  translate(x, y);
  rotY += 0.002;
  rotX = sin(TWO_PI*frameCount*0.0001);
  rotateX (rotX);
  rotateY (rotY);
  
}


