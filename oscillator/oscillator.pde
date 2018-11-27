void setup() {
  size(640,360);
}

float angle = 0;
float aVelocity = 0.3;

void draw() {
  background(0);

  float amplitude = 6;
  float x = amplitude * cos(angle);
  // Using the concept of angular velocity to increment an angle variable
  angle += aVelocity;

  ellipseMode(CENTER);
  noStroke();
  fill(0, 255, 255);
  translate(width/2,height/2);
  ellipse(x,0,4,4);
}
