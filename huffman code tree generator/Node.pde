

class Node implements Comparable<Node>{
    int value = 0;
    Letter letter;
    String code;
    private Node left;
    private Node right;

    public Node(Node r, Node l){
        value = l.value+r.value;
        right = r;
        left = l;
    }

    public Node(Letter l){
        value = l.occurances;
       letter = l;
    }

    public int compareTo(Node other){
        if(this.value> other.value){
            return 1;
        }else if(this.value< other.value){
            return -1;
        }else{
            return 0;
        }
    }

    public Node getLeft() {
        return left;
    }

    public Node getRight() {
        return right;
    }
}
