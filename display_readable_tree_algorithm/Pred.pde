
class Pred{
  String txt;
  ArrayList<Pred> cld = new ArrayList();
  
 Pred(String t){
     print("predicate setup");
    this.txt = t;
  }
  
  void show(float x,float y, int level){
     if(level == 0){
     line(x+this.txt.length()*2.5+10, y, 500, 0);
     float filled = 0;
     for(int i = 0; i <cld.size(); i++){
       line(x+this.txt.length()*2.5+10, y+40, x-400+filled+cld.get(i).txt.length()*2.5+10, y+100);
       cld.get(i).show(x-400+filled, y+100, level+1);
       filled +=cld.get(i).txt.length()*5+30; 
     }
     float w = this.txt.length()*5+20;
     rect(x, y, w, 40);
     push();
     fill(0);
     text(this.txt, x+10, y+20);
     pop();
     
     }else if(level == 1){
       float w = this.txt.length()*5+20;
     rect(x, y, w, 40);
     push();
     fill(0);
     text(this.txt, x+10, y+20);
     pop();
     
     for(int i = 0; i<cld.size(); i++){
        this.cld.get(i).show(x-txt.length()/4+(i+1)*txt.length()*8/cld.size()/2, y+100, level+1);
        line(x+this.txt.length()*2.5+10, y+40, x-txt.length()/4+(i+1)*txt.length()*8/cld.size()/2, y+100);
     }
     }else{
       circle(x, y, 20);
       for(int i = 0; i<cld.size(); i++){
        this.cld.get(i).show(x-txt.length()/2+i*txt.length()/cld.size(), y+100, level+1);
        line(x+this.txt.length()*2.5+10, y+40, x-txt.length()/2+i*txt.length()/cld.size(), y+100);
       }
     }
  }
  
  
}
