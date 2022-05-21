
HScrollbar daySlider;
HScrollbar rSlider;
HScrollbar scaleSlider;



void setup() {
  size(1000, 1000);
  daySlider=new HScrollbar(790,  450, 200, 10, 2, 0, 110);
  rSlider = new HScrollbar(790,  550, 200, 10, 2, 0.7, 1.4);
  scaleSlider = new HScrollbar(790,  350, 200, 10, 2, -0.5, 30);
}

float r=1.1;
int days;
float scale = 1;

void draw() {
  days = floor(daySlider.getPos());
  r = rSlider.getPos();
  if(scaleSlider.getPos()!=13.9875){
    scale=scaleSlider.getPos();
  if(scaleSlider.getPos()<=0){
  scale = 0.1;
  }}
  background(255);
  
  markers(days);

  push();
  strokeWeight(4);
  arrow(100, 900, 100, 100);
  arrow(100, 900, 900, 900);
  pop();
  push();
  stroke(255, 0,0);
  for (int i = 0; i<days; i++) {
    line(100+((800/days)*i), 900-(dayValue(i)/scale), 100+((800/days)*(i+1)), 900-(dayValue(i+1)/scale));
  }
  pop();
  
  push();
  daySlider.display();
  daySlider.update();
  rSlider.display();
  rSlider.update();
  scaleSlider.display();
  scaleSlider.update();
  pop();
  
  
  rText();
 
 sliderText();
 
  
}


void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}

float dayValue(int i) {

  float rPowi = pow(r, i);
  //rPowi = exp(log(rPowi));
  return rPowi;
}

void markers(int day){
  for(int i = 0; i<day; i++){
    line(100+((800/days)*i), 900, 100+((800/days)*i), 900-(800/day));
    
  }
  push();
  fill(0);
  textSize(20);
  text(day+" days", 840, 940);
  pop();
  
  push();
  stroke(150,150,150);
  line(100,100, 900, 100);
  line(100,300, 900, 300);
  line(100,500, 900, 500);
  line(100,700, 900, 700);
  fill(150,150,150);
  textSize(10);
  text(800*scale, 900, 97);
  text(600*scale, 900, 297);
  text(400*scale, 900, 497);
  text(200*scale, 900, 697);
  pop();
}

void rText(){
  push();
  fill(0);
  textSize(30);
  text("R: "+r, 200, 90); 
  pop();
}

void sliderText(){
  push();
  fill(0);
  text("R: "+rSlider.getPos(), 800, 530);
  text("Days: "+days, 800, 430);
  text("Scale: "+scale, 800, 330);
  pop();
  
}
