PrintWriter data;


void setup(){
  size(140, 40);
  fill(255);
  frameRate(244);
  data = createWriter("/Users/hannes/Desktop/informatik/Java/processing/Generate_NN_training_data/data.txt");
}
int picNr = 0;



void draw(){
    picNr++;
   if(picNr<1000){
    fill(255);
    rect(0,0,width-1,height-1);
    fill(255,0,0);
    float value = random(0,100);
    rect(value,0,39,39);
    PImage img = get(0,0,width,height);
    
    img.save("/Users/hannes/Desktop/informatik/Java/processing/Generate_NN_training_data/images/"+picNr+".jpg");
    data.println(value);
  }else{
    data.flush();
    data.close();
    exit();
  }
}
