/*
147 years of Space Exploration.
----
This is a typographic visualization of the occurrences of the term "Space Exploration" in 
the New York Times since 1868.
---
Sagar Mohite. 2014.
*/

import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;

RFont f;
RShape grp, grp2;
RPoint[] points;
String iss[];
PFont hnl, al;
PImage bg;
float factor = 2;
  
void setup(){
  size(1300,544);
  frameRate(24);

  background(11);
  fill(255,102,0);
  stroke(0);
  
  RG.init(this);
  
  grp = RG.getText("SPACE", "helveticaneue.ttf", 75, CENTER);
  hnl = loadFont("hnl.vlw");
  al = loadFont("al.vlw");
  bg = loadImage("bg.jpg");
  
  iss = loadStrings("space.txt");

  smooth();
}


void draw(){

  background(bg);
  
  pushMatrix();
  translate(width/2, 3*height/4);
  
  noFill();
  stroke(255);

//  RG.setPolygonizer(RG.ADAPTATIVE);
//  grp.draw();
  
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(4.5);
  points = grp.getPoints(); //get points on the glyphs of the typeface

  if(points != null){
    noFill();
    beginShape(LINES);
    println(points.length);
    float[] spacex = new float[iss.length];
    for (int i=0; i<iss.length; i++)
      spacex[i] = parseFloat(iss[i]);
    for(int i=0, j=0; i<spacex.length && j<points.length; i++, j+=2){
        float g = map(spacex[i], min(spacex), max(spacex), 0, 255);
        stroke(242, g, 53);
        vertex(points[j].x, points[j].y);
        vertex(points[j].x , -map(spacex[i], min(spacex), max(spacex), 7, 210) );
    }
    endShape();
  }
  
  popMatrix();
  
  stroke(242,0,53);
  line(0,3*height/4-20,width/2-120, 3*height/4-20);
  stroke(242,255,53);
  line(width/2+125,3*height/4-20,width, 3*height/4-20);
  
  fill(255);
  textSize(2);
  textFont(al);
  text("147 years of Space Exploration on NYTimes.", width/2-130, height-30);
  translate(width/2, 3*height/4+30);
  textFont(hnl);
  textSize(25);
  text("EXPLORATION",-95,0);
}
