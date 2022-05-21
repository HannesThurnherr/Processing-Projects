class Field{
float x;
float y;

public Field(float i, float j){
  x=i;
  y=j;
 //x=random(1000);
 //y=random(1000);
}


void show(float r, float g, float b){
push();


fill(r,g,b);

rect(x,y,10,10);
pop();
}



}
