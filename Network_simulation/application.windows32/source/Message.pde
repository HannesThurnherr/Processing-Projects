class Message{


boolean reached = false;
Node destination;
Node finalDestination;
Node sender;
Node origin;
String content;
int hopCount = 0;
float t = 0;

float posx;
float posy;
int r=0;
int g=255;
int b=0;

Message(Node dest, Node finDest, Node orig, Node sen, String con){
  this.destination = dest;
  this.finalDestination = finDest;
  this.origin = orig;
  this.sender = sen;
  this.content = con;
  this.r = (int)random(0,255);
  this.g = (int)random(0,255);
  this.b = (int)random(0,255);
  posx=sender.posx;
  posy=sender.posy;
  
  if(dest==sen){this.t=1;}
}

void update(ArrayList<Node> nodes, int speed){
  t+=0.005*speed;
  posx=sender.posx+t*(destination.posx-sender.posx);
  posy=sender.posy+t*(destination.posy-sender.posy);
  
  if(t>=1){
    destination.handle(this, nodes);
  }
}

void show(){
  push();
  fill(r,g,b);
  circle(posx, posy, 10);
  pop();
}




}
