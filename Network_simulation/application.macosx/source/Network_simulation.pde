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

void setup(){
  size(1000, 1000);
  ana = new Analyzer();
  fh=new File_Handler();
  speedSlider=new HScrollbar(790,  450, 200, 10, 2, 0, 106);
  msgGenSlider=new HScrollbar(790,  400, 200, 10, 2, 0, 106);
}

void draw(){
  
  background(50);
  if(netFinished){
    runNet();
  }else{
    makeNet();
  }
  
  
  
}


void makeNet(){
  
  
  
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


void runNet(){
  for(int i = 0; i<nodes.size(); i++){
    if(random(0,1)<floor(msgGenSlider.getPos()*msgGenSlider.getPos())*0.0001){
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
