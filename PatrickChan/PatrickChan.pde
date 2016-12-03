//Sketch --> import library  Add library --> Video| Gstreamer
import processing.video.*;


Capture cam;
PImage orig;

void setup() {
  size(1280, 720);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i + "" + cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void grayscale(){
  for (int x = 0; x < cam.width; x++){
    for (int y = 0; y < cam.height; y++){
        color c = cam.get(x, y);
  
        float r = red(c);
        float g = green(c);
        float b = blue(c);
  
        color newColor = color((r+g+b)/3);
  
        set( x, y, newColor);
    }
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();

  }
    scale(-1, 1);
    image(cam, 0, 0, -cam.width, cam.height);
    grayscale();
} 