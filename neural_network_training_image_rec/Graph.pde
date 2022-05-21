class Graph{

void display(ArrayList<Float> in, float max, float x, float y, float w, float h){
  fill(0);
float inc = w/in.size();
for(int i = 0; i<in.size()-1; i++){

line(x+(i*inc), (y+h)-(in.get(i)*(h/max)), x+((i+1)*inc), (y+h)-(in.get(i+1)*(h/max)));

if(i==in.size()-2){ text(in.get(i+1),x+((i+1)*inc), y+h-(h*(in.get(i+1)/max)));}
}
}


}
