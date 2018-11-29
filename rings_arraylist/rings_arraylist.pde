ArrayList<Particle> particles;

void setup() {
  size(480, 270);
  particles = new ArrayList<Particle>();
  frameRate(30);
}

void draw() {
  // A new Particle object is added to the ArrayList every cycle through draw().
  particles.add(new Particle(width/2, height/2)); 

  background(255);
  fill(0);
  //ellipse(width/2, height/2, 110, 110);
  // Iterate through our ArrayList and get each Particle
  // The ArrayList keeps track of the total number of particles.
  for (Particle p : particles) { 
    p.run();
    p.display();
  }

  // If the ArrayList has more than 100 elements in it, we delete the first element, using remove().
  if (particles.size() > 5) {
    particles.remove(5);
    //particles.clear();
  }
}