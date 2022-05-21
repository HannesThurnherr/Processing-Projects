int size = 200;
import java.util.Scanner;
String zeile1 = "Hannes";
String zeile2 = "Leidet an der Uni";

//String zeile1 = "ewedaasde";
//String zeile2 = "sfaldeala";
boolean[][] verticalLines = new boolean[zeile1.length()][zeile2.length()];
boolean[][] horizontalLines = new boolean[zeile2.length()][zeile1.length()];


void setup(){
size(1000, 1000);
verticalLines = makeVLines(vowelBinary(zeile1), vowelBinary(zeile2));
horizontalLines = makeVLines(vowelBinary(zeile2), vowelBinary(zeile1));
}

void draw(){
  background(255, 0, 0);
  stroke(255);
  for(int i = 0; i<zeile1.length(); i++){
    for(int j = 0;j<zeile2.length(); j++){

      if(verticalLines[i][j]){
        line((float)width/(zeile1.length())*i, (float)height/(zeile2.length())*j, (float)width/(zeile1.length())*i, (float)height/(zeile2.length())*(j+1));
      }
      if(horizontalLines[j][i]){
        line((float)width/(zeile1.length())*i,(float) height/(zeile2.length())*j, (float)width/(zeile1.length())*(i+1), (float)height/(zeile2.length())*(j));
      }
      //text("i: "+i+" j: "+j, width/(zeile1.length())*i, height/(zeile2.length())*j);
    }
  }
  //makeCrossesWhite();
  //buttons();
  
  if(newW){
    push();
      rect(200, 200, 600, 600);
      String newOne = "";
      String newTwo = "";
      
    
    pop();
    
  }
}



boolean[][] makeVLines(String in1, String in2){
  boolean[][] out = new boolean[in1.length()][in2.length()];
  
  for(int i = 0; i<in1.length(); i++){
    boolean filled = false;
    if(in1.charAt(i)=='1'){
      filled=true;
    }
    for(int j = 0; j<in2.length(); j++){
      if(filled){
        out[i][j]=true;
      }else{
        out[i][j]=false;
      }
      filled=!filled;
    }
  }
  return out;
}



String randomBinary(int in){
 String out ="";
for( int i = 0; i < in; i++){
  if(random(0,1)<0.5){
    out+="1";
  }else{
    out+="0";
  }
}
return out;
}


String vowelBinary(String in){
 String out ="";
 in=in.toLowerCase();
for( int i = 0; i < in.length(); i++){
  if(in.charAt(i)=='a'||in.charAt(i)=='e'||in.charAt(i)=='i'||in.charAt(i)=='o'||in.charAt(i)=='u'){
    out+="1";
  }else{
    out+="0";
  }
}
return out;
}


void makeCrossesWhite(){
  fill(255);
  for(int i = 0; i<verticalLines.length; i++){
  for(int j = 0; j<verticalLines[0].length; j++){
    try{
      if(!verticalLines[i][j]&&verticalLines[i+1][j]&&verticalLines[i+2][j]&&!verticalLines[i+3][j]){

        if(!horizontalLines[j][i]&&horizontalLines[j+1][i]&&horizontalLines[j+2][i]&&!horizontalLines[j+3][i]){
          
         rect((float)width/verticalLines.length*(i+1),(float) height/verticalLines[0].length*j, width/verticalLines.length, height/verticalLines.length);
         rect((float)width/verticalLines.length*(i), (float)height/verticalLines[0].length*(j+1), width/verticalLines.length, height/verticalLines.length);
         rect((float)width/verticalLines.length*(i+1), (float)height/verticalLines[0].length*(j+1), width/verticalLines.length, height/verticalLines.length);
         rect((float)width/verticalLines.length*(i+2), (float)height/verticalLines[0].length*(j+1), width/verticalLines.length, height/verticalLines.length);
         rect((float)width/verticalLines.length*(i+1),(float) height/verticalLines[0].length*(j+2), width/verticalLines.length, height/verticalLines.length);

        }
      }
    }catch(Exception e){}
  }
  }
}




void printArray(boolean[][] in){
  for(int i = 0; i<in.length; i++){
    for(int j = 0; j<in[0].length; j++){
      print(in[i][j]+", ");
    }
    println("");
  }
  
 
}


void buttons(){
push();
  fill(255);
rect(width-100, 0, 100, 50);
fill(0);
text("enter new text", width-90, 40);
pop();
}

boolean newW = false;

void mouseClicked(){
  if( mouseX>width-100&&mouseY<50){
    newW=true;
  }
}
String saved ="";
String typing="";


void keyPressed() {
  if(newW){
  if (key == '\n' ) {
    saved = typing;
    typing = ""; 
    } else {
      typing = typing + key; 
    }
  }
}
