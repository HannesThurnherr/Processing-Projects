int[] layout = {2,2,3,30000};
NeuralNet onn = new NeuralNet(layout);
Field[][] fields = new Field[100][100];
void setup(){
  onn.mutate(0.01,0.01);
size(1000, 1000);
  for(int i = 0; i<100; i++){
    for(int j = 0; j<100; j++){
      fields[i][j]=new Field(i*10,j*10);
    }
  }
 noStroke();
}
 
void draw(){
   //onn.mutate(1,0.001);
 background(0);
  //float[] testInput2 = {-sin(frameCount/30.0),cos(frameCount/9.0),-cos(frameCount/30.0+0.4)};
  float[] testInput2 = {atan((mouseX-500)/10000.0), atan((mouseY-500)/10000.0)};
  //float[] testInput2 = {0, 0};
  onn.inputValues(testInput2);
   long start = System.nanoTime();
  onn.run();
  println("run() took: "+((System.nanoTime()-start)/1000000000.0)+" secconds");
  println("x: "+atan((mouseX-500)/10000.0)+" y: "+atan((mouseY-500)/10000.0));
  float[] out = onn.outputLayer();
  int i = 0;
  
  for(int x = 0; x<100; x++){
    for(int y = 0; y<100; y++){
     fields[x][y].show(out[i]*128+128,out[i+1]*128+128,out[i+2]*128+128);
      i+=3;
    }
  }
 
  //onn.show(100,100,800,true);
 
}
