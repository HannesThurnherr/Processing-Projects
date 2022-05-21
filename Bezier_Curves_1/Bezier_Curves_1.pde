void setup() {  // setup() runs once
  size(1000, 1000);
  frameRate(60);
  background(255);
  


}

  Circle ve;
  
  ArrayList<Circle> circles = new ArrayList();
  
  
  
void draw(){
  background(255);
  
  
  push();
  fill(0,200,200);
  rect(0,0,150,50);
  pop();
  
  fill(0);
  text("generate circle", 20, 20);
  
   for(int i = 0; i<circles.size()-2; i++){
      circles.get(i).show();
   }
   
   if(circles.size()>3){
     
    for(int i = 0; i<circles.size()-3; i+=3){
  drawCurve(circles.get(i), circles.get(i+1), circles.get(i+2),circles.get(i+3));
    }
   }
}









void mouseDragged(){
  
  for(int i = 0; i<circles.size(); i++){
  
  ve=circles.get(i);
  if(abs(ve.posx-mouseX)<30 && abs(ve.posy-mouseY)<30){
    ve.posx=mouseX;
    ve.posy=mouseY;
  }
 }
}


void mouseClicked(){
  if(mouseX<150&&mouseY<50){
    if(circles.size()>0){
    circles.add(new Circle());
    }else{
    circles.add(new Circle());
    }
    circles.add(new Circle());
    circles.add(new Circle());
  }
}



void drawCurve(Circle cir1, Circle cir2, Circle cir3, Circle cir4){
 
  Circle c1=cir1;
  Circle c2=cir2;
  Circle c3=cir3;
  Circle c4=cir4;
  
  line(c1.posx, c1.posy, c2.posx, c2.posy);
  
  line(c3.posx, c3.posy, c4.posx, c4.posy);
  
  for(int i = 0; i<100; i++){
     float t = 0.01*i;
     
     float[] p1 = lerp(c1.posx, c1.posy, c2.posx, c2.posy, t);
     float[] p2 = lerp(c2.posx, c2.posy, c3.posx, c3.posy, t);
     float[] p3 = lerp(c3.posx, c3.posy, c4.posx, c4.posy, t);
     
     float[] v1 = lerp(p1[0], p1[1], p2[0], p2[1],t );
     float[] v2 = lerp(p2[0], p2[1], p3[0], p3[1],t );
     
     float[] t1 = lerp(v1[0], v1[1], v2[0], v2[1],t );
     float[] t2 = lerp(v1[0], v1[1], v2[0], v2[1],t+0.03 );
     
     line(t1[0], t1[1], t2[0], t2[1]);
     
     
  
}
   
}




float[] lerp(float x1, float y1, float x2, float y2, float t){
  float x = x1+t*(x2-x1);
  float y = y1+t*(y2-y1);
  
  float[] out = {x, y};
  return out;
}
