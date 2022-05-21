import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Collections; 
import java.math.RoundingMode; 
import java.text.DecimalFormat; 
import java.io.File; 
import java.io.IOException; 
import java.io.FileWriter; 
import java.io.FileNotFoundException; 
import java.util.Scanner; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Network_simulation extends PApplet {

boolean netFinished = false;

ArrayList<Node> nodes = new ArrayList();
ArrayList<Message> msgs = new ArrayList();
Node node1;
Node node2;
boolean conStarted;
boolean choosingNet;
HScrollbar speedSlider;
HScrollbar msgGenSlider;
int justExported = 0;

 
 
Analyzer ana;
File_Handler fh;

public void setup(){
  
  ana = new Analyzer();
  fh=new File_Handler();
  speedSlider=new HScrollbar(790,  450, 200, 10, 2, 0, 106);
  msgGenSlider=new HScrollbar(790,  400, 200, 10, 2, 0, 106);
}

public void draw(){
  
  background(50);
  if(netFinished){
    runNet();
  }else{
    makeNet();
  }
  
  
  
}


public void makeNet(){
  
  
  
  if(conStarted){
    rect(0,0,150, 50);
    push();
    fill(0);
    text("connection started", 30, 30);
    
    stroke(0, 255,0);
    line(node1.posx, node1.posy, mouseX, mouseY);
    pop();
  }  
    fill(0, 255, 0);
    rect(900, 0, 100, 50);
    fill(255);
    rect(0, 850, 150, 150);
    rect(900, 50, 100, 50);
    rect(900, 100, 100, 50);
    push();
    fill(0);
    
    text("RUN", 930, 30);
    text("Export Net", 915, 80);
    text("Import Net", 915, 130);
    text("Delete Node", 30, 930);
    fill(255);
    text("Click empty space to make node \nClick two nodes to make Connection \nDrag a node to move it\nDrag it to the delete box to delete it", 200, 30);
    pop();
    drawNet();
    if(choosingNet){
      fh.chooseNet();
  }
  if(justExported>0){
    rect(400, 200, 200, 80);
    push();
    textSize(20);
    fill(0);
    text("Exported", 450, 240);
    pop();
    justExported--;
   }
}


public void runNet(){
  for(int i = 0; i<nodes.size(); i++){
    if(random(0,1)<floor(msgGenSlider.getPos()*msgGenSlider.getPos())*0.0001f){
        msgs.add(nodes.get(i).genMsg(nodes));
    }
  }
  rect(0,0,150,50);
  push();
  fill(0);
  text("modify network", 30, 30);
  pop();
  
  drawNet();
  
  push();
  textSize(15);
  text("Speed: "+floor(speedSlider.getPos())+"%", 795, 440);
  text("Message Generation: "+floor(msgGenSlider.getPos())+"%", 795, 390);
  speedSlider.display();
  speedSlider.update();
  msgGenSlider.display();
  msgGenSlider.update();
  pop();
  
  //totalMsgBar();
  avgHopBar();
  avgHopLine();
}


public void mouseClicked(){
  if(!netFinished){
        if(!choosingNet){
        buildNetClicks();
        }else{
          chooseNetClicks();
        }
  }else{
    if(mouseX<150&&mouseY<50){
      
      netFinished=false;
      
    }
  }
}


public void createRouting(){
  
  for(int i = 0; i<nodes.size(); i++){
    nodes.get(i).address= i;
    nodes.get(i).makeDists(nodes);
  }
  for(int i = 0; i<nodes.size(); i++){
    nodes.get(i).probe(nodes);
  }  
  
  
}

  public void mouseDragged(){
    for(int i = 0; i<nodes.size(); i++){
      Node ve=nodes.get(i);
      if(abs(ve.posx-mouseX)<30 && abs(ve.posy-mouseY)<30){
        ve.posx=mouseX;
        ve.posy=mouseY;
      }
    }
  }
  
public void avgHopBar(){
  ArrayList<Float> n = new ArrayList(); 
  for(int i = 0; i<nodes.size(); i++){
    n.add(nodes.get(i).avgHop);
  }
  ana.barGraph(n,700,700,200,200);
}

public void totalMsgBar(){
  ArrayList<Float> n = new ArrayList(); 
  for(int i = 0; i<nodes.size(); i++){
    n.add(nodes.get(i).totalMsg);
  }
  ana.barGraph(n,450,650,500,300);
}

public void avgHopLine(){
ArrayList<ArrayList<Float>> n = new ArrayList(); 
  for(int i = 0; i<nodes.size(); i++){
    n.add(nodes.get(i).avgHopHist);
  }
  ana.lineGraph(n,100,700,300,200);
}


public void removeNode(Node in){
 for(int i = 0; i<nodes.size(); i++){
    for(int j = 0; j<nodes.get(i).neighbours.size(); j++){
    if(nodes.get(i).neighbours.get(j)==in){
      nodes.get(i).neighbours.remove(j);
    }
  }
 }
 
 for(int i = 0; i<nodes.size(); i++){
     nodes.get(i).address= i;
     if(nodes.get(i)==in){nodes.remove(i);}
  }
}
  
    
public void buildNetClicks(){     
    if(!conStarted){
      boolean nearNode = false;
      for(int i = 0; i<nodes.size(); i++){
      if(abs(mouseX-nodes.get(i).posx)<30&&abs(mouseY-nodes.get(i).posy)<30){
         nearNode=true;
         node1 = nodes.get(i);
         conStarted= true;
      }
    }
  if(nearNode){

  }else{
    if(mouseY>50&&(mouseX<900||mouseY>150)){
    nodes.add(new Node(mouseX, mouseY, nodes.size()));
    println("NEW NODE"+nodes.size());
    }
  }
}else{
  conStarted=false;
  for(int i = 0; i<nodes.size(); i++){
      if(abs(mouseX-nodes.get(i).posx)<30&&abs(mouseY-nodes.get(i).posy)<30){
         node2 = nodes.get(i);
         node1.neighbours.add(node2);
         node2.neighbours.add(node1);
         createRouting();
         print("new connection");
         print("nodes: "+nodes.size());
         
      }
    }
}
if(mouseX>900&&mouseY<50){
  if(nodes.size()>0){
  createRouting();
  netFinished=true;
  }
}
if(mouseX>900&&mouseY>50&&mouseY<100){
  fh.exportNet(nodes);
  justExported=50;
}
if(mouseX>900&&mouseY>100&&mouseY<150){
  fh.chooseNet();
  choosingNet = true;
  
}}



public void chooseNetClicks(){
  if(abs(mouseX-892.5f)<7.5f&&abs(mouseY-107.5f)<7.5f){
     choosingNet = false;
  }else{
  int xpos = floor((mouseX-100)/200);
  int ypos = floor((mouseY-100)/200);
  nodes = fh.importNet(ypos*4+xpos);
  msgs = new ArrayList();
  choosingNet = false;
  }
  
}





public void drawNet(){
for(int i = 0; i<nodes.size(); i++){
      nodes.get(i).show();
      if(!netFinished){
        if(nodes.get(i).posx<150&&nodes.get(i).posy>850){
          removeNode(nodes.get(i));
        }
      }
    }
  for(int i = 0; i<msgs.size(); i++){
      
      msgs.get(i).show();
      msgs.get(i).update(nodes, floor(speedSlider.getPos()));
      if(msgs.get(i).reached){msgs.remove(i);}
    }
}




class Analyzer{
  
  private  final DecimalFormat df = new DecimalFormat("0.00");
  
  public void barGraph(ArrayList<Float> in, float x, float y, float w, float h){
    float size = Collections.max(in)*1.2f;
    push();
    fill(255);
    rect(x,y,w,h);
    int n = in.size();
    float barwidth = w/((2*n)+2);
    
  
    for(int i = 0; i<in.size(); i++){
      fill(0,0,255);
      rect(x+barwidth+(2*i*barwidth), (y+h)-(in.get(i)/size*h), barwidth, (in.get(i)/size*h));
      fill(0);
      text(""+df.format(in.get(i)), x+barwidth+(2*i*barwidth), (y+h)-(in.get(i)/size*h));
    }
    pop();
  }
  
  
  
  public void lineGraph(ArrayList<ArrayList<Float>> in, float x, float y, float w, float h){
    rect(x,y,w,h);
    float[] maxlist = new float[in.size()];
    float[] sizelist =new float[in.size()];
    for(int i =0; i<in.size(); i++){
      maxlist[i] = Collections.max(in.get(i))*1.2f;
      sizelist[i] = in.get(i).size();
    }
    float size = max(maxlist);
    int n = floor(max(sizelist));
    float linedist = w/(n+2);
    push();
    
    for(int i = 0; i<in.size(); i++){
      for(int j = 0; j<in.get(i).size()-1; j++){
        float x1 = x+linedist+j*linedist;
        float y1 = y+h-(in.get(i).get(j)/size*h);
        float x2 = x+linedist+(j+1)*linedist;
        float y2 = y+h-(in.get(i).get(j+1)/size*h);
        stroke(255,0,0);
        line(x1, y1, x2, y2);
      }
    }
    pop();
  }
  

}
  

   
  
 
class File_Handler{
  
  String netFolder = "Desktop/informatik/Java/processing/Network_simulation/Networks/";
  
  int nr = 1;
  
 public void exportNet(ArrayList<Node> in){
   
   File directory=new File(netFolder);
   nr=directory.list().length/2;
   
   String content = "";
   for(int i =0; i<in.size(); i++){
     String str = "";
     str +=in.get(i).posx+" ";
     str +=in.get(i).posy+" ";
     String s = "";
     for(int j = 0; j<in.get(i).neighbours.size(); j++){
     s+=in.get(i).neighbours.get(j).address+",";
     }
     str+=s+"\n";
     content+=str;
   }  
    
   try{
   File net = new File(netFolder+"net"+nr+".txt");
   net.createNewFile();
   FileWriter myWriter = new FileWriter(netFolder+"net"+nr+".txt");
   myWriter.write(content);
   myWriter.close();
   }catch(IOException e){
     e.printStackTrace();
   }
   
   PImage img = get(100,100,700,700);
    
   img.save("Networks/netImg"+nr+".jpg");
   
   
   
 } 
 
 
 public void chooseNet(){
   File directory=new File(netFolder);
   nr=directory.list().length/2;
   push();
   fill(100);
   rect(50, 50, 900, 900);
   pop();
   
   rect(100,100,800,800);
   for(int i = 1; i<4; i++){
     line(110,100+ i*200, 890, 100+ i*200);
     line(100+ i*200,110,  100+ i*200, 890);
   }
   push();
    for(int i = 0; i<4; i++){
      for(int j = 0; j<4; j++){
        if(i*4+j<=nr-1){
       displayNet(100+(j*200), 100+(i*200), i*4+j);
       }
      }  
    }
   fill(255, 0, 0);
   rect(885, 100, 15, 15);
   line(887, 102, 898, 113);
   line(887, 113, 898, 102);
   pop();
 }
 
 public void displayNet(float x,float y, int n){
   PImage img = loadImage(netFolder+"netImg"+n+".jpg");
   image(img, x+25, y+10, 150, 150);
   
   fill(0);
   text("Net "+n, x+50, y+180); 
   
}
 
 
 
 
 
 
 
 public ArrayList<Node> importNet(int in){
 ArrayList<Node> out = new ArrayList();
 ArrayList<ArrayList<Integer>> nbrs = new ArrayList();
 
 try {
      File myObj = new File(netFolder+"net"+in+".txt");
      Scanner myReader = new Scanner(myObj);
      int index = 0;
      
      while (myReader.hasNextLine()) {
        String data = myReader.nextLine();
        if(!data.equals("")){
        String[] param = data.split(" ");
        print(param[0]);
        print(param[1]);
        float x = Float.valueOf(param[0]);
        float y = Float.valueOf(param[1]);
        ArrayList<Integer> nb = new ArrayList();
        String[] nbi = param[2].split(",");
        for(int i = 0; i<nbi.length; i++){
          nb.add(Integer.parseInt(nbi[i]));
        }
        nbrs.add(nb);
        out.add(new Node(x,y,index));
        
        index++;
      }
      }
      myReader.close();
    } catch (FileNotFoundException e) {
      e.printStackTrace();
    }
    
    
    for(int i = 0; i< out.size(); i++){
      for(int j = 0; j< nbrs.get(i).size(); j++){
        out.get(i).neighbours.add(out.get(nbrs.get(i).get(j)));
      }
    }
 
     return out;
    
  }
 
   
 
 

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
class Message{


boolean reached = false;
Node destination;
Node finalDestination;
Node sender;
Node origin;
String content;
int hopCount = 0;
float t = 0;

float posx;
float posy;
int r=0;
int g=255;
int b=0;

Message(Node dest, Node finDest, Node orig, Node sen, String con){
  this.destination = dest;
  this.finalDestination = finDest;
  this.origin = orig;
  this.sender = sen;
  this.content = con;
  this.r = (int)random(0,255);
  this.g = (int)random(0,255);
  this.b = (int)random(0,255);
  posx=sender.posx;
  posy=sender.posy;
  
  if(dest==sen){this.t=1;}
}

public void update(ArrayList<Node> nodes, int speed){
  t+=0.005f*speed;
  posx=sender.posx+t*(destination.posx-sender.posx);
  posy=sender.posy+t*(destination.posy-sender.posy);
  
  if(t>=1){
    destination.handle(this, nodes);
  }
}

public void show(){
  push();
  fill(r,g,b);
  circle(posx, posy, 10);
  pop();
}




}
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
  
  
  public void show(){
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
  
  public void makeDists(ArrayList<Node> in){this.distances = floydWarshall(in, this);}
  
  
  
  public void probe(ArrayList<Node> in){
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

  
   public void displayRoutingTable(ArrayList<Node> in){

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
   
   
   
   
   
   
   
   public Message genMsg(ArrayList<Node> nodes){
     int target = (int)random(0,nodes.size());
     Message msg =  new Message(routing.get(nodes.get(target)), nodes.get(target), this, this, "hello node");
     return(msg);
   }
  
  public void handle(Message msg, ArrayList<Node> nodes){
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
  

    
 
  
  
  public HashMap<Node, Integer> floydWarshall(ArrayList<Node> nodes, Node start){
    
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
  
  
  public void dispMat(int[][] in){
    for(int k = 0; k < in.length; k++){
       for(int i = 0; i<in[0].length; i++){
         print(in[k][i]+", ");
       }
       println("");
     }
  }
  
  
}
  public void settings() {  size(1000, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Network_simulation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
