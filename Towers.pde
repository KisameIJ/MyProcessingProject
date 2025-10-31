class Towers{
  PShape range; 
  PVector pos;
  int fireRate;
  PImage towerSprite; 
  PImage towerRest;
  
  Towers(float x , float y, PImage s, PImage rest){
     pos = new PVector(x, y); 
     towerSprite = s;
     towerRest = rest;
     range = createShape(ELLIPSE, this.pos.x, this.pos.y, 200, 200);
  
  }
  
  void display(){
    if(test){
       image(towerSprite, pos.x, pos.y); 
    }else{
      image(towerRest, pos.x, pos.y);
    }

  }

}
