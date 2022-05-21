class Node{
  float posx;
  float posy;
  
  ArrayList<Node> neighbours = new ArrayList();
  
  HashMap<Node, Node> routing = new HashMap();
  

  
  HashMap<Node, Integer> distances = new HashMap();
  
  int address;
  
  String name = "node ";
  
  ArrayList<Float> avgHopHist = new ArrayList();
  
  float totalMsg = 0;
  
  float msgCount = 0;
  float sumHop = 0;
  float avgHop = 0;
  
  Node(float x, float y,int n){
    this.posx = x;
    this.posy = y;
    this.name +=(n+1);
    this.address = n;
    neighbours.add(this);
    avgHopHist.add(avgHop);
  }
  
  
  void show(){
    circle(posx, posy, 15);
    push();
    fill(255);
    text(name, posx-20, posy+20);
    
    stroke(255);
    for(int i = 0; i<neighbours.size(); i++){
      
      line(posx,posy, neighbours.get(i).posx, neighbours.get(i).posy);
    }
    pop();
  }
  
  //a methods that probes the net to establish which neighbour can relay a message the fastest to a specific neighbour
  
  void makeDists(ArrayList<Node> in){this.distances = floydWarshall(in, this);}
  
  
  
  void probe(ArrayList<Node> in){
   this.distances = floydWarshall(in, this);                        
      for(int i =0; i<in.size(); i++){                            //loops through nodes
        int sm = distances.get(in.get(i));                        //puts distance to node
        int closestNeighbour = 0;                                 //initailizes the cni (closet neighbour index)
        for(int j = 0; j<neighbours.size(); j++){                 //loops through neighbours
          if(neighbours.get(j).distances.get(in.get(i))<sm){      //determines whether neighbour is closer to node than the current favourite
            closestNeighbour = j;                                 //updates current favourite
        }
          routing.put(in.get(i), neighbours.get(closestNeighbour));               //puts final favourite into list
        }
      } 
  }

  
   void displayRoutingTable(ArrayList<Node> in){

     for(int i =0; i<in.size(); i++){
       int n = distances.get(in.get(i));
       println("distance from "+this.name+" to "+in.get(i).name+": "+n);
     }
     
     
     println("ROUTING-TABLE of  node "+address);
     for(int i = 0; i<routing.size(); i++){
       Node assoc = routing.get(in.get(i));
       println("to send to node "+i+" node "+assoc.address+" will be messaged");
     }
   }
   
   
   
   
   
   
   
   Message genMsg(ArrayList<Node> nodes){
     int target = (int)random(0,nodes.size());
     Message msg =  new Message(routing.get(nodes.get(target)), nodes.get(target), this, this, "hello node");
     return(msg);
   }
  
  void handle(Message msg, ArrayList<Node> nodes){
    if(msg.finalDestination==this){
      msg.reached = true;
      if(msg.finalDestination!=msg.origin){
        msg.hopCount++;
      }
      
      this.msgCount++;
      this.sumHop+=msg.hopCount;
      this.avgHop=sumHop/msgCount;
      avgHopHist.add(avgHop);
      this.totalMsg++;
      
    }else{
      msg.sender=this;
      msg.destination = routing.get(msg.finalDestination);
      msg.t = 0;
      msg.hopCount++;
      this.totalMsg++;
    }
  }
  

    
 
  
  
  HashMap<Node, Integer> floydWarshall(ArrayList<Node> nodes, Node start){
    
    int n = nodes.size();
    int[][] dist = new int[n][n];
    
    
    for(int k = 0; k < n; k++){
      for(int i = 0; i < n; i++){
          dist[k][i] =  1000;
          if(i==k){
             dist[k][i] = 0;
          }
      }
    }
    

     for(int k = 0; k < n; k++){
       Node node = nodes.get(k);
       for(int i = 0; i<node.neighbours.size(); i++){
         dist[node.address][node.neighbours.get(i).address]=1;
       }
     }
    
    for(int k = 0; k < n; k++){
      for(int i = 0; i < n; i++){
          for(int j = 0; j < n; j++){
              dist[i][j] = min( dist[i][j], dist[i][k] + dist[k][j] );
          }
      }
    }
   

   HashMap<Node, Integer> out = new HashMap();
  for(int k = 0; k < n; k++){
    dist[k][k]=0;
    out.put(nodes.get(k), dist[start.address][k]);
  }
 
  return out;
  }
  
  
  void dispMat(int[][] in){
    for(int k = 0; k < in.length; k++){
       for(int i = 0; i<in[0].length; i++){
         print(in[k][i]+", ");
       }
       println("");
     }
  }
  
  
}
