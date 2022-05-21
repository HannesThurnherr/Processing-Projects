import java.io.File;  
import java.io.IOException;
import java.io.FileWriter;   
import java.io.FileNotFoundException;  
import java.util.Scanner; 
class File_Handler{
  
  String netFolder = "Desktop/informatik/Java/processing/Network_simulation/Networks/";
  
  int nr = 1;
  
 void exportNet(ArrayList<Node> in){
   
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
 
 
 void chooseNet(){
   File directory=new File(netFolder);
   nr=directory.list().length/2;
   push();
   fill(100);
   rect(50, 50, 900, 900, 20);
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
 
 void displayNet(float x,float y, int n){
   PImage img = loadImage(netFolder+"netImg"+n+".jpg");
   image(img, x+25, y+10, 150, 150);
   
   fill(0);
   text("Net "+n, x+50, y+180); 
   
}
 
 
 
 
 
 
 
 ArrayList<Node> importNet(int in){
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
 
   
 void makeCircleFile(float in){
   String content = "";
   
   for(float i = 0; i<in; i++){
     String str="";
     str+=(450-(300*cos(2*PI*(i/in))))+" ";
     str+=(450+(300*sin(2*PI*(i/in))))+" ";
     if(i==0){
       str+=(int)i+","+1+","+0;
     }else if(i==in-1){
       str+=((int)in-1)+","+0+","+(int)(i-1);
     }else{
       str+=(int)(i-1)+","+(int)i+","+(int)(i+1);
     }
     content+= str+"\n";
   }
   
   println(content);
 }
 

}
