import rita.*;
import rita.support.TextNode;

RiMarkov markov;
PImage tablet;

void setup()
{    
  size(560, 800);
 tablet = loadImage("tablet.jpg");

  //create a markov model w' n=3
  markov = new RiMarkov(this, 3);

  //load files into the model
  markov.loadFrom(new String[] {
    "immigrationAct1798.txt", 
    "pageImmigrationAct1875.txt", 
    "ChineseExclusionAct1882.txt", 
    "gearyImmigrationAct1892.txt", 
    "illegalImmigration1996.txt", 
    "enhancedBorderSecurity2002.txt", 
    "realID.txt"
  }
  );
}

void draw()
{
  background(255);
  RiText.drawAll();
}

void mouseClicked()
{
  //   image(tablet, 40, 40);


  if (!markov.ready()) return;

  //clean up old data
  RiText.disposeAll();



  textAlign(CENTER);
  new RiText(this, "One Hundred Thirtheenth Congress", 50, 40);
  String[] lines = markov.generateSentences(8);

  //lay out the rectangle
  textAlign(LEFT);
  RiText.createLines(this, lines, 50, 80, 400, 500);
  PrintWriter writer = createWriter("act.txt");
  println(lines);
}

