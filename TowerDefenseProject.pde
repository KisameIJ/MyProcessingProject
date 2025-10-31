//Imports
import processing.sound.*;
//Final Variables
color mapBackground = color(200, 150, 100);


//Class types
Enemy enem;
Projectiles proj;
Towers tower;





//Game Variables
PImage tower1Rest;
PImage startScreen;
PFont pixel;
PImage mapBackground1;
PImage enemySprite; 
PImage towerSprite;
PGraphics buildMap;
boolean gameStarted = false;
boolean gameEnded = false;
boolean gamePaused = true;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Towers> towers = new ArrayList<Towers>();
int map1StartX = 0;
int map1StartY = 585;
int wave = 0;
ArrayList<PVector> path = new ArrayList<PVector>();
boolean test = false;
int spawnTimer = 60; 
int enemySpawned = 0;
int enemyPerWave = 5;

void setup(){
 size(1200, 800);
//All Assets that are loaded run through the setup at the very launch of the program.
// SoundFile music = new SoundFile(this, "Assets/firstPick.wav");
ImageHandler();
 //Creates the Map
  buildMap = createGraphics(width, height);
 buildMap.beginDraw();
 buildMap.image(mapBackground1, 0, 0, width, height);
 buildMap.endDraw();
 
 
 
 //Testing loop for how many enemies spawn

}

void draw(){
  if(wave >= 10){
  test = true; 
 }
  print(test);
  if(gameStarted){
    image(buildMap, 0, 0);
    drawUi();
    turnPoints();
    waveHandler();
    enemyHandler();
   for(Towers t : towers){
     t.display();
    }
  }else{
  image(startScreen, 0, 0, width, height);
  }
  
}



void mouseClicked(){        //All mouse clicked events
  gameStarted = true;
  if(gameStarted){
      towerHandler();
  }
}


void drawUi(){              //Displays all UI in the game
  ScreenUi();
  towerUi();
}


void ScreenUi(){           //Creates the UI Layout for the main game
  fill(150, 100, 80);
  rect(15, 675, width -30, 110);
}

void waveText(){  
 fill(0);
 textSize(24);
 textFont(pixel);
 text("Wave: ", 1095, 45); 
 text(wave,1165, 45);
}

void waveUI(){
 fill(150, 100, 80);
 rect(1090, 20, 100, 32);
}

void waveHandler(){
  waveUI();
  waveText();
  if(wave > 15){
   wave = 0; 
  }
}

void towerHandler(){

  Towers t = new Towers(mouseX, mouseY, towerSprite, tower1Rest);
  towers.add(t);
}

void enemyHandler(){
  if(frameCount%spawnTimer == 0&& enemySpawned < enemyPerWave){ 
   Enemy e = new Enemy(0,map1StartY, 1, 50, enemySprite); 
   enemies.add(e);
   enemySpawned++;
 }
  for(Enemy e : enemies){   //Loops methods for each enemy
     e.update(path);
     e.display();
  } 
}

  
void turnPoints(){          //Creates Every turning point for the first map and makes them not show 
  path.add(new PVector(205, 585));
  path.add(new PVector(215, 155));
  path.add(new PVector(580, 163));
  path.add(new PVector(600,585));
  path.add(new PVector(910, 585));
  path.add(new PVector(910, 340));
  path.add(new PVector(1170, 300));
}

void ImageHandler(){ 
 pixel = createFont("Assets/PixelColeco.ttf", 24);
 mapBackground1 = loadImage("Assets/TempMap.png");
 enemySprite = loadImage("Assets/TempEnemy.png");
 startScreen = loadImage("Assets/startScreen.png");
 towerSprite = loadImage("Assets/tower_1_angry.png");
 tower1Rest = loadImage("Assets/tower_1_neutral.png");
}

void towerUi(){
 fill(150, 0, 0);
 rect(250, 685, 200, 90); 
 
 fill(250, 0, 250);
 rect(500, 685, 200, 90); 
 
 fill(200, 95, 0);
 rect(750, 685, 200, 90); 
 
 fill(0, 150, 0);
 rect(1000, 685, 100, 90); 
}
