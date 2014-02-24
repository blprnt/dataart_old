JSONArray Planets = new JSONArray();
color[] PlanetColors = {
  color(203, 40, 38),
  color(239, 71, 34),
  color(215, 129, 64),
  color(254, 225, 0),
  color(214, 215, 36),
  color(100, 187, 84),
  color(66, 111, 182),
  color(40, 55, 136),
  color(80, 195, 199),
};
int fontSize = 7;
int lineHeight = 8;
boolean fileSaved = false;

void setup() {
  Planets.append(loadJSONObject("data/sun_processed.json"));
  Planets.append(loadJSONObject("data/mercury_processed.json"));
  Planets.append(loadJSONObject("data/venus_processed.json"));
  Planets.append(loadJSONObject("data/earth_processed.json"));
  Planets.append(loadJSONObject("data/mars_processed.json"));
  Planets.append(loadJSONObject("data/jupiter_processed.json"));
  Planets.append(loadJSONObject("data/saturn_processed.json"));
  Planets.append(loadJSONObject("data/uranus_processed.json"));
  Planets.append(loadJSONObject("data/neptune_processed.json"));
  
  PFont font = createFont("Monospaced",64,true);
  textFont(font,fontSize);
  size(6000, 6000);
  background(255);
  drawRadioText();
}

void draw() {
  if (!fileSaved) {
    saveFrame("output.png");
    fileSaved = true;
  }
}

void drawRadioText() {
  
  for (int j=0; j < 100; j++) {
    
      float x = width/2;
      float y = height/2;
      float r = map(j,0,100,0, 2*PI);
      float y_delta = 0;
      
      pushMatrix();
      translate(x,y);
      rotate(r);
      rotate(-HALF_PI);
      
      for (int p=0; p < Planets.size(); p++) {
        
          fill(PlanetColors[p]);
          JSONArray yearData = Planets.getJSONObject(p).getJSONArray("years").getJSONArray(j);
         
          for (int i=0; i < yearData.size(); i++){
              String verse = yearData.getString(i);
              text(verse, -30, y_delta);
              println(y_delta);
              y_delta = y_delta - lineHeight;
          } 
      
      }
      popMatrix();
  
  }
  
}

