import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;

PGraphics vizMask;

float water = 0;
float wind = 0;
float solar = 0;

float t = 0;

float rotate = 0.1;

UnfoldingMap map;

void setup() {
  //fullScreen();
  size(1050, 1050, P3D);
  frameRate(60);
  smooth();

  // prepare mask  
  vizMask = createGraphics(width, height);
  vizMask.beginDraw();
  vizMask.background(0);
  vizMask.ellipse(width/2, height/2, height, height);
  vizMask.endDraw();
  
  loadSolar();
  loadWater();
  loadWind();
} 

void draw() {
  // increment time
  t += 1.0 / 60.0 / 15.0;
  
  // draw viz
  vizWind();
  vizWater();
  vizSolar();
  

  // get image
  PImage i = get();

  // mask image
  i.mask(vizMask);

  // draw image
  background(0);
  image(i, 0, 0, width, height);

  // draw radarpointer
  //setGradient(0, 0, width/2, height, color(0, 0, 0, 0), color(0, 0, 0, 100), X_AXIS);
  /*
	pushMatrix();
	translate(width/2,height/2);
	rotate(s*radians(90));
	triangle(-30, 30, 0, -30, 30, 30); 
	popMatrix();
  */

  pushMatrix();
  rotate(.2);
  popMatrix();
  
  // reset time
  if (t > 1) {
    t = 0;
  }
}

int Y_AXIS = 1;
int X_AXIS = 2;

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}

void keyPressed() {
  float delta = 0.1;

  switch(key) {
  case 'q':
    water = constrain(water + delta, 0, 1);
    break;
  case 'w':
    wind = constrain(wind + delta, 0, 1);
    break;
  case 'e':
    solar = constrain(solar + delta, 0, 1);
    break;
  case 'a':
    water = constrain(water - delta, 0, 1);
    break;
  case 's':
    wind = constrain(wind - delta, 0, 1);
    break;
  case 'd':
    solar = constrain(solar - delta, 0, 1);
    break;
  }
  
  println("water: " + water + ", wind: " + wind + ", solar:", + solar);  
}
