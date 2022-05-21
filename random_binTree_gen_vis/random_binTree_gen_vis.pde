
Node root;

void setup() {
  root = new Node(0);
  size(1000, 1000);
  genBinTree(root, 0.97, 80, 0);
  frameRate(25);
}

int counter = 0;

void genBinTree(Node r, float prob, int maxLayer, int layer) {
  
  counter++;
  println(counter);
  if (layer<maxLayer) {
    if (random(0, 1)<pow(prob, layer)) {
      r.left=new Node(counter);
      genBinTree(r.left, prob, maxLayer, layer+1);
    }
    if (random(0, 1)<pow(prob, layer)) {
      r.right=new Node(counter);
     
      genBinTree(r.right, prob, maxLayer, layer+1);
    }
  }
  
}


void draw() {
  
  background(255);
  root.display(500, 100, 1, mouseX*10);
}
