
Node[] nodes;

void setup(){
  
  size(1000, 1000);
  
 nodes = new Node[100];

for(int i = 0; i<nodes.length; i++){
  nodes[i]=new Node();
}

  for(int i = 0; i<nodes.length; i++){
    nodes[i].fill(10);
  }
}
int counter = 0;

void draw(){
  counter++;
  background(100, 100, 100, 200);
  if (counter == 100){
  counter=0;
println("-");}
 
    if(random(0,1)<0.2){
      nodes=appelt(nodes, new Node());
      nodes[nodes.length-1].fill(10);
    }
 
 
     for(int i = 0; i<nodes.length; i++){
       
    nodes[i].drawcon();
       
    
    }
    for(int i = 0; i<nodes.length; i++){
      nodes[i].show();
    nodes[i].update();
    
    
    if(nodes[i].getposx()<0|| nodes[i].getposx()>1000){nodes=remelt(nodes, i);}
    if(nodes.length>i){
    if(nodes[i].getposy()<0|| nodes[i].getposy()>1000){nodes=remelt(nodes, i);} 
      }
    }
    
    
}
  
  Node[] remelt(Node[] in, int index){
  Node[] out = new Node[in.length-1];
  for(int i = 0; i<out.length; i++){
    if(i<index){out[i]=in[i];} else{{out[i]=in[i+1];}
  
      }
    }
  return out;
  }
  
  
  
  Node[] appelt(Node[] in, Node elt){
  Node[] out = new Node[in.length+1];
  for(int i = 0; i<in.length; i++){
    out[i]=in[i];
  }
  out[in.length]=elt;
  
  return out;
  }
  
