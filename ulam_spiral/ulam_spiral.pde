import java.util.HashMap;


int n = 1000;
int s = 1000/n;
HashMap<Integer, Boolean> map = new HashMap();


void square(int nr, float h, float v, float s, boolean txt){
  if(!map.get(nr)){
    push();
    fill(0);
    rect(h*s,v*s,s,s);
    pop();
  }else{
  rect(h*s,v*s,s,s);
  }
  if(txt){
    push();
    fill(0);
    text(nr, h*s+s/2-5, v*s+s-5);
    pop();
  }
}

void setup(){
  size(1000, 1000);
  for(int i = 0; i<n*n; i++){
    map.put(i, checkIfPrime(i));
    println(i);
  }
}

void draw(){
  noStroke();
  background(255);
  int counter = 0;

  translate(500, 500);
  int curX = 0;
  int curY = 0;
  for(int i = 1; i<n; i++){
    for(int j = 0; j<i; j++){
      square(counter, curX, curY, s, false);
      counter++;
        if(i%2==0){
          curX+=1;
        }
        if(i%2!=0){
          curX-=1;
        }
    }
    for(int j = 0; j<i; j++){
      square(counter, curX, curY, s, false);
      counter++;
        if(i%2==0){
          curY+=1;
        }
        if(i%2!=0){
          curY-=1;
        }
    }
  }
}


boolean checkIfPrime(int n){
  for(int i = 2; i<n; i++){
    if(n%i==0){return true;}
  }
  return false;
}
