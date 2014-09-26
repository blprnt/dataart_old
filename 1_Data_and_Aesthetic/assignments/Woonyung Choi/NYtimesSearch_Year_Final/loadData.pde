int num = 8;
int[] nums = new int[num];
    
void loadData(){
  for ( int j = 1; j < num; j++){
     nums[j] = j;
     //println(j);
  }
  
  
  int[] dataCounts1 = doASearchYears(searchTerm1, startDate, endDate);
  int[] dataCounts2 = doASearchYears(searchTerm2, startDate, endDate);
  int[] dataCounts3 = doASearchYears(searchTerm3, startDate, endDate);
  int[] dataCounts4 = doASearchYears(searchTerm4, startDate, endDate);
  int[] dataCounts5 = doASearchYears(searchTerm5, startDate, endDate);
  int[] dataCounts6 = doASearchYears(searchTerm6, startDate, endDate);
  int[] dataCounts7 = doASearchYears(searchTerm7, startDate, endDate);
  
  /////////////// search term 1  /////////////////
  for ( int i = 0; i < dataCounts1.length; i++){
    float x = i*width/dataCounts1.length;
    float y = topMargin;
    float w = width/dataCounts1.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts1[i], 0, max(dataCounts1), 0,1);
    color between = lerpColor(#FFFFFF, color1, percent);
    
    fill(between);
    noStroke();
    rect( x, y, w, h);
    
  }
  
  /////////////// search term 2  /////////////////
  for ( int i = 0; i < dataCounts2.length; i++){
    float x = i*width/dataCounts2.length;
    float y = topMargin;
    float w = width/dataCounts2.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts2[i], 0, max(dataCounts2), 0,1);
    color between = lerpColor(#FFFFFF, color2, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7, w, h/7);
    
  }
  
    /////////////// search term 3  /////////////////
  for ( int i = 0; i < dataCounts3.length; i++){
    float x = i*width/dataCounts3.length;
    float y = topMargin;
    float w = width/dataCounts3.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts3[i], 0, max(dataCounts3), 0,1);
    color between = lerpColor(#FFFFFF, color3, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *2, w, h/7);
    
  }
  
  /////////////// search term 4  /////////////////
  for ( int i = 0; i < dataCounts4.length; i++){
    float x = i*width/dataCounts4.length;
    float y = topMargin;
    float w = width/dataCounts4.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts4[i], 0, max(dataCounts4), 0,1);
    color between = lerpColor(#FFFFFF, color4, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *3, w, h/7);
    
  }
  
  /////////////// search term 5  /////////////////
  for ( int i = 0; i < dataCounts5.length; i++){
    float x = i*width/dataCounts5.length;
    float y = topMargin;
    float w = width/dataCounts5.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts5[i], 0, max(dataCounts5), 0,1);
    color between = lerpColor(#FFFFFF, color5, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *4, w, h/7);
    
  }
  
    /////////////// search term 6  /////////////////
  for ( int i = 0; i < dataCounts6.length; i++){
    float x = i*width/dataCounts6.length;
    float y = topMargin;
    float w = width/dataCounts6.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts6[i], 0, max(dataCounts6), 0,1);
    color between = lerpColor(#FFFFFF, color6, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *5, w, h/7);
    
  }
  /////////////// search term 7  /////////////////
  for ( int i = 0; i < dataCounts7.length; i++){
    float x = i*width/dataCounts7.length;
    float y = topMargin;
    float w = width/dataCounts7.length;
    float h = canvasHeight;
    
    float percent = map(dataCounts7[i], 0, max(dataCounts7), 0,1);
    color between = lerpColor(#FFFFFF, color7, percent);
    
    fill(between);
    noStroke();
    rect( x, y + h/7 *6, w, h/7);
    
  }
}
