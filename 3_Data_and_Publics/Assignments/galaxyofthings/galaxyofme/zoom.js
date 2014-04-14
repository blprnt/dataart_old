//
// GALAXY OF THINGS :: 2014
//

function setup() {
    var canvas = createCanvas(1280,5200);    
    canvas.position(0,30);

    htmlTitleText("Galaxy of Things",25,35);
    htmlSubtitle("Zooming into the galaxy, scroll controlled by scale",30,125);

    htmlScrollText("You!",30,385);
}

function draw() {
    rectMode(CENTER);
    background(255,149,0);
    // user
    incomingObject(255,123,179,365,10+(window.pageYOffset*9),10+(window.pageYOffset*9));

    lineRefresh();
}

window.onscroll = function (event) {
  println(window.pageYOffset);
  pageY = window.pageXOffset;
}

function incomingObject(r,g,b,h,x,y){
    fill(r,g,b);
    noStroke();
    ellipse((width/2)-30,h,x,y);
}

function incomingObject2(r,g,b,h,x,y){
    fill(r,g,b);
    noStroke();
    rect((width/2)-30,h,x,y);
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
