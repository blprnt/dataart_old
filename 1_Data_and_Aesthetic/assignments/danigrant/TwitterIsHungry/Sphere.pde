class Sphere {
  float xPos; //X Position of the Sphere
  float yPos; //Y Position of the Sphere
  float zPos; //Z Position of the Sphere
  float radius; //Radius of the Sphere
  ArrayList items = new ArrayList(); //List of all of the items contained in the Sphere

  public Sphere(float x, float y, float z, float r) {
    xPos = x;
    yPos = y;
    zPos = z;
    radius = r;
  };
  public void init() {
  };
  public void update(float size, color c, float tS, float pS) {
    for (int i = 0; i < items.size(); i ++) {
      SphereItem si = (SphereItem) items.get(i); // Cast the returned object to the SphereItem Class
      si.update(size, c, tS, pS);
    };
  };
  public void render() {
    //Move to the center point of the sphere
    translate(xPos, yPos, zPos);
    //Mark position in 3d space
    pushMatrix();
    //Render each SphereItem
    for (int i = 0; i < items.size(); i ++) {
      SphereItem si = (SphereItem) items.get(i);
      si.render();
    };
    //Go back to original position in 3d space
    popMatrix();
  };
  public void addSphereItem() {
    //Make a new SphereItem  
    SphereItem si = new SphereItem();
    //Set the parent sphere
    si.parentSphere = this;
    //Set random values for the spherical coordinates
    si.theta = PI;
    si.phi = 2 * PI;
    //Add the new sphere item to the end of ArrayList
    items.add(items.size(), si);
    si.init();
  };
};
