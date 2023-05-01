
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

float s = -0.4;
float m = 2.5;
float l = 1.16;
float t = 10;
void setup(){
size(1000, 1500);
background(255);
//String test = "An academic career in which a person is forced to produce scientific writings in great amounts creates a danger of intellectual superficiality, Einstein said.";
String test = "alain joss";
visNode(prefixCode(test), 500, 50, 1);


}


void visNode(Node n, float x, float y, float layer){
 
  if(n.getRight()!=null){
    line(x, y, x+width/pow(m,layer+s)/2, y+width/pow(l,layer+t));
    visNode(n.getRight(), x+width/pow(m,layer+s)/2, y+width/pow(l,layer+t), layer+1);
  }
  if(n.getLeft()!=null){
    line(x, y, x-width/pow(m,layer+s)/2, y+width/pow(l,layer+t));
    visNode(n.getLeft(), x-width/pow(m,layer+s)/2, y+width/pow(l,layer+t), layer+1);
  }
  fill(255);
  circle(x,y,1);
  fill(0);
  textSize(18/pow(layer, 0.2));
  text(n.value, x-10, y+20);
  if(n.letter!=null){
    text("'"+n.letter.name+"'", x-10, y+50);
  }
  textSize(8);
  text(n.code, x-10, y+29);
}








Node prefixCode(String s){
        String out = "";
        
        
        HashMap<Character, Integer> listOfLettersUsed = new HashMap<Character, Integer>();
        
        
        
        ArrayList<Letter> letters = new ArrayList<Letter>();
        ArrayList<Node> tree = new ArrayList<Node>();
        HashMap<Character, String> codes = new HashMap<Character, String>();


        for(int i = 0; i<s.length(); i++){
            Character c = s.charAt(i);
            Letter cl = new Letter(c);
             if(listOfLettersUsed.get(c)==null) {
                 listOfLettersUsed.put(c, listOfLettersUsed.size());
                 letters.add(cl);
            }else{
                letters.get(listOfLettersUsed.get(c)).occurances++;
            }
        }
       for(int i = 0; i<letters.size(); i++){
           tree.add(new Node(letters.get(i)));
       }

       int k =0;
       while(k+1< tree.size()){
           Collections.sort(tree);
           Node newN = new Node(tree.get(k), tree.get(k+1));
           tree.add(newN);
           k+=2;
       }
       tree.get(tree.size()-1).code="";
       giveCode(tree.get(tree.size()-1));

        for(int i = 0; i<letters.size(); i++){
            codes.put(letters.get(i).name, letters.get(i).code);
        }
        for(int i = 0; i<s.length(); i++){
            out+=codes.get(s.charAt(i));
        }
        return tree.get(tree.size()-1);
    }

    public static void giveCode(Node in){
   
        if(in.letter==null){
        in.getLeft().code = in.code+"0";
        giveCode(in.getLeft());
        in.getRight().code = in.code+"1";
        giveCode(in.getRight());
        }else{
            in.letter.code=in.code;
            System.out.println("\""+in.letter.name+"\""+" appears "+ in.letter.occurances+" times and has code: "+in.letter.code);
        }
    }
    
    
    
    
