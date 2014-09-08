//
// GALAXY OF THINGS :: 2014
//

function setup() {
    var canvas = createCanvas(1280,5200);    
    canvas.position(0,30);
    canvas.class("galaxy");

    htmlTitleText("Galaxy of Things",25,35);
    htmlSubtitle("Zooming into the galaxy, scroll controlled by scale",30,125);

    htmlScrollText("Milky Way 232, 435, 203, 412, 073, 480, 000, 000, 000, 000, 000, 000 square feet",30,385);
    htmlScrollText("Sun 9, 000, 000, 000, 000, 000, 000, 000, 000 square feet",30,2000);
    htmlScrollText("Earth 5, 500, 000, 000, 000, 000 square feet",30,2500);
    htmlScrollText("Grand Canyon 53, 000, 000, 000 square feet",30,2900);
    htmlScrollText("One World Trade Center Tower 1,776 feet high",30,3300);
    htmlScrollText("Blue Whale 80 feet long",30,3600);
    htmlScrollText("Human 6 feet tall",30,3900);
    htmlScrollText("Basketball 2.5 feet circumference",30,4200);
    htmlScrollText("Ant 0.0393701 feet long",30,4500);
    htmlScrollText("Blood Cell 0.00002624671 feet long",30,4820);
}

function draw() {
    rectMode(CENTER);
    background(82,237,199);
    incomingGalaxy()
    // milky way
    incomingObject(255,94,58,365,10+(window.pageYOffset*9));
    incomingObject3(255,255,255,365,10+(window.pageYOffset*2));
    // sun
    if (window.pageYOffset > 1300){
        incomingSun(255,204,0,2000,(window.pageYOffset-1300)*3);
    }
    // earth
    if (window.pageYOffset > 1800){
        incomingEarth(52,170,220,2500,(window.pageYOffset-1800)*3);
    } 
    // grand canyon
    if (window.pageYOffset > 2200){
        incomingCannon(255,149,0,2900,(window.pageYOffset-2200)*3);
    }
    // WTC tower
    if (window.pageYOffset > 2700){
        incomingWTC(82,237,199,3400,(window.pageYOffset-2700)*3);
    }   
    // blue whale
    if (window.pageYOffset > 2900){
        blueWhale(29,98,240,3600,(window.pageYOffset-2900)*3);
    }   
    // human
    if (window.pageYOffset > 3100){
        human(255,123,179,3800,(window.pageYOffset-3100)*3);
    }  
    // basketball
    if (window.pageYOffset > 3300){
        incomingObject(255,94,58,4200,(window.pageYOffset-3300)*3);
    }   
    // ant
    if (window.pageYOffset > 3700){
        ant(82,237,199,4600,(window.pageYOffset-3700)*3);
    }   
    // blood cell
    if (window.pageYOffset > 4000){
        incomingObject3(188,86,214,4800,20,20);
        incomingObject3(188,86,214,4800,10,10);
    }
    lineRefresh();
    
}

window.onscroll = function (event) {
  println(window.pageYOffset);
  pageY = window.pageXOffset;
}

function incomingObject(r,g,b,h,grow){
    fill(r,g,b);
    noStroke();
    ellipse((width/2)-30,h,grow,grow);
}

function incomingObject2(r,g,b,h,grow){
    fill(r,g,b);
    noStroke();
    rect((width/2)-30,h,grow,grow);
}

function incomingObject3(r,g,b,h,grow){
    stroke(r,g,b);
    strokeWeight(2);
    ellipse((width/2)-30,h,grow,grow);
}

function lineRefresh() {
    stroke(255);
    strokeWeight(0.5);
    line(30,145,width,145);
}

function htmlTitleText(string,tx,ty){
    var text = createHTML(string);
    text.position(tx,ty);
}

function htmlSubtitle(string,tx,ty){
    var text = createHTML(string);
    text.position(tx,ty);
    text.id("subtext");
}

function htmlScrollText(string,tx,ty){
    var text = createHTML(string);
    text.position(tx,ty);
    text.id("scrolltext");
}

function ant(r,g,b,h,grow){
    fill(r,g,b);
    noStroke();
    ellipse((width/2)-30,h,grow*0.75,grow);
}

function human(r,g,b,h,grow){
    fill(r,g,b);
    fill(r,g,b);
    noStroke();
    rect((width/2)-30,h,grow*0.75,grow);
}

function blueWhale(r,g,b,h,grow){
    fill(r,g,b);
    ellipse((width/2),h,grow*2,grow);

    ellipse(width/2,h+(grow*.01),grow/2,grow/8);
    ellipse(width/2,h-(grow*.07),grow/8,grow/2);
    ellipse(width/2,h+(grow*.18),grow/6,grow/2);

}

function incomingWTC(r,g,b,h,grow){
    fill(r,g,b);
    noStroke();
    rect((width/2),h-(grow-100),grow/10,grow);  
    rect((width/2),h,grow+200,grow+100);

}

function incomingCannon(r,g,b,h,grow){
    fill(r,g,b);
     for(var i = 0; i< 500; i += 200){ 
    // triangle(30+(grow+i), height/2+75, 58+(grow+i), height/2+20, 86+(grow+i), height/2+75);
    rect((width/3)+i,h+(h/10),grow/3,grow);
     }
}

function incomingEarth(r,g,b,h,grow){
    fill(r,g,b);
    noStroke();
    ellipse((width/2),h,grow,grow);
     
    for(var i = 0; i< 200; i += 200){ 
    fill(0,102,0); 
    rect((width/2),(h+i),grow,grow/30);
    }
}

function incomingSun(r,g,b,h,grow){
    fill(r,g,b);
    noStroke();
    ellipse((width/2),h,grow,grow);

    for(var i = 0; i< 1500; i += 150){ 
    strokeWeight(1);
    stroke(255,145,0); 
    noFill();
    ellipse((width/2),h,grow-i,grow-i);

}
        
 }

 function incomingGalaxy(){
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse((width/2)-30,365,50,50);
    ellipse((width/2)-30,365,90,90);
    ellipse((width/2)-30,365,100,100);
    fill(255);
    ellipse(585,365,10,10);
    ellipse(642,327,10,10);

 }