 class Node{
  
  float posx = random(0,1000);
  float posy = random(0,1000);
  
  Gnode prev;
  Gnode post;
  
  Node(float x, float y){
    posx=x;
    posy=y;
  }
  

  Node(){}

  void show(){
    circle(posx, posy, 10);
    if(prev!=null){
    line(posx,posy,prev.posx,prev.posy);
    prev.show(posx, posy);
    }
    if(post!=null){
      line(posx,posy,post.posx,post.posy);
      post.show(posx, posy);
    }
  }

  void update(){
    if(prev!=null&&post!=null){
      float n = post.pos.mag()/prev.pos.mag();
     
      post.pos.x=prev.pos.x*-1;
      post.pos.y=prev.pos.y*-1;
      post.pos.x*=n;
      post.pos.y*=n;
    }
  }


}
