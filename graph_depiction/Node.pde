class Node{
  float posx, posy;
  float velx, vely = 0;
  float fx, fy = 0;
  
  ArrayList<Node> nei = new ArrayList();
  boolean posSet = false;
  void draw(){
    for(int i = 0; i<nei.size(); i++){
      Node n = nei.get(i);
      line(posx,posy, n.posx, n.posy);
    }
    circle(posx, posy, 20);
  }
  
  void update(){
    velx+=fx;
    vely+=fy;
    posx+=velx;
    posy+=vely;
    fx = 0;
    fy = 0;
  }
}
