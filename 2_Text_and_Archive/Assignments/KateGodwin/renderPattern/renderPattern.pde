float x, y, speed;

void setup() {
  size( 430, 430 );
  background( 30 );
}

void draw() {
  renderPattern();
}

void renderPattern() {
  speed += .004;

  pushMatrix();
    translate( width / 2, height / 2 );
    
    for ( int i = 0; i < 2500; i += 5 ) {
      x = sin( ( speed + i ) * 200 ) * 200;
      y = cos( speed + i ) * 200;
      
      noStroke();
      fill( 230, 230, 230, 130 );
      ellipse( x, y, 2, 2 );
    }
  popMatrix();
}
