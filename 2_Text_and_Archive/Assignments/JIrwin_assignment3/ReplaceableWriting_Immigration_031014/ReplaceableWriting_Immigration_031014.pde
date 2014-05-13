import rita.*; // also requires the core RiTa library
import rita.wordnet.*;

RiText[] rts; 
RiWordnet wordnet; 

String text = "Restriction on issuance of visas to nonimmigrants who are from countries that are state sponsors of international terrorism. That no Chinese person shall be construed to impose requirements that are inconsistent with the North American Free Trade Agreement or to require additional documents for certain newly admitted aliens. Mexico. 8 USC 1751. > > 401. That after the date of enactment of the interoperable electronic data system with name-matching capacity and training Government personnel. Extension CHAP. 641 - An Act To prohibit the coming of Chinese descent arrested under the Visa Waiver Program. Authorization of appropriations for hiring and training Government personnel.";

void setup()
{
  size(480, 480);
  wordnet = new RiWordnet(this);


  RiText.defaultFont("Helvetica", 18);
  rts = RiText.createLines(this, text, 30, 50, 420);
}

void draw()
{
  background(255);

  // substitute every 120 frames 
  if (frameCount % 80 == 1)   
    doSubstitution();

  RiText.drawAll();
}

/*  replace a random word in the paragraph with one
 from wordnet with the same (basic) part-of-speech */
void doSubstitution()
{
  String[] words = RiTa.tokenize(text);

  // loop from a random spot
  int count =  (int)random(0, words.length);
  for (int i = count; i < words.length; i++) 
  {
    // only words of 3 or more chars
    if (words[i].length()<3) continue;

    // get the pos
    String pos = wordnet.getBestPos(words[i].toLowerCase());        
    if (pos != null) 
    {
      // get the synset
      String[] syns = wordnet.getSynset(words[i], pos);
      if (syns == null) continue;

      // pick a random synonym
      String newStr = syns[(int)random(0, syns.length)];

      // preserve capitalization
      if (Character.isUpperCase(words[i].charAt(0)))
        newStr = RiTa.upperCaseFirst(newStr);

      // and make the substitution
      text = text.replaceAll("\\b"+words[i]+"\\b", newStr);

      RiText.disposeAll();   // clean up the last batch

      // create a RiText[] from 'test' starting at (30,50) & going down
      rts = RiText.createLines(this, text, 30, 50, 420);    

      break;
    }

    if (count == words.length) count = 0; // back to beginning
  }
}

