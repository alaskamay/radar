String waterFile = "water_nospaces.csv";
int waterSize = 4;
ArrayList<WaterPos> waterPositions = new ArrayList();
ArrayList<Particle> particles;

void loadWater() {
  background(0);
  // Create interactive map centered around Switzerland
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(new Location(46.986991, 8.178334), 8);
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);
  particles = new ArrayList<Particle>();

  // Load CSV Wind data
  Table waterDataCSV = loadTable(waterFile, "header, csv");

  for (TableRow waterPosRow : waterDataCSV.rows()) {
    WaterPos waterPos = new WaterPos();
    float lat = waterPosRow.getFloat("Latitude");
    float lng = waterPosRow.getFloat("Longitude");
    waterPos.location = new Location(lat, lng);
    waterPositions.add(waterPos);
  }
}

void vizWater() {
  float pointDist;
  float pointRad;
  float pointAngle;
  float pointerDist;
  float pointOpacity;
  float pointRadInner;
  int pointerDistMin = 0;
  int pointerDistMax = 100;
  noStroke();

  for (WaterPos waterPos : waterPositions) {
    ScreenPosition pos = map.getScreenPosition(waterPos.location);
    pointDist = dist(width/2, height/2, pos.x, pos.y);
    pointRadInner = (pos.x - (width/2)) / pointDist;
    pointRad = acos(pointRadInner);
    pointAngle = degrees(pointRad);
    pointerDist = pointerAngle - pointAngle;
    if(pointerDist < pointerDistMax && pointerDist > pointerDistMin) {
      pointOpacity = map(pointerDist, pointerDistMax, pointerDistMin, 0, 80);
      particles.add(new Particle(pos.x, pos.y, waterSize, pointColor, pointOpacity); 
      for (Particle p : particles) { 
        p.run();
        p.display();
      }
      if (particles.size() > 5) {
        particles.remove(5);
      }
      fill(0, 255, 255, pointOpacity);
      ellipse(pos.x, pos.y, waterSize, waterSize);
    }
  }
}
