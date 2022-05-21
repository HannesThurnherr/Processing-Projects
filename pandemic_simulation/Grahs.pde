void graph(ArrayList<Float> cases,float max, float x, float y, float w, float h){
  max = 0;
 for(int i = 0; i<cases.size()-1; i++){
    if(cases.get(i)>max){
      max=cases.get(i);
    }    
  }
  max*=1.2;
  rect(x, y, w, h);
  for(int i = 0; i<cases.size()-1; i++){
    line(x+((float)i/(float)cases.size())*w, y+h-(cases.get(i)/max)*h, x+((float)(i+1)/(float)cases.size())*w, y+h-(cases.get(i+1)/max)*h);
   
  }
  push();
    fill(0);
    text(cases.get(cases.size()-1), x+w-40, y+0.5*h);
    text(max/1.2, x+15, y+15);
    pop();
}
