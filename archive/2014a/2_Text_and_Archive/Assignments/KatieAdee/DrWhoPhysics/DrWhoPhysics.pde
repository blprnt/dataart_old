/* 
 3/10/14
 network based on cooccurence in a sentence
 visualization using toxiclibs
 */

import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
//import toxi.math.*;

import rita.*;
import rita.render.*;
import rita.support.*;
import rita.json.*;



VerletPhysics2D physics;
ArrayList<Particle> particles;
ArrayList<Spring> springs; 
ArrayList<Particle> connections;

Boolean IsParticleClicked;
Boolean IsParticleLocked;
Particle SelectedParticle;

String myText = "dalek";
String input = myText;
PFont font;

String[] corpii = {
  "dr01.txt", "dr02.txt"
};
int corpIndex = 0;

String query;

//what it labeled with (key), what it contains, both keys and valiues need to be capitalized objects, cant do int or float or boolean
HashMap <String, NetworkWord> wordmap = new HashMap();
HashMap<String, String> stopList = new HashMap();
ArrayList <NetworkWord> matchWords = new ArrayList();
ArrayList <NetworkWord> allWords = new ArrayList();
ArrayList <NetworkWord> displayWords;

boolean doSearch = false;

void setup() {
  size(1280, 720);
  physics = new VerletPhysics2D();
  physics.setDrag(0.05f);
  //physics.setWorldBounds(0, 0, width, height);
  physics.update();
  particles = new ArrayList<Particle>();
  springs = new ArrayList<Spring>();

  font = createFont("Sans Serif", 40);
  fill(255, 0, 0);
  textFont(font, 10);
  textAlign(LEFT, CENTER);

  makeStopList("../DATA/stop.txt");
  makeTextNetwork("../DATA/dr01.txt");
  //showTopWords(20);
  String test = "dalek";
  showFromWord(test, 15);
  for (NetworkWord nw:displayWords) {
    Particle p;
    p = new Particle(0, 0, 10, nw.word);
    particles.add(p);
    physics.addParticle(p);
    physics.addBehavior(new AttractionBehavior(p, 10, -1.0f, 0.01f));
  }
  println(allWords.size());
  arrangeWords();
}


void draw() {

  if (doSearch) {
    println(myText);
    displayWords = new ArrayList();
    particles = new ArrayList();
    println(myText.equals("space"));
    showFromWord(myText, 20);
    //showFromWord("space", 20);
    arrangeWords();
    for (NetworkWord nw:displayWords) {
      Particle p;
      p = new Particle(0, 0, 10, nw.word);
      nw.p = p;
      particles.add(p);
      physics.addParticle(p);
      physics.addBehavior(new AttractionBehavior(p, 10, -1.0f, 0.01f));
    }
    
    for (NetworkWord nw:displayWords) {
      nw.makeLinks();
    }
    
    
    myText = "";
    doSearch = false;
  }
  
  background(0);
  text(myText, 30, 0, width, height);
  text(input, 30, 50, width, height);
  translate(width/2, height/2);
  for (NetworkWord nw:displayWords) {
    nw.update();
    // nw.render();
    //nw.renderLinks();
  }

  for (Particle p:particles) {
    p.display();
    p.flicker();
  }
    for (Spring s:springs) {
    s.display();
    
  }
  physics.update();
}





void keyPressed() {
  if (keyCode == BACKSPACE) {
    if (myText.length() > 0) {
      myText = myText.substring(0, myText.length()-1);
    }
  } 
  else if (keyCode == DELETE) {
    myText = "";
  } 

  else if (keyCode != SHIFT && keyCode != ENTER) {
    myText = myText + key;
  }

  if (keyCode == ' ') {
    myText = myText.substring(0, myText.length()-1);
    myText = myText + '_';
  }


  if (keyCode == ENTER) {
    input = myText;
    //query = ""+input;

    doSearch = true;
  }

  if (keyCode == RIGHT) {
    nextCorpus();
  } 
  if (keyCode == LEFT) {
    prevCorpus();
  }
}

void addParticle() {

  int r;
  float len = 100;
  float radius =100;
  float thickness = 1;
  Particle newP = new Particle(0, 0, 5, "test");

  particles.add(newP);
  physics.addBehavior(new AttractionBehavior(newP, radius, -2.3f, 0.01f));
  physics.addParticle(newP);
}

//Get a particle based on coordinates
Particle GetParticleByCoordinate(int x, int y)
{
  Particle ParticleToReturn = new Particle(0, 0, 0, "test");
  for (int i = 0; i < particles.size(); i++) {
    Particle particle = (Particle) particles.get(i);
    if (particle.x == x && particle.y == y)
      ParticleToReturn = particle;
  }
  return ParticleToReturn;
}

