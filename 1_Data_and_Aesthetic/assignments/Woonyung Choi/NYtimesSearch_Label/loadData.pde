void loadData(){
  // This function returns a list of integers, counting a search term per year
  int[] dataCounts1 = doASearchYears(searchTerm1, startDate, endDate);
  int[] dataCounts2 = doASearchYears(searchTerm2, startDate, endDate);
  int[] dataCounts3 = doASearchYears(searchTerm3, startDate, endDate);
  int[] dataCounts4 = doASearchYears(searchTerm4, startDate, endDate);
  int[] dataCounts5 = doASearchYears(searchTerm5, startDate, endDate);
  int[] dataCounts6 = doASearchYears(searchTerm6, startDate, endDate);
  int[] dataCounts7 = doASearchYears(searchTerm7, startDate, endDate);
  
  
  // add the color code for reference
  color[] colorCodes = {color1, color2, color3, color4, color5, color6, color7};
  String[] labels = {searchTerm1, searchTerm2, searchTerm3, searchTerm4, searchTerm5, searchTerm6, searchTerm7};
  
  for ( int j = 0; j < 7; j++){
    // color code
    noStroke();
    fill(colorCodes[j]);
    rect(leftMargin, 15 + padding * j, 10,10);
    
    // label 
    textSize(10);
    fill(0);
    textAlign(LEFT, CENTER);
    text(labels[j], leftMargin + 30, 18+ padding*j);
  }
  
  text("1970", leftMargin, topMargin - 10);
  text("2014", canvasWidth + 20, topMargin - 10);
  
  /////////////// search term 1  /////////////////
  for ( int i = 0; i < dataCounts1.length; i++){
    float x = i*canvasWidth/dataCounts1.length + leftMargin;
    float y = topMargin;
    float w = canvasWidth/dataCounts1.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts1[i], 0, max(dataCounts1), 0,1);
    color between = lerpColor(#FFFFFF, color1, percent);
    
    fill(between);
    noStroke();
    rect( x, y, w, h);
    
  }
  
  /////////////// search term 2  /////////////////
  for ( int i = 0; i < dataCounts2.length; i++){
    float x = i*canvasWidth/dataCounts2.length + leftMargin;
    float y = topMargin;
    float w = canvasWidth/dataCounts2.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts2[i], 0, max(dataCounts2), 0,1);
    color between = lerpColor(#FFFFFF, color2, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7, w, h/7);
    
  }
  
    /////////////// search term 3  /////////////////
  for ( int i = 0; i < dataCounts3.length; i++){
    float x = i*canvasWidth/dataCounts3.length + leftMargin;
    float y = topMargin;
    float w = canvasWidth/dataCounts3.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts3[i], 0, max(dataCounts3), 0,1);
    color between = lerpColor(#FFFFFF, color3, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *2, w, h/7);
    
  }
  
  /////////////// search term 4  /////////////////
  for ( int i = 0; i < dataCounts4.length; i++){
    float x = i*canvasWidth/dataCounts4.length + leftMargin;
    float y = topMargin;
    float w = canvasWidth/dataCounts4.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts4[i], 0, max(dataCounts4), 0,1);
    color between = lerpColor(#FFFFFF, color4, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *3, w, h/7);
    
  }
  
  /////////////// search term 5  /////////////////
  for ( int i = 0; i < dataCounts5.length; i++){
    float x = i*canvasWidth/dataCounts5.length + leftMargin;
    float y = topMargin;
    float w = canvasWidth/dataCounts5.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts5[i], 0, max(dataCounts5), 0,1);
    color between = lerpColor(#FFFFFF, color5, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *4, w, h/7);
    
  }
  
    /////////////// search term 6  /////////////////
  for ( int i = 0; i < dataCounts6.length; i++){
    float x = i*canvasWidth/dataCounts6.length + leftMargin;
    float y = topMargin;
    float w = canvasWidth/dataCounts6.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts6[i], 0, max(dataCounts6), 0,1);
    color between = lerpColor(#FFFFFF, color6, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *5, w, h/7);
    
  }
  /////////////// search term 7  /////////////////
  for ( int i = 0; i < dataCounts7.length; i++){
    float x = i*canvasWidth/dataCounts7.length + leftMargin;
    float y = topMargin;
    float w = canvasWidth/dataCounts7.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts7[i], 0, max(dataCounts7), 0,1);
    color between = lerpColor(#FFFFFF, color7, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *6, w, h/7);
    
  }
}
