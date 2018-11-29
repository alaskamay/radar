String waterFile = "water_nospaces.csv";
int waterSize = 4;
ArrayList<WaterPos> waterPositions = new ArrayList();

void loadWater() {
  background(0);
  // Create interactive map centered around Switzerland
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(new Location(46.986991, 8.178334), 8);
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);

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
  int pointerDistMax = 60;
  background(0);
  noStroke();

  for (WaterPos waterPos : waterPositions) {
    ScreenPosition pos = map.getScreenPosition(waterPos.location);
    pointDist = dist(width/2, height/2, pos.x, pos.y);
    pointRadInner = (pos.x - (width/2)) / pointDist;
    println("RadInner:" + pointRadInner);
    pointRad = acos(pointRadInner);
    println("Rad:" + pointRad);
    pointAngle = degrees(pointRad);
    println("Angle:" + pointAngle);
    pointerDist = pointerAngle - pointAngle;
    if(pointerDist < pointerDistMax && pointerDist > pointerDistMin) {
      pointOpacity = map(pointerDist, pointerDistMax, pointerDistMin, 0, 100);
      fill(147, 203, 255, pointOpacity);
      ellipse(pos.x, pos.y, waterSize, waterSize);
    }
  }
}
