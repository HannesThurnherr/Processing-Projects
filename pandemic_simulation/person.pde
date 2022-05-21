class Person{
  float x,y;
  
  Boolean inf;
  Boolean going;
  Boolean isIndoors;
  Boolean immune = false;
  
  House workplace;
  House home;
  Room office;
  Room apt;
  
  int timeOfInfection;
  
  House destination;
  
  float startWork, endWork;
  
  
  
  Person(ArrayList<House> city, float day){
    giveLife(city, day);
    x=home.x+apt.x;
    y=home.y+apt.y;
    apt.people.add(this);
    isIndoors = true;
    going = false;
  }
  
  void giveLife(ArrayList<House> city, float day){
    workplace = city.get(floor(random(0, city.size())));
    home =city.get(floor(random(0, city.size())));
    office = workplace.rooms[floor(random(0, workplace.rooms.length))];
    apt = home.rooms[floor(random(0, home.rooms.length))];
    startWork = random(day/6.0, day/2.0);
    endWork = random(day/2.0, day-day/6.0);
    inf=false;
  }
  
  void show(){
    if(!isIndoors){
      push();
      if(inf){
      fill(255, 0, 0);
      }else if(!immune){
      fill(0, 255, 0);
      }else{
      fill(0,0,255);
      }
      circle(x, y, 15);
      pop();
    }
  }
  
  
  void startCommute(House start, House dest){
  isIndoors = false;
  going=true;
  start.persExit(this);
  destination = dest;
  reachedX = false;
  }
  
  boolean reachedX = false;

  void move(float dx, float dy){
    x+=(dx-x)/5;
    y+=(dy-y)/5;
  }
  
  void goToHouse(House dest){
 println(sqrt(sq(dest.x-x)+sq(dest.y-y)));
  if(sqrt(sq(dest.x-x)+sq(dest.y-y))>40){
    if(!reachedX){
      move(dest.x,y);
      if(abs(dest.x-x)<40){
       reachedX=true;
      }
    }else{
      move(dest.x, dest.y);
    }
  }else{
    arrive(dest);
  }
  }
  void arrive(House dest){
    isIndoors=true;
    going = false;
    destination = null;
    for(Room r: dest.rooms){
      if(r == office){
        r.people.add(this);
      }
      if(r == apt){
        r.people.add(this);
      }
    }
    
  }
  
  void act(float time){
    if(frameCount>timeOfInfection+100 && inf){
      inf=false;
      immune = true;
    }
    if(frameCount>timeOfInfection+500 && immune){
      immune = false;

    }
    if(abs(time-startWork)<3&&isIndoors){
      startCommute(home, workplace);
    }
    if(abs(time-endWork)<3&&isIndoors){
      startCommute(workplace, home);
    }
  }
  
}
