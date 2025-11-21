//Imports
import processing.sound.*;
import processing.video.*;
//Final Variables
color mapBackground = color(200, 150, 100);


//Class types
Enemy enem;
Projectiles proj;
Towers tower;
Movie myVideo;




//Game Variables

PFont pixel;
PImage curs; 
PImage tower1Rest;
PImage tower2Rest;
PImage tower3Rest;
PImage startScreen;
PImage mapBackground1;
PImage enemySprite; 
PImage strawTowerSprite;
PImage chocTowerSprite;
PImage vanTowerSprite;
PImage towerShot;
PImage activeTower;
PImage activeTowerRest;
PImage boss1;
PGraphics buildMap;
boolean gameStarted = false;
boolean gameEnded = false;
boolean gamePaused = true;
boolean test = false;
boolean TowerSelected = false;
boolean waveActive = true;
boolean placeVisible = false;
boolean rangeShow = true;
boolean bossSpawned = false;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Towers> towers = new ArrayList<Towers>();
ArrayList<PVector> path = new ArrayList<PVector>();
ArrayList<Projectiles> projectiles = new ArrayList<Projectiles>();
int map1StartX = 0;
int map1StartY = 585;
int wave = 1;
int spawnTimer = 90; 
int enemySpawned = 0;
int enemyPerWave = 5;
int Money = 300;
int price = 0;
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

 
 myVideo = new Movie(this, "startingScreen.mp4");
 myVideo.loop();
 
 //Testing loop for how many enemies spawn

}

void draw(){
  cursor(curs, 0, 0);
  if(wave >= 10){
  test = true; 
 }
  if(gameStarted){
    image(buildMap, 0, 0);
    drawUi();
    turnPoints();
    waveHandler();
    enemyHandler();
    towerMouseVisual();
    placeSpace();
    projectileHandler();
   for(Towers t : towers){
     
     t.target = t.findTarget(enemies);
     
     if(t.target != null){
        t.shoot(projectiles); 
       }
       t.display();
   }
  }else{
  image(myVideo, 0, 0, width, height);
  }
 
  
 if(TowerSelected){
  textSize(24);
  text("Press X to cancel ", 500, 650 ); 
 }
}

void movieEvent(Movie m){
 m.read(); 
}

void mouseClicked(){        //All mouse clicked events
  gameStarted = true;
  clickDetection();
  print(waveActive);
}

void clickDetection(){ // UI click detection
 if((mouseX >= 250 && mouseX <= 450 && mouseY >= 685 && mouseY <=775)&& Money >= 150){ //StrawBerry UI 
   println("Strawberry Tower Selected");
   activeTower = strawTowerSprite;
   activeTowerRest = tower1Rest;
   TowerSelected = true;
   price = 150;
 }
 
 if((mouseX >= 500 && mouseX <= 700 && mouseY >= 685 && mouseY <= 775)&&Money >= 125){ //Vanilla UI
   println("Vanilla Tower Selected");
   activeTower = vanTowerSprite;
   activeTowerRest = tower3Rest;
   TowerSelected = true;
   price = 125;
 }
 
 if((mouseX >= 750 && mouseX <= 950 && mouseY >= 685 && mouseY <= 775) && Money >= 100){ //Chocolate UI
  println("Chocolate Tower Selected"); 
  activeTower = chocTowerSprite;
  activeTowerRest = tower2Rest;
  TowerSelected = true;
  price = 100;
 }
 
 if((mouseX >= 1000 && mouseX <= 1100 && mouseY >= 685 && mouseY <= 775)){ //Settings UI
  println("Opening Settings"); 
 } 
 
 if(mouseX >= 500 && mouseX <= 680 && mouseY >= 20 && mouseY <= 60 && waveActive == false){
   waveActive = true;
   wave++;
   enemySpawned = 0;
   enemyPerWave += 3;
 }
 
 if(TowerSelected){
    if(mouseX >= 0 && mouseX <= 180 && mouseY >= 0 && mouseY <= 560){
      towerHandler();
      
    }
    if(mouseX >= 0 && mouseX <= 1000 && mouseY >= 0 && mouseY <= 120){ 
       towerHandler();
    }
    if(mouseX >= 660 && mouseX <= 880 && mouseY >= 0 && mouseY <= 560){ 
      towerHandler();
    }
    if(mouseX >= 660 && mouseX <= 1200 && mouseY >= 50 && mouseY <= 300){
       towerHandler();
    }
    if(mouseX >= 280 && mouseX <= 560 && mouseY >= 240 && mouseY <= 675){
       towerHandler();
    }
    if(mouseX >= 1000 && mouseX <= 1250 && mouseY >= 400 && mouseY<= 675){
       towerHandler();
    }
 }
 
 
}


void towerMouseVisual(){
  if(TowerSelected && activeTower != null){
    if(activeTower == strawTowerSprite){
     image(activeTower, mouseX - 50, mouseY - 50);
    }else if(activeTower == chocTowerSprite){
     image(activeTower, mouseX - 50, mouseY - 80);
    }else if(activeTower == vanTowerSprite){
     image(activeTower, mouseX - 50, mouseY - 80); 
    }
   }  
 }



void drawUi(){              //Displays all UI in the game
  ScreenUi();
  shopUi();
}


void ScreenUi(){           //Creates the UI Layout for the main game
  fill(150, 100, 80);
  rect(15, 675, width -30, 110);
}


void waveUI(){
 fill(150, 100, 80);
 rect(1090, 20, 100, 32);
 
 fill(0);
 textSize(24);
 textFont(pixel);
 text("Wave: ", 1095, 45); 
 text(wave,1165, 45);
}

void waveHandler(){
  waveUI();
  if(wave > 15){
   wave = 0; 
  }
  
   if(enemies.isEmpty() && (enemySpawned >= enemyPerWave)){
    waveActive = false;
  }
  
   if(waveActive == false){
     fill(150, 100, 80);
     rect(500, 20, 180, 40); 
   
     fill(0);
     textSize(24);
     textFont(pixel);
     text("Start Wave ", 505, 50);
     text(wave+1, 650, 50);
    }

}

void projectileHandler(){
 for(int i = projectiles.size() -1; i >= 0; i--){
  Projectiles p = projectiles.get(i);
  p.update();
  p.display();
  
  if(dist(p.pos.x, p.pos.y, p.target.pos.x, p.target.pos.y) < 10){
    p.target.takeDamage(p.damage()); 
    projectiles.remove(i);
  }
   
 }
  
  
}



void towerHandler(){
  if(TowerSelected && activeTower != null){
  
    if(Money >= price){
        Towers t = new Towers(mouseX, mouseY, activeTower, activeTowerRest);
        towers.add(t);
        Money -= price;
    }else{
     print("Not Enough Money"); 
    }
  
    for (Towers T : towers) {
   // T.findTarget(enemies);        // look for enemies
    //T.shoot(projectiles);         // shoot if possible
    T.display();                  // draw the tower + range
}
  }


}

void enemyHandler(){

  
  if(frameCount%spawnTimer == 0&& enemySpawned < enemyPerWave && waveActive){ 
     
   Enemy e = new Enemy(0,map1StartY - 35, 1 , 5, enemySprite); 
   enemies.add(e);
   enemySpawned++;
 }
 /*
 if(wave == 15 && enemySpawned >= enemyPerWave && !bossSpawned && waveActive){
   if(enemySpawned == 5){
        speed = 3; 
      }else{
        speed = 1; 
      }
    Enemy boss = new Enemy(0, map1StartY - 35, speed, 25, boss1);
    enemies.add(boss);
    bossSpawned = true;
    boss.update(path);
    boss.display();
  }
   */   
  for(int i = enemies.size() -1; i >= 0; i--){
     Enemy e = enemies.get(i);
     e.update(path);
     e.display();
     if(e.isDead()){
       Money += 20;
       enemies.remove(e);
     }
  }
 
}





  
void turnPoints(){          //Creates Every turning point for the first map and makes them not show 
  path.add(new PVector(205, 545));
  path.add(new PVector(215, 115));
  path.add(new PVector(580, 123));
  path.add(new PVector(600,555));
  path.add(new PVector(910, 555));
  path.add(new PVector(910, 320));
  path.add(new PVector(1170, 300));
}

void ImageHandler(){ 
 pixel = createFont("Assets/PixelColeco.ttf", 24);
 mapBackground1 = loadImage("Assets/TempMap.png");
 startScreen = loadImage("Assets/startScreen.png");
 
 enemySprite = loadImage("Assets/TempEnemy.png");
 strawTowerSprite = loadImage("Assets/tower_1_angry.png");
 chocTowerSprite = loadImage("Assets/chocolateTowerAngry1.png");
 vanTowerSprite = loadImage("Assets/vanTower1.png");
 
 tower1Rest = loadImage("Assets/tower_1_neutral.png");
 tower2Rest = loadImage("Assets/chocolateTowerIdel1.png");
 tower3Rest = loadImage("Assets/vanillaTowerIdle1.png");

 boss1 = loadImage("Assets/boss1.png");
 towerShot = loadImage("Assets/ice_cream_shot.png");
 curs = loadImage("Assets/cursor.png"); 
 
 
}

void keyPressed(){
 if(TowerSelected && (key == 'x' || key =='X')){
   TowerSelected = false;
 }
 
 if(key == 'h' && placeVisible == false){
  placeVisible = true; 
 }
 
 if(key == 'z'){
   placeVisible = false;
 }

}



void shopUi(){
 fill(150, 0, 0);
 rect(250, 685, 200, 90); 
 
 fill(250, 0, 250);
 rect(500, 685, 200, 90); 
 
 fill(200, 95, 0);
 rect(750, 685, 200, 90); 
 
 fill(0, 150, 0);
 rect(1000, 685, 100, 90); 
 

 fill(255, 255,255);
 rect(75, 685, 130, 30);

 
 
 textFont(pixel);
 textSize(20);
 text("StrawBerry Tower \n \t     $150", 257, 735);
 text("Vanilla Tower \n \t \t  $125", 525, 735);
 text("Chocolate Tower \n \t \t  $100", 765, 735);
 fill(0);
 text("Money: ", 80, 707);
 text(Money, 150, 707);
 fill(0,0,0);
 text("Settings", 1005, 735);
}

void placeSpace(){
 if(placeVisible){
   rect(0, 0, 180, 560);
   rect(0, 0, 1000, 120);
   rect(660,0,220, 560);
   rect(660, 50, 550, 250);
   rect(280, 240, 280, 435);
   rect(1000, 400, 250, 275);
 }

  
}
