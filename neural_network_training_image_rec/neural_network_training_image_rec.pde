
int[] layout= {5600, 5, 5, 5, 3,3, 2};
ArrayList<ImgClas> ics = new ArrayList();
int curImage = 0;
String[] values;
Graph g = new Graph();
int generation = 0;
int genlength = 5;
void setup(){

  
 
size(1000,1000);
for(int i = 0; i<100;i++){
ics.add(new ImgClas(new NeuralNet(layout)));
}
 values = loadStrings("/Users/hannes/Desktop/informatik/Java/processing/Generate_NN_training_data/data.txt");
  

}


//Arrays to store data to be displayed
ArrayList<Float> avgD = new ArrayList();
ArrayList<Float> bst = new ArrayList();
ArrayList<Float> avgavg = new ArrayList();




void draw(){
    background(255);
    fill(255);
    rect(100,100,800,800);
    
    if(curImage==999){curImage=0;}
    
  PImage img = loadImage("/Users/hannes/Desktop/informatik/Java/processing/Generate_NN_training_data/images/"+(curImage +1)+".tif");
  img.loadPixels();
  fill(0);
  text(values[curImage],50,43); 
  image(img, 50,50);
  int[] input = img.pixels;
  
  
  float sumD = 0;
  float sumP = 0;
  
  for(int i =0; i<ics.size(); i++){
    ics.get(i).classify(input, Float.valueOf(values[curImage]));
    sumD += ics.get(i).deviation;
    sumP += ics.get(i).prediction;
  }
  
  float avgP = sumP/ics.size();
  
  avgD.add(sumD/ics.size());
  float sumA = 0;
  
 if(avgD.size()>99){
   for(int i = 0; i<100; i++){sumA+=avgD.get(avgD.size()-i-1);}
  avgavg.add(sumA/100);
 }else{
    for(int i = 0; i<avgD.size(); i++){sumA+=avgD.get(i);}
    avgavg.add(sumA/avgD.size());
 }
 
 
 
 if(curImage%genlength==0){
   newgen();  
 }
 
 

 graphDisplay(avgP);

  curImage++;
  
}


void newgen(){
  generation++;
  Collections.sort(ics);
  bst.add(ics.get(0).deviation);
  
  
  while(ics.size()>2){ics.remove(2);}
  
  for(int i = 0; i<4; i++){
    for(int j = 0; j<10; j++){
      ics.add(new ImgClas(ics.get(i)));
    }
  }
}




void graphDisplay(float avgP){
 g.display(avgD, 20, 100, 100, 800, 800);
  stroke(0,255,0);
  g.display(bst, 20, 100, 100, 800, 800);
  stroke(0);
  
  g.display(avgD, 20, 100, 100, 800, 800);
  
  push();
  stroke(255, 0, 0);
  strokeWeight(2);
  g.display(avgavg,20,100,100,800,800);
  stroke(0);
  strokeWeight(1);
  fill(255);
  rect(50, 95, 140, 40);
  fill(255, 0, 0);
  rect(50+avgP, 95, 40, 40);
  pop();
  
  text("Generation: "+generation+" ", 400, 40);
}
