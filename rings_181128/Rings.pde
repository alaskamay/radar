
class Ring { 
  //color c = 255;
  float size;
  float sizeMap;

  Ring (color c_, float size_) {
    c = c_;
    size = size_;
  }

  void display() {
    stroke(0, 100, 20, c);
    noFill();
    ellipse(width/2, height/2, size, size);
  }

  void move() {
    size += 1;
    c--;
    println(size);
    println(c);
    
  }

  
}