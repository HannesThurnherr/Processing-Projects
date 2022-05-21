import java.util.*;

class Drone implements Comparable<Drone>{
 
  float rotation = PI;
  float rotVel =0.00;
  PVector pos;
  PVector vel = new PVector(0,2);
  PVector acceleration = new PVector(0,0);
  float size = 20;
  
  
  //the following floats serve the calculation of the fitness
  int score;
  PVector distToTarget;
  float minDistToTarget = 1000;
  float distacceleration = 0;
  float divisor =0;
  float distavg =0;
  
  
  
  Target target;
  NeuralNet brain;
  
  public Drone(float x, float y, NeuralNet in){
    pos = new PVector(x,y);
    brain = in;
  }
  
  void mutate(float amount, float frequency){
    brain.mutate(amount,frequency);
  }
  
  
  void show(){
    push();
    translate(pos.x,pos.y);
    rotate(rotation);
    rect(-size,-size/3.0, size*2, size/1.5);
    //rect(-size*1.2,-size/2.0, size/4.0, size);
    //rect(size, -size/2.0, size/4.0, size);
    //circle(0,0,size);
    
    pop();
    
    //brain.show(10, 10, 200, true);
  }
  
  void update(Target t){
    target = t;
    rotation+=rotVel;
    pos.add(vel);
    vel.add(new PVector(0,0.15)); //exerts gravitational force
    vel.mult(0.99);
    rotVel*=0.9;
    //if(rotation<0.5*PI){rotVel*=-1;}
    //if(rotation>3*0.5*PI){rotVel*=-1;}
    
   distToTarget= new PVector(pos.x-t.pos.x, pos.y-t.pos.y);
    
    if(distToTarget.mag()<minDistToTarget){minDistToTarget=distToTarget.mag();}
    
    divisor++;
    distacceleration+=sq(distToTarget.mag()/100);
    distavg = distacceleration/divisor;
  }
  
  void fireLeft(float in){
    push();
    translate(pos.x,pos.y);
    rotate(rotation);
    fill(255,200,0);
    triangle(size*1.3, -size*0.8, size, -size*0.8, size*1.15, -size*1.2);
    pop();
    rotVel+=0.02*in;
    acceleration = new PVector(0,0.2*in);
    acceleration.rotate(rotation);
    vel.add(acceleration);
    
  }
  
    void fireRight(float in){
      push();
    translate(pos.x,pos.y);
    rotate(rotation);
    fill(255,200,0);
    triangle(-size*1.3, -size*0.8, -size, -size*0.8, -size*1.15, -size*1.2);
    pop();
    rotVel-=0.02*in;
    acceleration = new PVector(0,0.2*in);
    acceleration.rotate(rotation);
    vel.add(acceleration);
  }
  
  void think(Target t){
    float[] inputArray = {distToTarget.x, distToTarget.y,(rotation%(2*PI))-PI,rotVel, acceleration.mag(),acceleration.heading() ,atan(1/vel.x) ,atan(1/vel.y)};
    brain.run(inputArray);
  }
  
  void act(){
   float[] action = brain.outputLayer();
   if(action[0]>0){fireLeft(0.5);}
   if(action[1]>0){fireRight(0.5);}
   
  }
  
    public int compareTo(Drone other){
     if(other.distavg>this.distavg){
       return -1;
     }else if(other.distavg<this.distavg) {
       return 1;
     }
     else{
       return 0;
     }
    }
}
