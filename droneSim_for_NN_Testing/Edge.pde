class Edge{
 
  float weight;
  float colorShift;
  
  public Edge( float fac, float pF){
    weight = fac;
    colorShift = (weight+pF)*(250.0/(2*pF));
  }
  
  void show(float inx,float iny,float outx,float outy){
    push();
    stroke(250-colorShift,0.5*colorShift,colorShift, 150);
    strokeWeight(3);
    line(inx, iny, outx, outy);
    pop();
  }
  
  void mutate(float amount){
    
    
    weight+=random(-amount, amount);
    colorShift = (weight+10)*12.5;
   
  }
  
  void setWeight(float in){
    weight=in;
  }


}
