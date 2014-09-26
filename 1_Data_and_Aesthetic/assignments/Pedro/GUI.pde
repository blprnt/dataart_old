class GUI {
  PVector position;
  int currentYear;

  //-------------------------------------------------------- Constructor
  GUI() {
    
  }
  
  
  //-------------------------------------------------------- Method to draw Curve
  void curve() {
    hint(DISABLE_DEPTH_TEST);
    pushMatrix();
    translate(0,65);
    
    //----------------------- Draw the curve
    pushStyle();
    beginShape();
    noFill();
    stroke(255,204,0);
    strokeWeight(5);
    for(int i=0; i < myData.getSize(); i=i+10){
      float x = map(i,0, myData.getSize(),100, width - 100);
      float y = map(myData.getValue(i), 0, myData.getMax(), 0, height - 200);
      
      curveVertex(x,  500-y);
      //println( counts[i] );
    }
    float x = map(myData.getSize()-1,0, myData.getSize(),100, width - 100);
    float y = map(myData.getValue(myData.getSize()-1), 0, myData.getMax(), 0, height - 200);
    //println( x );
    curveVertex(x,  500-y);
    //curveVertex(x,  500-y);
    endShape();
    
    popStyle();
    
    hint(ENABLE_DEPTH_TEST);
    
    //----------------------- Plot on the curve
    
    hint(DISABLE_DEPTH_TEST);
    
    pushStyle();
    stroke(250,204,0);
    strokeWeight(5);
    
    float xMarker = map(currentYear,0, myData.getSize(),100, width - 100);
    float yMarker = map(myData.getValue(currentYear), 0, myData.getMax(), 0, height - 200);
    
    ellipse(xMarker,500-yMarker,5,5);
    noStroke();
    fill(250,204,0);
    rect(xMarker,470-yMarker,40,20);
    rect(xMarker+45,470-yMarker,5,20);
    
    textSize(15);
    fill(100);
    textAlign(CENTER);
    text(myData.getValue(currentYear), xMarker+20, 485-yMarker);
    
    popMatrix();
    popStyle();
    
    hint(ENABLE_DEPTH_TEST);

  }
  
  //-------------------------------------------------------- Method to display GUI
  void display() {
    
    hint(DISABLE_DEPTH_TEST);
    
    //----------------------- Timeline
    int xTLine = 100;
    int yTLine = height-30;
    int xTlineCursor;
    int yTlineCursor;
    
    pushStyle();
    textSize(15);
    fill(150);
    textAlign(CENTER);
    text(fromYear, xTLine-60, yTLine+5);
    text(fromYear+((toYear-fromYear)/2), xTLine, yTLine+5);
    text(toYear, xTLine+60, yTLine+5);
    popStyle();
    
    pushStyle();
    strokeWeight(2.0);
    line(xTLine,yTLine-10, xTLine, yTLine-40); 
    popStyle();
    
    pushStyle();
    strokeWeight(2.0);
    line(xTLine-20,yTLine-10, xTLine-20, yTLine-30);
    line(xTLine-40,yTLine-10, xTLine-40, yTLine-30);
    line(xTLine-60,yTLine-10, xTLine-60, yTLine-40);
    
    line(xTLine+20,yTLine-10, xTLine+20, yTLine-30);
    line(xTLine+40,yTLine-10, xTLine+40, yTLine-30);
    line(xTLine+60,yTLine-10, xTLine+60, yTLine-40);
    popStyle();
    
    pushStyle();
    stroke(100);
    strokeWeight(4.0);
    xTlineCursor = int(map(currentYear,0, myData.getSize(),xTLine, xTLine+60));
    line(xTlineCursor,yTLine-10,xTlineCursor,yTLine-40);
    
    popStyle();
    
    //----------------------- Bar Graph
    pushStyle();
    textSize(15);
    fill(150);
    textAlign(CENTER);
    text(myData.getMin(), xTLine+125, yTLine+5);
    text(myData.getMax(), xTLine+260, yTLine+5);
    noStroke();
    for(int i=0; i < myData.getSize(); i=i+10){

      if(myData.getValue(i) != 0){
        float xBar = (i+210)*0.9;
        float yBar = height - 40;
        float wBar = 3;
        float hBar = map(myData.getValue(i), 0, myData.getMax(), 0, height - 660);
        
        fill(200);
        rect(xBar, yBar , wBar, -(height - 690));
        
        fill(140);
        rect(xBar, yBar , wBar, -hBar);
      }
    }
    popStyle();
    
    

    //----------------------- Year
    pushStyle();
    textAlign(LEFT);
    textSize(15);
    fill(150);
    text("| YEAR |", (width-xTLine)-40, yTLine+5);
    text(fromYear+currentYear, (width-xTLine)+20, yTLine+5);
    
    textFont(font);
    textSize(48);
    fill(150);
    text("_epidemic", (width-xTLine)-150, yTLine-20);
    popStyle();
    
    //----------------------- Dividers
    pushStyle();
    noStroke();
    fill(210);
    // Bot
    //rect(10,height-10,5,-80);
    rect(190,height-10,5,-80);
    rect(395,height-10,5,-80);
    rect(width-280,height-10,5,-80);
    rect(width-20,height-10,5,-80);
    //rect(width-285,height-10,2,-80);
     
    // Top
    //rect(0,10,391,80);
    rect(395,10,5,80);
     
    // Title
    textSize(15);
    fill(150);
    textAlign(RIGHT);
    text("// Article Search API v2 | New York Times", xTLine+260, 40);
    text("_DATA.ART 2014", xTLine+260, 65);

    popStyle();
    
    
    hint(ENABLE_DEPTH_TEST);


  }
  
 }
