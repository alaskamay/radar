// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 23-2: Simple particle system with ArrayList

// A simple Particle class
class Particle {
  
  float size;
  float alpha;
  float mapAlpha;
  float x;
  float y;
  
  Particle(float posX, float posY) {
    size = 80;
    alpha = 255;
    x = posX;
    y = posY;
  }
  
  void run() {
    if(size == 400) {
      size = 100;
    }
    size += 10;
    mapAlpha = floor(map(size, 100, 200, 255, 0));
  }

  
  void display() {
    fill(0,75);
    //ellipse(width/2, height/2, 110, 110);
    noFill();
    stroke(0, mapAlpha);
    strokeWeight(2);
    ellipse(x, y, size,size);
  }
}