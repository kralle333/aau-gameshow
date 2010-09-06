import pFaceDetect.*;
import JMyron.*;

PFaceDetect face;
int faceSmileys[];
//int lastFaces[][];
JMyron m;
PImage img;
PImage smileys[];
color blank = color(0,0,0,0);
boolean setupDone = false;

void setup() {
  size(640, 480);
  m = new JMyron();
  m.start(width,height);
  m.findGlobs(0);
  face = new PFaceDetect(this,width,height,
  "haarcascade_frontalface_default.xml");
  frameRate(15);
  img = createImage(width,height,ARGB);
  if (!setupDone)
  {
    smileys = new PImage[3];
    smileys[0] = loadImage("smiley.png");
    smileys[1] = loadImage("lazor.png");
    smileys[2] = loadImage("smiley1.png");
    setupDone = true;
  }
  rectMode(CORNER);
  //rectMode(CORNER);
  noFill();
  stroke(0,0,255);
  smooth();
}

void draw() {
  background(0);
  m.update();
  arraycopy(m.cameraImage(),img.pixels);
  img.updatePixels();
  face.findFaces(img);
  image(img,0,0);
  drawFace();
}

void drawFace() {
  int [][] res = face.getFaces();
 /*if (res.length == 2)
  {
    PImage firstTemp = img.get(res[0][0], res[0][1], res[0][2], res[0][3]);
    PImage secondTemp = img.get(res[1][0], res[1][1], res[1][2], res[1][3]);
    circlize(firstTemp);
    circlize(secondTemp);
    
    printImg(firstTemp, res[1][0],res[1][1],res[1][2],res[1][3]);
    printImg(secondTemp, res[0][0],res[0][1],res[0][2],res[0][3]);
    
  }
 
  else*/
  if (res.length>0) {
    if (faceSmileys == null || res.length != faceSmileys.length)
    {
      faceSmileys = new int[res.length];
      for (int i=0; i<res.length; i++)
      {
        faceSmileys[i] = int(random(smileys.length));
      }
    }
    for (int i=0;i<res.length;i++) {
      
      int x = res[i][0];
      int y = res[i][1];
      int w = res[i][2];
      int h = res[i][3];
      //rect(x,y,w,h);
      
      image(smileys[faceSmileys[i]], x, y, w, h);
      
      
      
    }
  }
}

/*int getLastFaceIndex(int thisFace[])
{
  for (int i=0; i<lastFaces.length; i++)
  {
    if ((lastFaces[i][1] - thisFace[0]))
    {
      
    }
  }
}*/


void circlize(PImage img)
{
  int longSide;
  if (img.width > img.height) longSide = img.width;
  else longSide = img.height;
  for (int x=0; x<img.width; x++)
  {
    for (int y=0; y<img.height; y++)
    {
      int dX = x-img.width/2;
      int dY = y-img.height/2;
      
      if (sqrt(sq(dX)+sq(dY)) > longSide/2)
      {
        img.pixels[y*img.width + x] = blank;
      }
    }
  }
}

void printImg(PImage img, int destX, int destY, int destWidth, int destHeight)
{
  
  img.resize(destWidth, destHeight);
  
  for (int x=0; x<img.width; x++)
  {
    for (int y=0; y<img.height; y++)
    {
      if (img.get(x,y) != blank)
      {
        set(destX+x,destY+y,img.get(x,y));
      }
    }
  }
  
}

void stop() {
  m.stop();
  super.stop();
}
