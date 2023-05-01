class LineDraw{
  float posx;
  float posy;
  DiffEq eq;
  boolean arrowNotDrawn = false;
  float[] futurePos;
  float vLength;
  float colorshift = 80;
  
  
  float vx = 0;
  float vy = 0;

  LineDraw(float psx, float psy, DiffEq e){
    posx = psx;
    posy = psy;
    eq = e;
   
  }
  
  void update(){
     futurePos= eq.eq(posx,posy);
    
    
    posx = futurePos[0];
    posy = futurePos[1];
    
     
  }
  
  void show(){
    futurePos = eq.eq(posx,posy);
    vLength = sqrt(sq(futurePos[0]-posx)+sq(futurePos[1]-posy));
    
    push();
    //strokeWeight(max(0.6,vLength/3));
    strokeWeight(0.6);
    stroke(vLength*colorshift,255-(vLength*colorshift/3),255-vLength*colorshift);
    if(arrowNotDrawn){
      stroke(255);
      strokeWeight(0.3);
      arrow(posx, -posy,futurePos[0],-futurePos[1]);
      arrowNotDrawn=false;
    }else{
      line(posx, -posy,futurePos[0],-futurePos[1]); 
    }
    pop();
    
    
  }
  
  void arrow(float x1, float y1, float x2, float y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -3, -6);
  line(0, 0, 3, -6);
  
  popMatrix();
} 
  


}
