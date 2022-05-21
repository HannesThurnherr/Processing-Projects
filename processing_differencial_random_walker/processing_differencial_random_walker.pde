// differential random walker

Walker walker;

void setup(){
  frameRate(2400);
size(1000,1000);
walker = new Walker();



}

void draw(){
  //background(200);
walker.show();
walker.update();

}
