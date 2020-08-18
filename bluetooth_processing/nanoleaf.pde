class nanoleaf {
  int x1;
  int y1;
  int x2;
  int y2;
  int x3;
  int y3;
  nanoleaf(int x1_, 
    int y1_, 
    int x2_, 
    int y2_, 
    int x3_, 
    int y3_) {
    x1=x1_;
    y1=y1_;
    x2=x2_;
    y2=y2_;
    x3=x3_;
    y3=y3_;
  }
  void display() {
    triangle(x1, y1, x2, y2, x3, y3);
  }
}
