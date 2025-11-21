class Projectiles{
  PVector pos;
  PImage bullet = towerShot;
  int type = 0;
  Enemy target = null; 
  Projectiles(float x, float y, Enemy attack, int dmg){
    pos = new PVector(x, y);
    target = attack;
    type = dmg;
  }
    
    void display(){
      image(bullet, this.pos.x, this.pos.y);
    }
    
    
    void update(){
     if(target == null) return;
     
     PVector dir = PVector.sub(target.pos, pos);
     dir.normalize();
     dir.mult(8);
     pos.add(dir);
    }

    public int damage(){
      
      return type;
    }
}
