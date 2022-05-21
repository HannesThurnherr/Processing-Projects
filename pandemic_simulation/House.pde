class House{
  
  float x;
  float y;
  float w;
  float h;
  
  House(float posx,float posy,float  wid,float hei){
    this.x = posx;
    this.y = posy;
    this.w = wid;
    this.h = hei;
  }
  
  
  Room[] rooms;
  
  void fillHouse(int cap){
    rooms = new Room[cap];
    for(int i = 0; i<cap; i++){
      rooms[i]= new Room(i*(w)/cap,0, (w)/cap, h);
    }
  }
  
  void show(){

    rect(x-2, y-2, w+4, h+4);
    for(Room i: rooms){
      i.show(x,y);
    }
  }
  
  void persExit(Person x){
    for(int i = 0; i<rooms.length; i++){
      if(rooms[i].people.contains(x)){
       rooms[i].people.remove(x);
       return;
      }
    }
  }
  
  void checkTransmission(float prob){
    for(int i = 0; i<rooms.length; i++){
      for(int j = 0; j<rooms[i].people.size(); j++){
        if(rooms[i].people.get(j).inf){
          for(int k = 0; k<rooms[i].people.size(); k++){
            if(random(0,1)<prob){
              if(!rooms[i].people.get(k).inf&&!rooms[i].people.get(k).immune){
                rooms[i].people.get(k).inf=true;
                rooms[i].people.get(k).timeOfInfection = frameCount;      
              }
            }
          }
        }
      }
    }
  }
  
  
}
