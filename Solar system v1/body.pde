class Body{
  
  



double r;
double posx;
double posy;
double mass;
double velx;
double vely = 0;
double accx = 0;
double accy = 0;





 Body(double size, double x, double y, double vel){
   if(size>0){r = size;}else{
   r = random(10, 50);}
   if(x>-1){posx = x;}else{
   posx = random(100, 800);}
   if(y>-1){posy = y;}else{
   posy = random(100, 800);}
   mass = 4*r*r*r;
   
   velx=vel;
  }


public void setfo(double forcex, double forcey){
accx=forcex;
accy=forcey;
}


public void show(){

circle((float)posx, (float)posy, (float)r);
}



public void update(){
  
  
   
  vely += accy/mass;
  velx += accx/mass;
  
  posy += vely;
  posx += velx;
  
  accx = 0;
  accy = 0;
}

}
