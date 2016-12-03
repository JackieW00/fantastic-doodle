color f=color(225,225,225);

ArrayList<int[]> pixs = new ArrayList<int[]>();
//Sketch --> import library  Add library --> Video| Gstreamer
import processing.video.*;

// Download blobscanner.zip from (https://sites.google.com/site/blobscanner/Download)
// Move folder from downloads to processing library folder
//import blobscanner.*;

Capture cam;
PImage orig;
PImage updated;

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

void checkBlue() {
  //int counter = 0;
  for (int x =0; x<cam.width; x++) {
    for (int y = 0; y < cam.height; y++) {
      //if (blue(cam.get(x,y)) < 250){ 
      color camColor = cam.get(x, y);
     if (blue(camColor) > 120 && blue(camColor) > 1.7*red(camColor) && blue(camColor) > 1.7*green(camColor)) { 
        int[] a = new int[5];
        a[0] = x;
        a[1] = y;
        a[2] = (int)red(f);
        a[3] = (int)blue(f);
        a[4] = (int)green(f);
      

      
        pixs.add(a);
      //cam.set(x, y, (color(255, 0, 0)));
    }
  }
}
}

void setDrawing() {
  for (int i = 0; i < pixs.size(); i++){
     cam.set(pixs.get(i)[0], pixs.get(i)[1], color(pixs.get(i)[2],pixs.get(i)[3],pixs.get(i)[4]));  
  }
}
  
void clear(){
   for (int i = pixs.size()-1; i >=0; i--){
      pixs.remove(i); 
   }
}

void setColor(){
  if (key == '1'){
      f=color(225,0,0);
  }
  if (key == '2'){
      f=color(0,225,0);
  } 
  
  if (key =='3'){
      f=color(0,0,225);
  }
  if (key =='4'){
      f=color(225,225,0);
  }
  if (key =='5'){
      f=color(225,0,225);
  }
  if (key =='6'){
      f=color(0,225,225);
  }
  if (key =='7'){
      f=color(255,120,0);
  }
  if (key =='8'){
      f=color(150,150,150);
  }
  if (key =='9'){
      f=color(0,0,0);
  }
  if (key =='0'){
      f=color(255,255,255);
  }
  
  
}


void mousePressed(){
  clear();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  print(key);
  if (keyPressed) {
    setColor();
  }
  

  checkBlue(); 
  setDrawing();
  scale(-1, 1);
  image(cam, 0, 0, -cam.width, cam.height);
  //grayscale();
} 