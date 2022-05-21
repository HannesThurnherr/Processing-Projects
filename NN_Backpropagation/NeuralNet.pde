class NeuralNet{
  
  float pF = 10;
  int parameter;
  
  public int[] layout;
  
  ArrayList<Node[]> layers = new ArrayList();
  ArrayList<Edge[][]> edges = new ArrayList();
  
  public NeuralNet(int[] in){
    layout = in;
    this.fillNet();
    parameter = calcParameter();
  }
  
  
  
  public NeuralNet(NeuralNet in){
    this.layout = in.layout;
    this.pF = in.pF;
    this.layers = nodeCopy(in);
    this.edges = edgeCopy(in);
    parameter = calcParameter();
  }
  
  
  
  
  void fillNet(){
    for(int i =0; i<layout.length; i++){
     
      Node[] nodes = new Node[(int)layout[i]];
    
      if(i<layout.length-1){
        
         Edge[][] connections = new Edge[(int)layout[i]][(int)layout[i+1]];
         
         for(int j =0; j<layout[i]; j++){
          for(int k = 0; k<layout[i+1]; k++){
             connections[j][k]=new Edge(random(-pF,pF), pF);
          }
         }
         
         edges.add(connections);
      }
      for(int j =0; j<layout[i]; j++){
       nodes[j]=new Node();
       
      }
       layers.add(nodes);
     }
   }
   
   
   
   
   
   
   
   void show(float x, float y, float size, boolean showParameter){
    // print("layers: "+layers.size());
    // print("edges: "+edges.size());
     for(int i = 0; i<layers.size()-1; i++){
       for(int j = 0; j<layers.get(i).length; j++){
         for(int k = 0; k<layers.get(i+1).length; k++){
           edges.get(i)[j][k].show(x+((size/(layers.size()-1.0))*i), y+((size/(layers.get(i).length+1.0))*(j+1.0)), x+((size/(layers.size()-1.0))*(i+1.0)), y+((size/(layers.get(i+1).length+1.0))*(k+1.0)));
         }    
       }
     }
     for(int i = 0; i<layers.size(); i++){
       for(int j = 0; j<layers.get(i).length; j++){
         layers.get(i)[j].show(x+((size/(layers.size()-1.0))*i), y+((size/(layers.get(i).length+1))*(j+1.0)));
       }
     }
     
     if(showParameter){
       push();
         textSize(10);
         fill(0,0,255);
         text(parameter+" parameters", x+size-50, y);
       pop();
     }
   }
   
   int calcParameter(){
     int parameter = 0;
       for(int i =0; i<layout.length; i++){
         parameter+=layout[i]*2;
         if(i<layout.length-1){
           parameter+=layout[i]*layout[i+1];
         }
       }
       return parameter;
   }
   
   
   
   
   
   
   void run(){
     for(int i = 1; i<layers.size(); i++){
       for(int j = 0; j<layers.get(i).length;j++){
         float[] in = new float[layers.get(i-1).length];
           for(int k = 0; k<in.length;k++){
             in[k]=layers.get(i-1)[k].getValue()*edges.get(i-1)[k][j].weight;
           }
         layers.get(i)[j].recive(in);
       }
     }
   }
   
   void run(float[] input){
     inputValues(input);
     for(int i = 1; i<layers.size(); i++){
       for(int j = 0; j<layers.get(i).length;j++){
         float[] in = new float[layers.get(i-1).length];
           for(int k = 0; k<in.length;k++){
             in[k]=layers.get(i-1)[k].getValue()*edges.get(i-1)[k][j].weight;
           }
         layers.get(i)[j].recive(in);
       }
     }
   }
   
   
   
   
  
  void inputValues(float[] in){
    if(in.length!=layers.get(0).length){
      print("invalid input");
    }else{
      for(int i = 0; i < in.length; i++){
        layers.get(0)[i].setValue(in[i]);
      }
    }
  }
  

 void mutate(float in, float pos){
  for(int i = 0; i<layers.size(); i++){
       for(int j = 0; j<layers.get(i).length;j++){
        
         if(random(0,1)<pos){
          layers.get(i)[j].mutate(in, in); 
         }
         
         if(i<layers.size()-1){
           for(int k = 0; k<layers.get(i+1).length;k++){
           if(random(0,1)<pos){
             edges.get(i)[j][k].mutate(in);
           }
         }
       }
     }
   }
 }
 
 float outputSum(){
   float out = 0;
    for(int i = 0; i<layers.get(layers.size()-1).length; i++){
      out+=layers.get(layers.size()-1)[i].value;
    }
    return out;
 }
 
 float[] outputLayer(){
   float[] out = new float[layout[layout.length-1]];
   for(int i = 0; i<out.length;i++){
     out[i]=layers.get(layers.size()-1)[i].value;
   }
   return out;
 }
 
 
 
 
 
   ArrayList<Edge[][]> edgeCopy(NeuralNet in){
   ArrayList<Edge[][]> out = new ArrayList();
  
   for(int i =0; i<in.edges.size(); i++){
         Edge[][] connections = new Edge[(int)in.layout[i]][(int)in.layout[i+1]];
         for(int j =0; j<layout[i]; j++){
          for(int k = 0; k<layout[i+1]; k++){
             connections[j][k]=new Edge(in.edges.get(i)[j][k].weight, pF);
          }
         }
         out.add(connections);
      }
      
      return out;
   }
   
   
   
   
   
   ArrayList<Node[]> nodeCopy(NeuralNet in){
     ArrayList<Node[]> out = new ArrayList();
     for(int i =0; i<in.layers.size(); i++){
         Node[] nodes = new Node[(int)in.layout[i]];
         for(int j =0; j<in.layout[i]; j++){
           nodes[j]=new Node();
           nodes[j].setBiasAndW(in.layers.get(i)[j].bias,in.layers.get(i)[j].w);
         }
         out.add(nodes);
     }
   return out;  
   }
 
   void backpropagate(float[] should){
     
   }
   
   void backpropagate(ArrayList<float[]> should){
   
   }


}
