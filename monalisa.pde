//image manipulation

PImage photo;

void setup(){
  size(800,650);
  photo = loadImage("/Users/sangjinlee/Desktop/monalisa.jpg");
  //Using the width and height of the photo for the screen size
  photo.resize(width,height); 
}

void draw(){
  if (mousePressed){
    loadPixels();
    photo.loadPixels();
    for(int x= 0; x<width; x++){
      for(int y=0; y<height; y++){
        //location in the pixel array
        int loc = x+y*width;
        float r = red(photo.pixels[loc]);
        float g = green(photo.pixels[loc]);
        float b = blue(photo.pixels[loc]);
        //get distance between the cursor and the pixel
        float d = dist(mouseX,mouseY,x,y);
        float mult = map(d,0,120,1.5,0);
        //the closer the distance, the brighter.
        pixels[loc] = color(r*mult,g*mult,b*mult);
      }
    }
    updatePixels();
  } else{
    background(255);
    fill(0);
    noStroke();
    
    //Max val for mouseX is 800. So reduce it.
    float ellipseNumber = mouseX / 5;
    //Distance between the ellipses
    float ellipseGap = width / ellipseNumber;
    
    translate(ellipseGap/2, ellipseGap/2);
    
    for (int i=0; i<ellipseNumber; i++){
      for (int j=0; j<ellipseNumber; j++){
        //get pixel color corresponding to the changing x and y-axis
        color c = photo.get(int(i*ellipseGap), int(j*ellipseGap));
        //Extract size corresponding to the brightness (0~255) of c we got.
        //Because size is too big, we use map to set the darkest 0 to size 10
        //and to set the brightest 255 to size 0.5.
        float size = map(brightness(c), 0, 255, 10, 0.5);
        
        ellipse(i*ellipseGap, j*ellipseGap, size, size);
      }
    }
  }
}
