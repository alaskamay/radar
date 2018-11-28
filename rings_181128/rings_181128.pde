

Ring[] rings = new Ring[5]; 
float cMap;
int cTrans;
int c = 255;

void setup() {
  size(480, 270);
  // Initialize each Ring using a for loop.
  for (int i = 0; i < rings.length; i ++ ) { 
    //cMap = map(i, 0, rings.length, 0, 255);
    //cTrans = floor(cMap);
    rings[i] = new Ring(c, (5*i)*2);
  }
}

void draw() {
  background(255);
  // Run each Ring using a for loop.  
  for (int i = 0; i < rings.length; i++) { 
    rings[i].move();
    rings[i].display();
  }
}