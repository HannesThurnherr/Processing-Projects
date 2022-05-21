class Circle{

  float posx = random(0,1000);
  float posy = random(0,1000);
  
  
  Circle(float x, float y){
    posx=x;
    posy=y;
  }
  
  Circle(){

  }

  void show(){
    circle(posx, posy, 5);
  }
  
  
  
  
  
}
