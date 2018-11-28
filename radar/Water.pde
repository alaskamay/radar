String waterFile = "water_nospaces.csv";
int waterSize = 4;
ArrayList<WaterPos> waterPositions = new ArrayList();
float pointDist;
float pointRad;
float pointAngle;

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
  background(0);
  noStroke();

  for (WaterPos waterPos : waterPositions) {
    ScreenPosition pos = map.getScreenPosition(waterPos.location);
    pointDist = dist(0, 0, pos.x, pos.y);
    pointRad = acos((pos.x - (width / 2)) / pointDist);
    pointAngle = degrees(pointRad);
    println(pointAngle);
    if((pointAngle - angle) < 3 && (pointAngle - angle) > 0) {
      fill(147, 203, 255, 100);
      ellipse(pos.x, pos.y, waterSize, waterSize);
    }
  }
}
