//Jovan Tang
//June 17th 2025

//Unit 3 Project 3
//3D Enviornment Exploration

import java.awt.Robot;
Robot rbt;

//COLOR
color black = color(0);
color white = color(255);
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color purple = color(120, 81, 169);

//TEXTURES

//MAP
int gridSize;
PImage mapLayout;

//WEATHER

//KEYBOARD
boolean wKey, aKey, sKey, dKey, spaceKey;

//CAMERA
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ;
float leftRightHeadAngle, upDownHeadAngle;
int cameraHeight;

void setup() {
  fullScreen(P3D);

  //COLORS
  fill(white);
  stroke(white);

  //KEYBOARD SETUP
  wKey = aKey = sKey = dKey = false;

  //MAP SETTINGS
  gridSize = 100;
  mapLayout = loadImage("map.png");

  //CAMERA SETUP
  cameraHeight = gridSize*2;

  eyeX = 0;
  eyeY = cameraHeight;
  eyeZ = 0;

  focusX = 0;
  focusY = 0;
  focusZ = 10;

  tiltX = 0;
  tiltY = 1;
  tiltZ = 0;

  leftRightHeadAngle = radians(0);

  //ROBOT SETTINGS
  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  
  //ELIMINATING CURSOR
  noCursor();
}

void draw() {
  background(black);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  crosshair();
  controlCamera();
  drawMap();
}

void crosshair() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(3);
  popMatrix();
}

void controlCamera() {
  if (wKey) {
    eyeZ = eyeZ + sin(leftRightHeadAngle)*20;
    eyeX = eyeX + cos(leftRightHeadAngle)*20;
  }
  if (sKey) {
    eyeZ = eyeZ - sin(leftRightHeadAngle)*20;
    eyeX = eyeX - cos(leftRightHeadAngle)*20;
  }
  if (aKey) {
    eyeZ = eyeZ - sin(leftRightHeadAngle+radians(90))*20;
    eyeX = eyeX - cos(leftRightHeadAngle+radians(90))*20;
  }
  if (dKey) {
    eyeZ = eyeZ + sin(leftRightHeadAngle+radians(90))*20;
    eyeX = eyeX + cos(leftRightHeadAngle+radians(90))*20;
  }
  if (spaceKey) eyeY = eyeY -20;

  leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
  upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)*0.01;
  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle < -PI/2.5) upDownHeadAngle = -PI/2.5;

  focusX = eyeX+cos(leftRightHeadAngle)*500;
  focusZ = eyeZ+sin(leftRightHeadAngle)*500;
  focusY = eyeY + tan(upDownHeadAngle)*500;

  if (mouseX > width-2) rbt.mouseMove(3, mouseY);
  else if (mouseX < 2) rbt.mouseMove(width-3, mouseY);
}

void drawMap() {
  drawGrid(-1000, 1000, 0);
  for (int x = 0; x < mapLayout.width; x++) {
    for (int y = 0; y < mapLayout.height; y++) {
      color c = mapLayout.get(x, y);
      
      pushMatrix(); 
      translate(x*gridSize, 0, y*gridSize); 
      fill(c); 
      box(gridSize, 50, gridSize); 
      popMatrix(); 
    }
  }
}

void drawGrid(int start, int end, int level) {
  for (int x = -2000; x <= 20002; x = x + gridSize) { //total is 40 blocks wide
    strokeWeight(1);
    line(x, level, -2000, x, level, 2000);
    line(-2000, level, x, 2000, level, x);
  }
}
