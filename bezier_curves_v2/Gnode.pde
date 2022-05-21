class Gnode{
 
  PVector pos;
  float posx;
  float posy;
  
  Gnode(float x, float y){
    pos=new PVector(x,y);
  }
  
  
  Gnode(){
    pos=new PVector(random(-100,100),random(-100,100));
    posx=pos.x;
    posy=pos.y;
  }
  
  
  void show(float x, float y){
    push();
    fill(100,255,255);
    circle(x+pos.x,y+pos.y, 5);
    pop();
    posx=x+pos.x;
    posy=y+pos.y;
  }
  

  
  
}
