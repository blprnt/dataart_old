class SphereItem {
  Sphere parentSphere;
  //Spherical coordinates
  float radius; 
  float theta; //latitude
  float phi; //longitude
  //Speed properties
  float thetaSpeed = 0;
  float phiSpeed = 0;
  //Size
  float itemSize = 5;

  public void SphereItem() {
  };
  public void init() { //thetaspeed of 2 and phi speed of -1.001 is awesome 
    itemSize = random(1.7, 2.5);
    thetaSpeed = 2;
    phiSpeed = -1.001; //bigger is more loops
  };
  public void update(float size, color c, float tS, float pS) {
    itemSize = size; //random(1.7, 2.5);
    fill(c); //probably be a mapping with the rate of usage of something. red and blue like a heat map for instance
    theta += thetaSpeed;
    phi += phiSpeed;
  };
  public void render() {
    //Get the radius from the parent Sphere
    float r = parentSphere.radius;
    //Convert spherical coordinates into Cartesian coordinates
    float x = cos(theta) * sin(phi) * r;
    float y = sin(theta) * sin(phi) * r;
    float z = cos(phi) * r;
    //Mark our 3d space
    pushMatrix();
    //Move to the position of this item
    translate(x, y, z);
    //Set the fill colour
    //fill(#ff6600, 50);
    noStroke();
    //Draw a circle
    ellipse(0, 0, itemSize, itemSize);
    //Go back to position in 3d space
    popMatrix();
  };
};

