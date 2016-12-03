color f=color(225,225,0);

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
      if (blue(cam.get(x, y)) > 150 && blue(cam.get(x, y)) > 1.5*red(cam.get(x, y)) && blue(cam.get(x, y)) > 1.5*green(cam.get(x, y))) { 

        /*for (int xlen =-1; xlen < 1; x++) {
         for (int ylen = -1; ylen < 1; y++) {
         if (blue(cam.get(x+xlen, y+ylen))>200 && red(cam.get(x+xlen, y+ylen))>200 && green(cam.get(x+xlen, y+ylen)) >200) {
         counter+=1;
         }
         }
         }
         if (counter>20) {*/
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
}

void mousePressed(){
  clear();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }

  checkBlue(); 
  setDrawing();
  scale(-1, 1);
  image(cam, 0, 0, -cam.width, cam.height);
  //grayscale();
} 