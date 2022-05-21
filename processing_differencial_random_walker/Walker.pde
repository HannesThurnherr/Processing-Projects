class Walker{
  PVector pos = new PVector(500, 500);
  float prevposx = pos.x;
  float prevposy =pos.y;
  PVector speed = new PVector(0, 20);
  
  float dir = 0;
  
   void update(){
    prevposx = pos.x;
    prevposy =pos.y;
    
    pos=pos.add(speed.rotate(dir));
    
    
   }
   
   void show(){
     //circle(this.posx, this.posy, 15);
     
    push();
    translate(pos.x,pos.y);
    rotate(dir);
        // circle(0, 0, 1);
         // line(0, 0, pos.x-prevposx, pos.y-prevposy);

     fill(0);
     
     //this.grid(10);
       pop();
       
       // circle(0, 0, 1);
        line(pos.x, pos.y, prevposx, prevposy);
       
       text("posx: "+pos.x, 30,30);
       text("posy: "+pos.y, 30,50);
       text("dir: "+dir, 30,70);
       
       dir+=0.1450001;
    
   }
  
  void grid(int in){
    for(int i = 1; i<in; i++){
      line(0, height/in*i, width, height/in*i);
       line(width/in*i, 0, width/in*i, height); 
    }
  }
  
  

}
