String solarFile = "solar_nospaces.csv";
int solarSize = 1;
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
  int pointerDistMax = 60;
  noStroke();

  for (SolarPos solarPos : solarPositions) {
    ScreenPosition pos = map.getScreenPosition(solarPos.location);
    pointDist = dist(width/2, height/2, pos.x, pos.y);
    pointRadInner = (pos.x - (width/2)) / pointDist;
    pointRad = acos(pointRadInner);
    pointAngle = degrees(pointRad);
    pointerDist = pointerAngle - pointAngle;
    if(pointerDist < pointerDistMax && pointerDist > pointerDistMin) {
      pointOpacity = map(pointerDist, pointerDistMax, pointerDistMin, 0, 100);
      colorMode(HSB);
      fill(60, map(solar, 0, 1, 50,100), 100, pointOpacity);
      ellipse(pos.x, pos.y, solarSize, solarSize);
    }
  }
}
