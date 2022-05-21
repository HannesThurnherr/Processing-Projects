import java.util.*;
class ImgClas implements Comparable<ImgClas>{
float prediction=0;
float deviation =0;

NeuralNet nn;

public ImgClas(NeuralNet in){
  nn = in;
}

public ImgClas(ImgClas in){
  nn = new NeuralNet(in.nn);
  nn.mutate(1, 1);
}

//classifies the image and evaluates the performance
//takes the image as a integer array and the real value of the image
void classify(int[] image, float value){
  float[] input = new float[image.length];
  for(int i = 0; i<input.length; i++){
    input[i] = (float)image[i];
  }
  
  nn.run(input);
 
  int[] idealOutput = {0,0};
  idealOutput[0]=floor((100-value)/100);
  idealOutput[1]=floor((value)/100);
 
  if(nn.outputLayer()[0]>nn.outputLayer()[1]){
   prediction = 100;
  }else{
    prediction=0;
  }
  
  deviation+= abs(nn.outputLayer()[0]-idealOutput[0])+abs(nn.outputLayer()[1]-idealOutput[1]);
 
 
}


int compareTo(ImgClas other){
  if(deviation>other.deviation){
    return 1;
  }else if(deviation<other.deviation){
    return -1;
  }else{
    return 0;
  }
}



}
