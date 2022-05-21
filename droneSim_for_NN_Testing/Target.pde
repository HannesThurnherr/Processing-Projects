class Target{

  PVector pos;
  float diameter;
  
  public Target(float x, float y, float dia){
    pos=new PVector(x,y);
    diameter = dia;
  }
  
  
  void relocate(){
     pos.x=250+(random(400));
     pos.y=300+(random(500));
  }
  
  
  void show(){
    push();
    fill(255, 0,0);
    circle(pos.x, pos.y, diameter);
    pop();
  }
  
  
  
}
