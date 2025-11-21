class Towers{
  PShape range; 
  PVector pos;
  PImage towerSprite; 
  PImage towerRest;
  float rangeRadius = 150;  // range in pixels
  Enemy target = null;      // current enemy target
  int lastShotTime = 0;     // track shooting delay
  int fireRate = 1000;  
  Projectiles projectiles;
  int radius;
  int damage; 
  
  
  
  
  Towers(float x , float y, PImage s, PImage rest){
     pos = new PVector(x, y); 
     towerSprite = s;
     towerRest = rest;
     noFill();
     stroke(1,1,1);
     strokeWeight(.3);
     if(towerSprite == strawTowerSprite){
       radius = 350;
       fireRate = 450;
     }else if(towerSprite == chocTowerSprite){
      radius = 500; 
      fireRate = 1500;
     }else if(towerSprite == vanTowerSprite){
      radius = 290; 
      fireRate = 300;         
     }
     range = createShape(ELLIPSE, this.pos.x, this.pos.y, radius, radius);
  
  }
  
  void display(){

    if(towerSprite == strawTowerSprite){
      damage = 10;
      if(target == null){
       image(towerRest, this.pos.x -50, this.pos.y - 50); 
      }else{
       image(towerSprite, this.pos.x - 50, this.pos.y - 50); 
      }
       shape(this.range);
    }else if(towerSprite == chocTowerSprite){
      damage = 25;
      if(target == null){
       image(towerRest, this.pos.x - 50, this.pos.y - 80); 
      }else{
      image(towerSprite, this.pos.x - 50, this.pos.y - 80);
      }
       shape(this.range);
    }else if(towerSprite == vanTowerSprite){
      damage = 2;
      if(target == null){
       image(towerRest, this.pos.x - 50, this.pos.y - 80); 
      }else{
       image(towerSprite, this.pos.x - 50, this.pos.y - 80);
      }
     shape(this.range);
    }
  
  }
  
  Enemy findTarget(ArrayList<Enemy> enemies){
    float closestDist = 9999999;
    Enemy closestEnemy = null;
    
    for(Enemy e : enemies){
     float d = dist(pos.x, pos.y, e.pos.x, e.pos.y);
     
     
     if(d < radius/2){
       closestDist = d;
       closestEnemy = e;
      }
    }
     return closestEnemy;
  }
  void shoot(ArrayList<Projectiles> projectiles){
    if(target == null) return;
    if(millis() - lastShotTime < fireRate) return;
    
    projectiles.add(new Projectiles(pos.x, pos.y, target, damage));
    
    lastShotTime = millis();
  }

}
