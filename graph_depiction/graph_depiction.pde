ArrayList<Node> nodes = new ArrayList();


void setup(){
  size(1000,1000);
  for(int i = 0; i<15; i++){
    nodes.add(new Node());
  }
  for(int i = 0; i<nodes.size(); i++){
    for(int j = 0; j<3; j++){
      //if(random(0,1)>0.5){
        nodes.get(i).nei.add(nodes.get(floor(random(nodes.size()))));
      //}
    }
  }
  
  //RANDOM POSITIONS
  for(int i = 0; i<nodes.size(); i++){
    Node n = nodes.get(i);
    n.posx=random(1000);
    n.posy=random(1000);
  }
  
  Node centralNode = nodes.get(0);
  centralNode.posx = 500;
  centralNode.posy = 500;
  DFSDeaphSetter(centralNode);
}


void draw(){
  //background(100);
  for(int i = 0; i<nodes.size(); i++){
    nodes.get(i).draw();
    calcNodeForce(nodes.get(i));
    nodes.get(i).update();
  }
  
  
  
  
}

float[] randomDirOffset(float dist, float x, float y){
  PVector o = new PVector(x, y);
  PVector n = o.add(new PVector(0, dist).rotate(random(2*PI)));
  float[] out = {n.x, n.y};
  return out;
}

void DFSDeaphSetter(Node n){
  n.posSet = true;
  for(int i = 0; i<n.nei.size(); i++){
      Node o = n.nei.get(i);
      if(!o.posSet){
        float[] pos = randomDirOffset(100, n.posx, n.posy);
        o.posx = pos[0];
        o.posy = pos[1];
        o.posSet = true;
        DFSDeaphSetter(o);
      }
  }
}

void calcNodeForce(Node n){
  float xforce = 0;
  float yforce = 0;
  PVector pos = new PVector(n.posx,n.posy);
  for(int i = 0; i<nodes.size(); i++){
    Node o = nodes.get(i);
    PVector opos = new PVector(o.posx,o.posy);
    PVector force = calcf(pos, opos);
    xforce+=force.x;
    yforce+=force.y;
    
  }
  n.fx = xforce;
  n.fy = yforce;
  
   
}


PVector calcf(PVector n, PVector o){
  
}  

float sign(float x, float y){
  if (x>y){
    return 1;
  }else{
    return -1;
  }
}
