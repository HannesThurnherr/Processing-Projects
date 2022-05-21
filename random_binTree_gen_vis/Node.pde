class Node {
  int value;
  Node right;
  Node left;

  Node(int v) {
    this.value = v;
  }

  void display(float x, float y, float layer, float offset) {
   // println("x: "+x+" y: "+y);
    if (left!=null) {
      line(x, y, x-offset*pow(0.5, layer), y+500/(layer*3));
      left.display( x-offset*pow(0.5, layer), y+500/(3*layer), layer+1, offset);
    }
    if (right!=null) {
      line(x, y, x+offset*pow(0.5, layer),  y+500/(3*layer));
      right.display( x+offset*pow(0.5, layer), y+500/(3*layer), layer+1, offset);
    }
  }
  
  
}
