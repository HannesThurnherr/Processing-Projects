House h = new House(100, 100, 50, 50);
ArrayList<House> city = new ArrayList();
ArrayList<Person> people = new ArrayList();
float day = 50;
int pop = 1000;

float blocks = 2;

float transProb = 0.0025;

ArrayList<Float> cases = new ArrayList();

void setup(){
  size(1300, 1000);
  h.fillHouse(5);
  for(int i = 0; i<blocks; i++){
    float x  = 1000/blocks*i;
    float rw = 1000/blocks/15.0;
    float houseSize = (1000/blocks-4*rw)/3;
    for(int j = 0; j<blocks; j++){
      float y = 1000/blocks*j;
      for(int k = 0; k<3; k++){
        for(int l = 0; l<3; l++){
          if(!(k==1&&l==1)){
            House nhouse = new House(x+rw*l+rw+l*houseSize, y+rw*k+rw+k*houseSize, houseSize,houseSize);
            nhouse.fillHouse(floor(random(2,4)+1));
            city.add(nhouse);
          }
        }
      }
    }
  }
  for(int i = 0; i<pop; i++){
    people.add(new Person(city, day));
  }
  frameRate(50);
  people.get(floor(random(0, people.size()-1))).inf=true;
  cases.add(1.0);
}

void draw(){
  background(150);
  for(int i = 0; i<city.size(); i++){
    city.get(i).show();
    city.get(i).checkTransmission(transProb);
  }
 float inf = 0;
 for(int i = 0; i<people.size(); i++){
    people.get(i).show();
    people.get(i).act(frameCount%day);
    if(people.get(i).going){
      people.get(i).goToHouse(people.get(i).destination);
    }
    if(people.get(i).inf){
      inf++;
    }
  }
  if(frameCount%30==0){
    cases.add(inf);
  }
  graph(cases, pop*1.2, 1000, 10, 290, 190);
  push();
  fill(0);
  text(frameCount%day, 30, 30);
  pop();
}
