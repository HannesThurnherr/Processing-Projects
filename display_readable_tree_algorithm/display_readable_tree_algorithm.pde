Pred p;


void setup(){
  size(1000, 1000);
  p = new Pred("the us is a bad actor gobally");
  p.cld.add(new Pred("they committed various genocides"));
  p.cld.add(new Pred("they are interfearing in the affairs of other countries"));
  for(int i = 0; i < 4; i++){
    p.cld.add( new Pred("pred "+i));
  }
  for(int i = 0; i < p.cld.size(); i++){
    for(int j = 0; j < random(1, 5); j++){
      p.cld.get(i).cld.add( new Pred("Predicate "+i+" "+j));
    }
  }
}

void draw(){

  background(255);
  p.show(mouseX, mouseY, 0);

}
