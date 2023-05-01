int amount = 100000;
int duration = 50;

GraphHandler gd = new GraphHandler();
ArrayList<ArrayList<Float>> currentSim;


ArrayList<float[]> history = new ArrayList();

void setup(){
  size(1000, 1000);
  currentSim = simmulateCycle(100, amount, 1.005, 0.2);
}

void draw(){
  
  frameRate(max(1,mouseX/5));
  background(255);
  currentSim = simmulateCycle(100, amount, 1.005, 0.2);
  gd.lineGraph(currentSim, 20, 20, 760, 960);
  gd.barGraph(calcAvgReturns(history),800,20,180,960);
  push();
  fill(0);
  text(frameCount, 40,40);
  pop();
}

ArrayList<ArrayList<Float>> simmulateCycle(int dur, float am, float avgIncrease, float fluctuation){
  ArrayList<Float> oneTimeInput = new ArrayList();
  ArrayList<Float> continuousInput = new ArrayList();
  float increment = am / (float)dur;
  oneTimeInput.add(am);
  continuousInput.add(increment);
  for(int i = 0; i<dur; i++){
    float r = random(10);
    float courseChange = avgIncrease - fluctuation + random(2*fluctuation);
    oneTimeInput.add(oneTimeInput.get(oneTimeInput.size()-1)*courseChange);
    continuousInput.add(continuousInput.get(continuousInput.size()-1)*courseChange+increment);
  }
  float[] hist = {oneTimeInput.get(oneTimeInput.size()-1),continuousInput.get(continuousInput.size()-1)};
  history.add(hist);
  ArrayList<ArrayList<Float>> out = new ArrayList();
  out.add(oneTimeInput);
  out.add(continuousInput);
  return out;
}


ArrayList<ArrayList<Float>> simmulateCycle2(int dur, float am, float avgIncrease, float fluctuation){
  ArrayList<Float> oneTimeInput = new ArrayList();
  ArrayList<Float> continuousInput = new ArrayList();
  float increment = am / (float)dur;
  oneTimeInput.add(am);
  continuousInput.add(increment);
  for(int i = 0; i<dur; i++){
    float r = random(fluctuation);
    float courseChange = 0;
    if(random(1)>0.5){
      courseChange = avgIncrease + r;
    }else{
      courseChange = avgIncrease - r;
    }
    oneTimeInput.add(oneTimeInput.get(oneTimeInput.size()-1)*courseChange);
    continuousInput.add(continuousInput.get(continuousInput.size()-1)*courseChange+increment);
  }
  float[] hist = {oneTimeInput.get(oneTimeInput.size()-1),continuousInput.get(continuousInput.size()-1)};
  history.add(hist);
  ArrayList<ArrayList<Float>> out = new ArrayList();
  out.add(oneTimeInput);
  out.add(continuousInput);
  return out;
}

ArrayList<Float> calcAvgReturns(ArrayList<float[]> in){
  float sum1 = 0;
  float sum2 = 0;
  for(int i = 0; i<in.size(); i++){
    sum1+=in.get(i)[0];
    sum2+=in.get(i)[1];
  }
  ArrayList<Float> out = new ArrayList();
  out.add(sum1/(float)in.size());
  out.add(sum2/(float)in.size());
  return out;
}

float ndrvar(float min, float max){
  float range = max-min;
  boolean found = false;
  float out = 0;
  while(!found){
    float n = random(range);
    if(random(1)<exp(-n)){
      out = n;
      found = true;
    }
  }
  return out;
}
