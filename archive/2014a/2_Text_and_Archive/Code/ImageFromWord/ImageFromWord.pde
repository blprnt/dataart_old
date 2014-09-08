PImage img;

void setup() {
  size(1280, 720);
  img = getImage("frog");
  
}

void draw() {
  if (img.width > 1) image(img,0,0);
}

PImage getImage(String topic) {
  PImage img = null;
  try {
    String url = "https://www.googleapis.com/freebase/v1/topic/en/" + topic + "?filter=/common/topic/image&limit=1";
    JSONObject json = loadJSONObject(url);
    String id = json.getJSONObject("property").getJSONObject("/common/topic/image").getJSONArray("values").getJSONObject(0).getString("id");
    String imgUrl = "https://usercontent.googleapis.com/freebase/v1/image" + id + "?maxwidth=200&junk=.jpg";
    img = requestImage(imgUrl);
  } 
  catch (Exception e) {
    println("Image not found?");
  }
  return(img);
}

