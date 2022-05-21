import java.util.Collections;
import java.math.RoundingMode;
import java.text.DecimalFormat;

class Analyzer{
  
  private  final DecimalFormat df = new DecimalFormat("0.00");
  
  void barGraph(ArrayList<Float> in, float x, float y, float w, float h){
    float size = Collections.max(in)*1.2;
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
  
  
  
  void lineGraph(ArrayList<ArrayList<Float>> in, float x, float y, float w, float h){
    rect(x,y,w,h);
    float[] maxlist = new float[in.size()];
    float[] sizelist =new float[in.size()];
    for(int i =0; i<in.size(); i++){
      maxlist[i] = Collections.max(in.get(i))*1.2;
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
