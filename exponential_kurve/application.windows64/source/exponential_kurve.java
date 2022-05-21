import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class exponential_kurve extends PApplet {


HScrollbar daySlider;
HScrollbar rSlider;
HScrollbar scaleSlider;



public void setup() {
  
  daySlider=new HScrollbar(790,  450, 200, 10, 2, 0, 110);
  rSlider = new HScrollbar(790,  550, 200, 10, 2, 0.7f, 1.4f);
  scaleSlider = new HScrollbar(790,  350, 200, 10, 2, -0.5f, 30);
}

float r=1.1f;
int days;
float scale = 1;

public void draw() {
  days = floor(daySlider.getPos());
  r = rSlider.getPos();
  if(scaleSlider.getPos()!=13.9875f){
    scale=scaleSlider.getPos();
  if(scaleSlider.getPos()<=0){
  scale = 0.1f;
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


public void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}

public float dayValue(int i) {

  float rPowi = pow(r, i);
  //rPowi = exp(log(rPowi));
  return rPowi;
}

public void markers(int day){
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

public void rText(){
  push();
  fill(0);
  textSize(30);
  text("R: "+r, 200, 90); 
  pop();
}

public void sliderText(){
  push();
  fill(0);
  text("R: "+rSlider.getPos(), 800, 530);
  text("Days: "+days, 800, 430);
  text("Scale: "+scale, 800, 330);
  pop();
  
}

class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  float min, max;
  


HScrollbar (float xp, float yp, int sw, int sh,int l, float mn, float mx) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
    min = mn;
    max = mx;
}

  public void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  public float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  public boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  public void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

   public float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return ((spos-xpos)/swidth)*(max-min)+min;
  }
}
  public void settings() {  size(1000, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "exponential_kurve" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
