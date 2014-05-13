//Ju Young Park
//Data Art 2014
//Mar.10.2014

// An uneven surface

import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
PBox2D box2d;
IntDict words;
// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;
int c = 0;
// An object to store information about the uneven surface
Surface surface;

void setup() {
  size(1280,720);
  loadWords("names.txt");
  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -10);

  // Create the empty list
  particles = new ArrayList<Particle>();
  // Create the surface
  surface = new Surface();
  
  
}

void draw() {
  // If the mouse is pressed, we make new particles
  

  // We must always step through time!
  box2d.step();

  background(0);
  fill(255,219,251);
  textSize(46);
  text("2013", 620, 150);
  // Draw the surface
  surface.display();
  for (String w:words.keys()) {
    if (c < 100) {
      particles.add(new Particle(width/2,320,5, w, words.get(w)));
      
    } 
    c++;
    
  }
  // Draw all particles
  for (Particle p: particles) {
    p.display();
  }

  // Particles that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    if (p.done()) {
      particles.remove(i);
    }
  }
}


void loadWords(String url) {
  words = new IntDict();
  String[] rows = loadStrings(url);
  int c = 0;
  for (String row:rows) {
    String[] cols = split(row, ",");
    if(c < 100) words.add(cols[0], int(cols[1]));
    c++;
  }
}




