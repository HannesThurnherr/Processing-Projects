
LineDraw[] lineDraws;
DiffEq eq;


boolean onlyOne;
boolean randomize;

void setup(){
  pixelDensity(displayDensity());
  onlyOne = false;
  randomize = true;
  background(0);
  int res = 80;
  lineDraws = new LineDraw[(int)sq(res)];
  
  frameRate(60);
  eq= new DiffEq();
for(int i = 0; i<res; i++){
  for(int j = 0; j<res; j++){
    if(!randomize){
      lineDraws[(i*res)+j]=new LineDraw(-(width/2)+((i*width)/res), -(height/2)+((j*height)/res), eq);
    }else{
      lineDraws[(i*res)+j]=new LineDraw(random(-(width/2),width/2), random(-(height/2), height/2), eq);
    }
  }
}
size(1730, 1050);

}

void draw(){
  //background(255);
  push();
  fill(0,0,0,100);
  rect(0,0,width,height);
  pop();
  translate(width/2, height/2);
  if(frameCount==1){
  
  }
  
  if(frameCount>1&&onlyOne){
    lineDraws[lineDraws.length/2-100].show();
    lineDraws[lineDraws.length/2-100].update();
    
    
    if(lineDraws[lineDraws.length/2-100].posx<-width/2||lineDraws[lineDraws.length/2-100].posx>width/2||lineDraws[lineDraws.length/2-100].posy>height/2||lineDraws[lineDraws.length/2-100].posy<-width/2||lineDraws[lineDraws.length/2-100].vLength<0.001){
      lineDraws[lineDraws.length/2-100].posx=random(-width/2,width/2);
      lineDraws[lineDraws.length/2-100].posy=random(-height/2,height/2);
      //lineDraws[lineDraws.length/2-100].arrowNotDrawn=true;
    }
    
    
    
  }else{

  for(int i = 0; i<lineDraws.length; i++){
    lineDraws[i].show();
    lineDraws[i].update();
    
    if(lineDraws[i].posx<-width/2||lineDraws[i].posx>width/2||lineDraws[i].posy>height/2||lineDraws[i].posy<-width/2||lineDraws[i].vLength<0.1){
      lineDraws[i].posx=random(-width/2,width/2);
      lineDraws[i].posy=random(-height/2,height/2);
      //lineDraws[i].arrowNotDrawn=true;
    }
  }
  }


}

void grid(){

  push();
  stroke(150);
  translate(-width/2,-height/2);
  strokeWeight(4);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  pop();
}


float function(float in){
  float out = sin(in/5)*200;
  return out;
}
