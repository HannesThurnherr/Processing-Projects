class Node {
  float value;
  float bias = 0;
  float w = 1;

  void recive(float[] in) {
    float sum = 0;
    for (int i = 0; i < in.length; i++) {
      sum+=in[i];
    }
    value = atan(sum*w+bias)/PI*2;
  }

  float getValue() {
    return this.value;
  }

  void setValue(float in) {
    value = in;
  }

  void setBiasAndW(float b, float wIn) {
    bias=b;
    w=wIn;
  }


  public void show(float x, float y) {

    //push();
    fill(value*128+128);
    circle(x, y, 15);
    fill(230, 130, 0);
    //text(value, x-5, y-5);
    //pop();
  }






  public void mutate(float biasMutation, float wMutation) {

    float bFactor = random(-biasMutation, biasMutation);
    float wFactor = 1+random(-wMutation, wMutation);

    bias+=bFactor;
    w*=wFactor;
  }
}
