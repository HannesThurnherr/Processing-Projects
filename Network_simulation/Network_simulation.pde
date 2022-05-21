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
int borderRadius = 10;
private  final DecimalFormat df = new DecimalFormat("0.00");
float avgDistance =0;

 
 
Analyzer ana;
File_Handler fh;

void setup(){
  
  
  
  size(1000, 1000);
  ana = new Analyzer();
  fh=new File_Handler();
  speedSlider=new HScrollbar(780,  450, 200, 10, 2, 0, 106);
  msgGenSlider=new HScrollbar(780,  400, 200, 10, 2, 0, 106);
  
  
  //fh.makeCircleFile(100);
}

void draw(){
  
  background(50);
  if(netFinished){
    runNet();
  }else{
    makeNet();
  }
}


float avgDist(){
  float sumDist = 0;
  float divisor = 0; 
  for(int i = 0; i<nodes.size(); i++){
    Node n = nodes.get(i);
    for(int j = 0; j<nodes.size(); j++){
      Node m = nodes.get(j);
      if(m!=n){
        sumDist += n.distances.get(m);
        divisor++;
      }
    }
  }
  println(sumDist);
  println("divisor: "+divisor);  
  return (sumDist/divisor);
}


void makeNet(){
  
  
  
  if(conStarted){
    rect(0,0,150, 50, 10);
    push();
    fill(0);
    text("connection started", 30, 30, borderRadius);
    
    stroke(0, 255,0);
    line(node1.posx, node1.posy, mouseX, mouseY);
    pop();
  }  
    fill(0, 255, 0);
    rect(890, 10, 100, 50, borderRadius);
    fill(255);
    rect(10, 850, 140, 140, borderRadius);
    rect(890, 70, 100, 50, borderRadius);
    rect(890, 130, 100, 50, borderRadius);
    push();
    fill(0);
    
    text("RUN", 925, 40);
    text("Export Net", 910, 100);
    text("Import Net", 910, 160);
    text("Delete Node", 40, 920);
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


void runNet(){
  for(int i = 0; i<nodes.size(); i++){
    if(random(0,1)<floor(msgGenSlider.getPos()*msgGenSlider.getPos())*0.0001){
        msgs.add(nodes.get(i).genMsg(nodes));
    }
  }
  rect(10,10,150,50, borderRadius);
  push();
  fill(0);
  text("modify network", 40, 40);
  fill(255);
  textSize(15);
  text("Average Distance: "+df.format(avgDistance), 800, 200);
  pop();
  
  drawNet();
  
  rect(760, 360, 230, 120, borderRadius);
  push();
  textSize(15);
  fill(0);
  text("Speed: "+floor(speedSlider.getPos())+"%", 785, 440);
  text("Message Generation: "+floor(msgGenSlider.getPos())+"%", 785, 390);
  speedSlider.display();
  speedSlider.update();
  msgGenSlider.display();
  msgGenSlider.update();
  pop();
  
  //totalMsgBar();
  avgHopBar();
  avgHopLine();
}


void mouseClicked(){
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


void createRouting(){
  
  
  
  for(int i = 0; i<nodes.size(); i++){
    nodes.get(i).address= i;
    nodes.get(i).makeDists(nodes);
  }
  for(int i = 0; i<nodes.size(); i++){
    nodes.get(i).probe(nodes);
  }  
  
  avgDistance = avgDist();
}

  void mouseDragged(){
    for(int i = 0; i<nodes.size(); i++){
      Node ve=nodes.get(i);
      if(abs(ve.posx-mouseX)<30 && abs(ve.posy-mouseY)<30){
        ve.posx=mouseX;
        ve.posy=mouseY;
      }
    }
  }
  
void avgHopBar(){
  ArrayList<Float> n = new ArrayList(); 
  for(int i = 0; i<nodes.size(); i++){
    n.add(nodes.get(i).avgHop);
  }
  ana.barGraph(n,700,700,200,200);
}

void totalMsgBar(){
  ArrayList<Float> n = new ArrayList(); 
  for(int i = 0; i<nodes.size(); i++){
    n.add(nodes.get(i).totalMsg);
  }
  ana.barGraph(n,450,650,500,300);
}

void avgHopLine(){
ArrayList<ArrayList<Float>> n = new ArrayList(); 
  for(int i = 0; i<nodes.size(); i++){
    n.add(nodes.get(i).avgHopHist);
  }
  ana.lineGraph(n,100,700,300,200);
}


void removeNode(Node in){
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
  
    
void buildNetClicks(){     
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
    if(mouseY>50&&(mouseX<900||mouseY>180)){
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
if(mouseX>890&&mouseY<60){
  if(nodes.size()>0){
  createRouting();
  netFinished=true;
  }
}
if(mouseX>890&&mouseY>70&&mouseY<120){
  fh.exportNet(nodes);
  justExported=50;
}
if(mouseX>890&&mouseY>130&&mouseY<180){
  fh.chooseNet();
  choosingNet = true;
  
}}



void chooseNetClicks(){
  if(abs(mouseX-892.5)<7.5&&abs(mouseY-107.5)<7.5){
     choosingNet = false;
  }else{
  int xpos = floor((mouseX-100)/200);
  int ypos = floor((mouseY-100)/200);
  nodes = fh.importNet(ypos*4+xpos);
  msgs = new ArrayList();
  choosingNet = false;
  }
  
}





void drawNet(){
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
