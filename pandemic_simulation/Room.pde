class Room{
  
  float x;
  float y;
  float w;
  float h;
  
  Room(float posx,float posy,float  wid,float hei){
    this.x = posx;
    this.y = posy;
    this.w = wid;
    this.h = hei;
  }

  ArrayList<Person> people = new ArrayList();
  
  void show(float hx, float hy){
    rect(hx+x, hy+y, w, h);
    
  }
}
