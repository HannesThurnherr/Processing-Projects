class Node{
  private float posx = 500;
  private float posy = 500;
  
 int speed = 4;
 int r = 10;
  
  private float velx = random(-speed, speed);
  private float vely = random(-speed, speed);
  
  
  
  
  private Node[] connections;
  
  
  public void show(){
    circle(posx, posy, r);
  }
  
  void fill(int in){
  connections = new Node[in]; 
   for(int i = 0; i<in; i++){
     connections[i]=nodes[floor(random(0,nodes.length))]; 
   }
  }
  public void drawcon(){
  strokeWeight(0.5);
    if(connections.length>0){
  for(int i = 0; i<connections.length; i++){
    if(!(connections[i].getposx()<0|| connections[i].getposx()>1000)&&!(connections[i].getposy()<0|| connections[i].getposy()>1000)){
    line(this.posx, this.posy, connections[i].getposx(), connections[i].getposy());
    
    }
   
    
    
    
      }
    }
  }
  
  public float getposx(){
  return this.posx;
  }
  
  public float getposy(){
  return this.posy;
  }
  
  public int getr(){return r;}
   
  public void update(){
    this.posx+=this.velx;
    this.posy+=this.vely;
    
    //if(this.posx<0-r|| this.posx>1000+r){velx*=-1;}
   // if(this.posy<0-r|| this.posy>1000+r){vely*=-1;} 
  } 
}
