
ArrayList<Body> bodies;

Boolean makingBody = false;
Boolean finishedBody = false;

float startX = 0;
float startY = 0;
float startVX = 0;
float startVY = 0;
float startMass = 0;

void setup(){
  size(1000, 1000);
  bodies = new ArrayList();
  bodies.add(new Body(500, 500, 0, 0, 20));
  bodies.add(new Body(400, 200, 8, 0, 8));
  bodies.add(new Body(600, 800, -5, 0, 9));
  bodies.add(new Body(600, 750, -3, 0, 2));
}

void draw(){
  background(100, 100, 100, 100);
  for(int i = 0; i<bodies.size(); i++){
    bodies.get(i).update(bodies);
  }
  for(int i = 0; i<bodies.size(); i++){
   // println("body "+i+"is at "+bodies.get(i).posx+", "+bodies.get(i).posy); 
    bodies.get(i).updatePos();
    bodies.get(i).show();
  }
  
  if(makingBody&&!finishedBody){
    line(startX, startY, mouseX, mouseY);
  }else if(makingBody&&finishedBody){
    circle(startX, startY, startMass);
    line(startX-10*startVX, startY-10*startVY, mouseX, mouseY); 
    line(startX, startY, startX-10*startVX, startY-10*startVY);
    startMass = sqrt(sq(startX-startVX*10-mouseX)+sq(startY-startVY*10-mouseY))/5;
    
  }
  
  
}

void mouseClicked(){
  if(!makingBody){
    startX=mouseX;
    startY=mouseY;
    makingBody = true;
    finishedBody = false;
    println(startX);
  }else if(!finishedBody){
    startVX=(startX-mouseX)/10;
    startVY=(startY-mouseY)/10;
    
    finishedBody=true;
  }else{
    startMass = sqrt(sq(startX-startVX*10-mouseX)+sq(startY-startVY*10-mouseY))/5;
    bodies.add(new Body(startX, startY, startVX, startVY, startMass));
    finishedBody=false;
    makingBody=false;
    println("Starting Mass: "+startMass);
  }
}
