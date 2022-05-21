

float[][] pic = new float[1000][1000];

void setup(){
  size(1000, 1000);
  noStroke();
  
  //stripey try 
  /**
  float curX = 63.75;
  float curY = 63.75;
  for(int i = 0; i<pic.length; i++){
    float lcurX = curX;
    for(int j = 0; j<pic[0].length; j++){
      curX=randChange(curX);
      pic[j][i] = curY+curX;
    }
    curX=randChange(lcurX);
    curY=randChange(curY);
  }
   **/
   //offset of avg try

   for(int i = 0; i<pic.length; i++){
      for(int j = 0; j<pic[0].length; j++){
        pic[i][j]=127;
      }
    }
    
   for(int i = 2; i<pic.length; i++){
      for(int j = 2; j<pic[0].length; j++){
        pic[i][j]=randChange(1.0/2.0*(pic[i-1][j]+pic[i][j-1]));
      }
    }
    for(int i = 998; i>0; i--){
      for(int j = 2; j<pic[0].length; j++){
        //  pic[i][j]=randChange(1.0/81.0*(40*pic[i+1][j]+40*pic[i][j-1]+pic[i][j]));
      }
    }
   
 
   
  float iv = 0.01;
   

   
   
  
  for(int i = 0; i<pic.length; i++){
    for(int j = 0; j<pic[0].length; j++){
     pic[i][j]=(pic[i][j]-127.5)*10+127.5;
    }
  }
  for(int i = 0; i<6; i++){
   //pic = blur(pic);
  }
  frameRate(2);
}

void draw(){
  for(int i = 0; i<pic.length; i++){
    for(int j = 0; j<pic[0].length; j++){
      fill(pic[i][j]);
      rect(i,j,1,1);
    }
  }
}

float[][] blur(float[][] in){
float[][]out =new float[in.length][in[0].length];
for(int i = 0; i<in.length; i++){
    for(int j = 0; j<in[0].length; j++){
      float avg = 0;
      float amt = 0;
      for(int k = -2; k<3; k++){
        for(int l = -2; l<3; l++){
          amt++;
          try{
            avg+=in[i+k][j+l];
          }catch(Exception e){}
        }
      }
      out[i][j]=avg/amt;
    }
  }
  return out;
}

float randChange(float in){
  float r = random(0,1);
  if(r<1.0/3.0){
    return in+1;
  }else if(r<2.0/3){
    return in-1;
  }else{
    return in;
  }
}
