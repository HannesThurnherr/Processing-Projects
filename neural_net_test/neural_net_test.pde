int[] layout = {3,6,10,10,2};
float[] testInput = generateTestInputs(2);

NeuralNet nn;
NeuralNet n2;
boolean ran = false;

void setup(){
  //layout = generateLayouts(100);
  nn = new NeuralNet(layout);
  n2 = new NeuralNet(nn);
  size(1000, 1000);
  frameRate(24);
  textSize(15);
  nn.inputValues(testInput);
  n2.mutate(10, 0.5);
 
  
  
  
}

void draw(){
  background(100);
  
  
  
  float[] testInput2 = {sin(frameCount/30.0),cos(frameCount/9.0),-cos(frameCount/30.0+0.4)};
  //float[] testInput2 = {sin(frameCount/30.0)};
  nn.inputValues(testInput2);
  n2.inputValues(testInput2);
  

  nn.show(100, 50, 400, true);
  
  
  nn.run();
  long start = System.nanoTime();
  n2.run();
  print("run() took: "+((System.nanoTime()-start)/1000000.0)+" miliseconds with "+n2.parameter+" parameters");
  
  start = System.nanoTime();
  n2.show(100, 500, 400, true);
  println("    show() took: "+((System.nanoTime()-start)/1000000.0)+" miliseconds with "+n2.parameter+" parameters");
  
  
  float outDiff = n2.outputSum()-nn.outputSum();
  
  push();
  textSize(23);
  text("Difference in Output: "+outDiff, 550, 450);
 
  pop();
}






float[] generateTestInputs(int size){
  float[] out = new float[size];
  for(int i = 0; i<size; i++){
    out[i]=random(0,1);
  }
  return out;
}

int[] generateLayouts(int size){
  int[] out = new int[size];
  for(int i = 0; i<size; i++){
    
    out[i]=(int) Math.floor(sqrt(i));  //construct layout here based on i
    
    if(out[i]<1){out[i]=1;}
  }
  
  return out;
}
