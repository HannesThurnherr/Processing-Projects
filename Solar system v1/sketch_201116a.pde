

ArrayList<Body> bodies = new ArrayList<Body>();

double g = 0.001;

void setup(){

 size(1200,1200);
 
/* for(int i = 0; i<30; i++){
   
   if(random(0,1)<0.5){
 bodies.add(new Body(0,0,0, 1));
   }else{
      bodies.add(new Body(0,0,0, -1));
   }
 }*/
 
 bodies.add(new Body(100, width/2, height/2, 0));
}




void draw(){
  

 background(0);
 
  
  for(int i = 0; i<bodies.size(); i++){
   
    
    
    for(int j = 0; j<bodies.size(); j++){
    if(j!=i){
    
        double distx = bodies.get(j).posx-bodies.get(i).posx;
        double disty = bodies.get(j).posy-bodies.get(i).posy;
        double dist = Math.pow(Math.pow(distx, 2)+Math.pow(disty, 2), 0.5);    
    
        double netf = (bodies.get(i).mass*bodies.get(j).mass)/(dist*dist);
        
        double fx = (distx/dist)*netf;
        double fy = (disty/dist)*netf;
        if(dist>10){
        bodies.get(i).setfo(bodies.get(i).accx+fx*g, bodies.get(i).accy+fy*g);
        }
     
    }
    }    
    
      bodies.get(i).update();
      
    //  pushMatrix();
     // translate(bodies.get(0).posx, bodies.get(0).posy);
     
     //translate((width/2)-bodies.get(0).posx,(height/2)-bodies.get(0).posy);
    bodies.get(i).show();
    // popMatrix();
    
  }
}


void mouseClicked(){

  //if(mouseY<bodies.get(0).posy){
      bodies.add(new Body(0,mouseX,mouseY, 3));
  // }else{
    //  bodies.add(new Body(0,mouseX+(width/2),mouseY+(height/2), 0));
      
   //}
 }
