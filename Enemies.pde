class Enemy{
  PShape healthBar;
  PImage sprite;
  PVector pos;
  float speed;
  int health;
  int currentTarget = 0;
 
Enemy(float x, float y, float spd, int hp, PImage s){
   
   pos = new PVector(x, y);
   speed = spd;
   sprite = s;
   health = hp;
   
   fill(0, 100, 0);
}

void update(ArrayList<PVector> path){
  if(currentTarget < path.size()){                //counts for each path
    PVector target = path.get(currentTarget);     //makes each path point the target
    PVector direction = PVector.sub(target, pos); //gets the distance from the current position of the enemy to the position of the next path point
    
    if(direction.mag() < 5){                      //if the length of the enemy to the position of the point is less than 5. Consider collided
     currentTarget++;                             //changes to next point
    }else{
      direction.normalize(); 
      direction.mult(speed);                      //How fast the enemy should get to the next point
      pos.add(direction);                         //Direction to next point
    }
  }
}

void display() {
     image(enemySprite, pos.x, pos.y);

  }

  // Damage the enemy
  void takeDamage(int dmg) {
    health -= dmg;
  }

  // Check if dead
  boolean isDead() {
    if(this.pos.x > 1100 || health <= 0){
     return true ; 
    }else{
     return false; 
    }
  }
}
