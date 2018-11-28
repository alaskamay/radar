void setup() {
  size(640,360);
}

PVector angle;
PVector velocity;
PVector amplitude;

void draw() {
  background(0);

  angle = new PVector();
  velocity = new PVector(random(-0.01,0.01),random(-0.01,0.01));
  amplitude = new PVector(random(width/2),random(height/2));

  angle.add(velocity);

  float x = sin(angle.x)*amplitude.x;
  float y = sin(angle.y)*amplitude.y;

  pushMatrix();
  translate(width/2,height/2);
  stroke(0);
  fill(0,255,255);
  ellipse(x,y,4,4);
  popMatrix();
}
