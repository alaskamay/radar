String solarFile = "solar_nospaces.csv";
int solarSize = 5;
ArrayList<SolarPos> solarPositions = new ArrayList();

void loadSolar() {
  background(0);
  // Create interactive map centered around Switzerland
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(new Location(46.986991, 8.178334), 8);
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);
 
  // Load CSV Solar data
  Table solarDataCSV = loadTable(solarFile, "header, csv");

  for (TableRow solarPosRow : solarDataCSV.rows()) {
    SolarPos solarPos = new SolarPos();
    float lat = solarPosRow.getFloat("Latitude");
    float lng = solarPosRow.getFloat("Longitude");
    solarPos.location = new Location(lat, lng);
    solarPositions.add(solarPos);
  }
}

void vizSolar() {
  float pointDist;
  float pointRad;
  float pointAngle;
  float pointerDist;
  float pointOpacity;
  float pointRadInner;
  int pointerDistMin = 0;
  int pointerDistMax = 80;
  noStroke();

  for (SolarPos solarPos : solarPositions) {
    ScreenPosition pos = map.getScreenPosition(solarPos.location);
    pointDist = dist(width/2, height/2, pos.x, pos.y);
    pointRadInner = (pos.x - (width/2)) / pointDist;
    if(pos.y < (height/2)) {
      pointAngle = map(pointRadInner, 1, -1, 3, 180);
    } else {
      pointAngle = map(pointRadInner, -1, 1, 183, 360);
    }
    //pointAngle = degrees(pointRad);
    pointerDist = pointerAngle - pointAngle;
    if(pointerDist < -340 && pointerDist > -360) {
      pointerDist = map(pointerDist, -300, -360, 150, 0);
    }
    if(pointerDist < pointerDistMax && pointerDist > pointerDistMin) {
      pointOpacity = map(pointerDist, pointerDistMax, pointerDistMin, 0, 100);
      noStroke();
      fill(255, 255, 0, pointOpacity);
      ellipse(pos.x, pos.y, solarSize, solarSize);
      if(solar > 0 && pointerDist > 0) {
        noFill();
        stroke(255, 255, 0, pointOpacity);
        ellipse(pos.x, pos.y, 50/pointerDist, 50/pointerDist);
      }
    }
  }
}
