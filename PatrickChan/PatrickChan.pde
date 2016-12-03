import processing.video.*;
Capture cam;
PImage orig;

void setup(){
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

void draw(){
    if (cam.available() == true) {
    cam.read();
}