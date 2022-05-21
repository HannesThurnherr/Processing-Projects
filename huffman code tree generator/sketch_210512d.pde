
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
String test = "In computer science, a binary tree is a tree data structure in which each node has at most two children, which are referred to as the left child and the right child. A recursive definition using just set theory notions is that a (non-empty) binary tree is a tuple (L, S, R), where L and R are binary trees or the empty set and S is a singleton set containing the root.[1] Some authors allow the binary tree to be the empty set as well.[2]From a graph theory perspective, binary (and K-ary) trees as defined here are arborescences.[3] A binary tree may thus be also called a bifurcating arborescence[3]—a term which appears in some very old programming books,[4] before the modern computer science terminology prevailed. It is also possible to interpret a binary tree as an undirected, rather than a directed graph, in which case a binary tree is an ordered, rooted tree.[5] Some authors use rooted binary tree instead of binary tree to emphasize the fact that the tree is rooted, but as defined above, a binary tree is always rooted.[6] A binary tree is a special case of an ordered K-ary tree, where k is 2.In mathematics, what is termed binary tree can vary significantly from author to author. Some use the definition commonly used in computer science,[7] but others define it as every non-leaf having exactly two children and don't necessarily order (as left/right) the children either.[8]In computing, binary trees are used in two very different ways:First, as a means of accessing nodes based on some value or label associated with each node.[9] Binary trees labelled this way are used to implement binary search trees and binary heaps, and are used for efficient searching and sorting. The designation of non-root nodes as left or right child even when there is only one child present matters in some of these applications, in particular, it is significant in binary search trees.[10] However, the arrangement of particular nodes into the tree is not part of the conceptual information. For example, in a normal binary search tree the placement of nodes depends almost entirely on the order in which they were added, and can be re-arranged (for example by balancing) without changing the meaning.Second, as a representation of data with a relevant bifurcating structure. In such cases, the particular arrangement of nodes under and/or to the left or right of other nodes is part of the information (that is, changing it would change the meaning). Common examples occur with Huffman coding and cladograms. The everyday division of documents into chapters, sections, paragraphs, and so on is an analogous example with n-ary rather than binary trees.";
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
    text(n.letter.name, x-10, y+50);
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
    
    
    
    
