// Fantasy Map
// By Winslow Church

import processing.svg.*;

// Initialize Image Variables
PImage mountain1;
PImage mountain2;
PImage snowyMountain1;
PImage snowyMountain2;
PImage bigMountain;
PImage hill1;
PImage hill2;
PImage grass1;
PImage grass2;
PImage tree1;
PImage tree2a;
PImage tree2b;
PImage castle1;
PImage castle2;
PImage castle3;
PImage castle4;
PImage castle5;
PImage castle6;
PImage castle7;
PImage ruins;
PImage water1;
PImage water2;
PImage boat1;
PImage boat2;
PImage lighthouse;
PImage volcano;
PImage compass;
PImage banner1;
PImage banner2;

float scale = 0.005;
float noiseStrength = 50;

void setup() {
  //size(1000, 700, SVG, "result.svg");
  size(2000, 1400);
  noLoop();
  noStroke();
  pixelDensity(2);
  loadImages();
}

void loadImages() {
  mountain1 = loadImage("images/mountain1.png");
  mountain1.resize(0,60);
  mountain2 = loadImage("images/mountain2.png");
  mountain2.resize(0,50);
  snowyMountain1 = loadImage("images/snowyMountain.png");
  snowyMountain1.resize(0, 100);
  snowyMountain2 = loadImage("images/snowyMountain2.png");
  snowyMountain2.resize(0, 100);
  bigMountain = loadImage("images/bigMountain.png");
  bigMountain.resize(0,100);
  hill1 = loadImage("images/hill1.png");
  hill1.resize(0, 100);
  hill2 = loadImage("images/hill2.png");
  hill2.resize(0, 100);
  
  grass1 = loadImage("images/grass.png");
  grass1.resize(0,100);
  grass2 = loadImage("images/grass2.png");
  grass2.resize(0, 100);
  tree1 = loadImage("images/tree.png");
  tree1.resize(0,80);
  tree2a = loadImage("images/tree2a.png");
  tree2a.resize(0,100);
  tree2b = loadImage("images/tree2b.png");
  tree2b.resize(0,100);
  
  castle1 = loadImage("images/castle.png");
  castle1.resize(0,120);
  castle2 = loadImage("images/castle2.png");
  castle2.resize(0,100);
  castle3 = loadImage("images/castle3.png");
  castle3.resize(0,100);
  castle4 = loadImage("images/castle4.png");
  castle4.resize(0,110);
  castle5 = loadImage("images/castle5.png");
  castle5.resize(0,100);
  castle6 = loadImage("images/castle6.png");
  castle6.resize(0,100);
  castle7 = loadImage("images/castle7.png");
  castle7.resize(0, 140);
  ruins = loadImage("images/ruins.png");
  ruins.resize(0,100);
  
  water1 = loadImage("images/water1.png");
  water1.resize(0,50);
  water2 = loadImage("images/water2.png");
  water2.resize(0,50);
  boat1 = loadImage("images/boat.png");
  boat1.resize(0, 100);
  boat2 = loadImage("images/boat2.png");
  boat2.resize(0, 90);
  lighthouse = loadImage("images/lighthouse.png");
  lighthouse.resize(0, 140);
  volcano = loadImage("images/volcano.png");
  volcano.resize(0,220);
  compass = loadImage("images/compass.png");
  compass.resize(0, 260);
  banner1 = loadImage("images/banner.png");
  banner1.resize(0, 200);
  banner2 = loadImage("images/banner2.png");
  banner2.resize(0, 200);
}

Boolean lighthouseUsed = false;
void draw() {
  background(255);
  // Generate terrain
  for (int y = -20; y < 1400; y += 80) {
    for (int x = -20; x < 2000; x += 80) {
      
      float noiseValue = noise(x * scale, y * scale);
      float heightValue = noiseValue * noiseStrength;
      
      if (heightValue < 20) {
        drawWater(x,y);
      } else if (heightValue >= 20) {
        drawLand(x,y, heightValue);
      }
    }
  }  
  
  // Water shading, border
  fill(5);
  for (int y = 0; y < 1400; y++) {
    for (int x = 0; x < 2000; x++) {
      
      float noiseValue = noise(x * scale, y * scale);
      float heightValue = noiseValue * noiseStrength;
      
      int vx = int(random(20));
      int vy = int(random(20));
      
      if (heightValue < 20) {
        int c = int(random(30));
        if (c==1) circle(x+vx,y+vy,1.2);
        if (heightValue > 19.8) circle(x+vy, y+vx,1.2);
        if (heightValue > 19.9) circle(x+10, y+10,1.2);
      }
    }
  }
  image(volcano, int(random(2000)), int(random(1400)));
  image(compass, 1750, 1140);
  int b = int(random(2));
  if (b == 0) {
    image(banner1, 0, 0);
  } else {
    image(banner2, 0, 0);
  }
}

void drawWater(int x, int y) {
   int n = int(random(20));
   int vx = int(random(-20,20));
   int vy = int(random(-20,20));
   
   if (n < 4) {
     int waterType = int(random(2));
     if (waterType == 1) {
       image(water1,x+vx,y+vy);
     } else {
       image(water2,x+vx,y+vy);
     }
   }
   
   n = int(random(60));
   if (n == 1) {
     image(boat1, x, y);
   } else if (n == 2) {
     image(boat2, x, y);
   } else if (n == 3 && !lighthouseUsed) {
     image(lighthouse, x, y);
     lighthouseUsed = true;
   }
}
 
int cityX = int(random(1500));
int cityY = int(random(1100));
int citySizeX = int(random(200,500));
int citySizeY = int(random(200,500));
void drawLand(int x, int y, float heightValue) {
  int vx = int(random(-30,30));
  int vy = int(random(-40,40));
  int n = int(random(25));
  
  if (n == 1) {
    drawStructure(x+vx,y+vy);
  } else if ((x > cityX) & (x < (cityX + citySizeX)) & (y > cityY) & (y < cityY + citySizeY)) {
    drawStructure(x+vx, y+vy);  
  } else if ((heightValue > 29) && (heightValue < 38.5)) {
    drawTree(x+vx, y+vy);
  } else if (heightValue > 38.5) { 
    image(bigMountain, x, y);
  } else {
    drawMountains(x+vx,y+vy);    
  }
}

int treeLine = int(random(200,1800));
void drawTree(int x, int y) {
  int t = int(random(2));
  if (x > treeLine) {
      image(tree1, x, y);
  } else {
    if (t == 1) {
      image(tree2a, x, y);
    } else {
      image(tree2b, x, y);
    }
  }
}

void drawStructure(int x, int y) {
  int n = int(random(8));
  if (n == 0) {
    image(castle1, x, y);
  } else if (n == 1) {
    image(castle2, x, y);
  } else if (n == 2) {
    image(castle3, x, y);
  } else if (n == 3) {
    image(castle4, x, y);
  } else if (n == 4) {
    image(castle5, x, y);
  } else if (n == 5) {
    image(ruins, x, y);
  } else if (n == 6) {
    image(castle6, x, y);
  } else if (n == 7) {
    image(castle7, x, y);
  }
} 

int mountainLine = int(random(500,1000));
int snowX = int(random(1900));
int snowY = int(random(1200));
int snowSize = int(random(200,700));
int grassX = int(random(1500));
int grassY = int(random(1000));
int grassSizeX = int(random(400,1000));
int grassSizeY = int(random(400,1000));
void drawMountains(int x, int y) {
  int w = int(random(2));
  if ((x > snowX) && (x < snowX + snowSize) && (y > snowY) && (y < snowY + snowSize)) {
    if (w == 1) image(snowyMountain1, x, y); 
    else image(snowyMountain2, x, y);
  } else if ((x > grassX) && (x < grassX + grassSizeX) && (y > grassY) && (y < grassY + grassSizeY)) {
    if (w == 1) {
      image(grass1, x, y);
    } else {
      image(grass2, x, y);
    }
  } else if (y > mountainLine) {
    if (w == 1) image(hill1, x, y);
    else image(hill2, x, y);
  } else {
    if (w == 1) image(mountain1, x, y);
    else image(mountain2, x, y);
  }
}

///////////////////////////
// INTERACTIVE FUNCTIONS //
///////////////////////////

void keyPressed() {
  if (key == 's') {
    save("result.png"); 
  } 
}
