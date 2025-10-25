class Enemies{
  float x, y;
  float speed;
  int health;
  color c; 
  PImage enem; 
  
  
  
void Enemy(float startX, float startY, float spd, int hp, color col){
   x = startX;
   y = startY;
   speed = spd;
   health = hp;
   c = col;

}

void update(){
  x += speed;
}

void setup(){
  enem = loadImage("");
  enem.resize(0, 0);
  
}


void display() {
     image(enem,0, 0);
  }

  // Damage the enemy
  void takeDamage(int dmg) {
    health -= dmg;
  }

  // Check if dead
  boolean isDead() {
    return health <= 0;
  }








}
