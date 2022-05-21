class Letter {
    int occurances = 1;
    char name;
    String code;
    public Letter(char in){
        name = in;
    }

    @Override
    public String toString() {
        return ""+name;
    }
}
