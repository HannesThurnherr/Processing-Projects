

boolean attp =true;

void setup(){
  size(1000, 1000);

}
  ArrayList<Node> nodes = new ArrayList();

  Node n = new Node();

void draw(){
  background(50);
  for(int i = 0; i<nodes.size(); i++){
    n=nodes.get(i);
  
  if(attp){
  n.show();
  n.update();
  }
  push();
  stroke(255);
  if(i<nodes.size()-1){
    drawCurve(nodes.get(i),nodes.get(i+1));
  }
  pop();
  }
  
  push();
  fill(0,200,200);
  rect(0,0,150,50);
  rect(150,0,150,50);
  fill(50);
  if(attp){fill(0,200,0);}
  rect(300,0,150,50);
  pop();
  
  fill(0);
  text("Generate Node", 20, 20);
  text("Clean Slate", 170, 20);
  
  text("toggle Points", 320, 20);
}


void mouseDragged(){
  
  for(int i = 0; i<nodes.size(); i++){
  
  Node ve=nodes.get(i);
  if(abs(ve.posx-mouseX)<30 && abs(ve.posy-mouseY)<30){
    ve.posx=mouseX;
    ve.posy=mouseY;
 }
if(ve.prev!=null){
   Gnode v1 = ve.prev;  
  if(abs((v1.pos.x+ve.posx)-mouseX)<40 && abs(abs(v1.pos.y+ve.posy)-mouseY)<30){
    v1.pos.x=mouseX-ve.posx;
    v1.pos.y=mouseY-ve.posy;
 }
}
 
 if(ve.post!=null){
 Gnode v2 = ve.post;
  if(abs((v2.pos.x+ve.posx)-mouseX)<40 && abs(abs(v2.pos.y+ve.posy)-mouseY)<30){
    v2.pos.x=mouseX-ve.posx;
    v2.pos.y=mouseY-ve.posy;
    }
  }
 }
}


void mouseClicked(){
  if(mouseX<150&&mouseY<50){
    if(nodes.size()==0){
      n = new Node();
      nodes.add(n);
    }else{
      nodes.get(nodes.size()-1).post=new Gnode();
      n = new Node();
      nodes.add(n);
      n.prev=new Gnode();
    }
  }
  if(mouseX>150&&mouseX<300&&mouseY<50){
    nodes.removeAll(nodes);
  }
  if(mouseX>300&&mouseX<450&&mouseY<50){
    if(attp){attp=false;}else{attp=true;}
  }
  
}


float[] lerp(float x1, float y1, float x2, float y2, float t){
  float x = x1+t*(x2-x1);
  float y = y1+t*(y2-y1);
  
  float[] out = {x, y};
  return out;
}












void drawCurve(Node c1, Node c2){
 

  
  for(int i = 0; i<100; i++){
     float t = 0.01*i;
     
     float[] p1 = lerp(c1.posx, c1.posy, c1.post.posx, c1.post.posy, t);
     float[] p2 = lerp(c1.post.posx, c1.post.posy, c2.prev.posx, c2.prev.posy, t);
     float[] p3 = lerp(c2.prev.posx, c2.prev.posy, c2.posx, c2.posy, t);
     
     float[] v1 = lerp(p1[0], p1[1], p2[0], p2[1],t );
     float[] v2 = lerp(p2[0], p2[1], p3[0], p3[1],t );
     
     float[] t1 = lerp(v1[0], v1[1], v2[0], v2[1],t );
     float[] t2 = lerp(v1[0], v1[1], v2[0], v2[1],t+0.03 );
     
     line(t1[0], t1[1], t2[0], t2[1]);
  
}
   
}
