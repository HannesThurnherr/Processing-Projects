import java.util.*;



int gen;
int population;
ArrayList<Drone> drones;
int[] layout = {8,5,5,2};
Target t = new Target(750, 250, 30);
Boolean reached =false;




void setup() {
  
  frameRate(240);

  population =150;
  drones = new ArrayList();
  ;
  for (int i = 0; i<population; i++) {
    drones.add(new Drone(500, 500, new NeuralNet(layout)));
  }
  size(1000, 1000);
  t.relocate();
}





void draw() {


  background(150);
  push();
  fill(0, 150, 0);
  rect(0, 900, 1000, 100);
  pop();
  text("Framecount: "+frameCount, 870, 100);
  text("best avg distance:"+drones.get(0).distavg, 800, 150);
  text("Generation: "+gen, 900, 200);
  text("number of drones: "+drones.size(), 850, 50);
  Collections.sort(drones);
  for (int i = 0; i<drones.size(); i++) {
    Drone d=drones.get(i);
    d.show();
    d.update(t);
    d.think(t);
    d.act();
  }
  t.show();
  fill(255, 0, 0);
  drones.get(0).show();
  drones.get(0).brain.show(10,10,200,false);  //displaying Neural Network of best Performance
  fill(255);


if(gen<6){             //adjust generational Duration
  if ((frameCount%400==0)||drones.size()<6) {
    newGen();
  }
}else if(gen<35){
if ((frameCount%550==0)||drones.size()<6) {
    newGen();
  }
}else{
if ((frameCount%1600==0)||drones.size()<6) {
    newGen();
  }
}
}




void newGen() {
  
  gen++;
  //if(gen>25){
  t.relocate();
  //}
 
  Collections.sort(drones);
 
 int offspring = 50;        //adjust amount of offpring a succesful Drone has
 int topX = 3;              //adust how many Drones get to reproduce in a given generation
 
 
  Drone[] tempDrone = new Drone[topX*offspring];
  for (int i = 0; i<drones.size(); i++) {
    if (i<topX) {  
      for (int j = 0; j<offspring; j++) {
        tempDrone[i*offspring+j]=reproduce(drones.get(i));
      }
    } else {
      drones.remove(i);
      i--;
    }
  }
  for (int i = 0; i<tempDrone.length; i++) {
    drones.add(tempDrone[i]);
  }


  for (int i = 0; i<drones.size(); i++) {
    Drone d = drones.get(i);
    
    d.pos = new PVector(500, 500);
    d.vel.mult(0);
    d.minDistToTarget=1000;
    d.distacceleration=0;
    d.divisor=1;
    d.rotation=PI;
  }
}






Drone reproduce(Drone parent) {

  Drone child = new Drone(500, 500, new NeuralNet(parent.brain));
  child.mutate(0.05, 0.1);     //adjust amount of mutation
  parent.rotation=PI;
  return child;
}
