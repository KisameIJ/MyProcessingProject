//Imports
import processing.sound.*;
//Final Variables
color mapBackground = color(200, 150, 100);


//Class types
Enemies enem;
Projectiles proj;
Towers tower;





//Game Variables
PImage mapBackground1;
PGraphics buildMap;
boolean gameStarted = false;
boolean gameEnded = false;
boolean gamePaused = true;
ArrayList<Enemies> enemies = new ArrayList<Enemies>();





void setup(){
 size(1200, 800);
 SoundFile music = new SoundFile(this, "Assets/firstPick.wav");
 mapBackground1 = loadImage("Assets/TempMap.png");
 buildMap = createGraphics(width, height);
 
 buildMap.beginDraw();
 buildMap.image(mapBackground1, 0, 0, width, height);
 buildMap.endDraw();
  

}

void draw(){
image(buildMap, 0, 0);
drawUi();
turnPoints();

}

void mouseClicked(){
  gameStarted = true;
}
void drawUi(){
  ScreenUi();
}
void ScreenUi(){
  fill(150, 100, 80);
  rect(15, 675, width -30, 110);
  
}

void turnPoints(){
  rect(205, 585, 30, 30);
  rect(215, 165, 30, 30);
  rect(580, 163, 30, 30);
  rect(600, 585, 30, 30);
  rect(910, 585, 30, 30);
  rect(910, 340, 30, 30);
  
  rect(1170,300, 60, 99);
}
