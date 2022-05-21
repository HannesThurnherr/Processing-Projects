class Body{
  float posx;
  float posy;
  
  float velx;
  float vely;
  
  float size;
  float mass;
  
  Body(float x, float y, float vx, float vy, float s){
    this.size = s;
    this.posx = x;
    this.posy = y;
    this.velx = vx;
    this.vely = vy;
    this.mass = 4/3*PI*size*size*size;
  }
  
  void show(){
    circle(this.posx, this.posy, this.size);
  }
  
  void update(ArrayList<Body> bodies){
    
    float forceX=0;
    float forceY=0;
    for(int i = 0; i<bodies.size(); i++){
        if(bodies.get(i)!=this){
          float xdist=this.posx-bodies.get(i).posx;
          float ydist=this.posy-bodies.get(i).posy;
          float r=sqrt(sq(xdist)+sq(ydist));
          float g = 0.1;
          float force = g*bodies.get(i).mass/sq(r);
          
          forceX+=(force/r)*xdist;
          forceY+=(force/r)*ydist;
        }
    }
    
    velx-=forceX;
    vely-=forceY;
  }
  void updatePos(){
    posx+=velx*0.1;
    posy+=vely*0.1;

  }


}
