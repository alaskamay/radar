String waterFile = "water_nospaces.csv";
int waterSize = 4;
ArrayList<WaterPos> waterPositions = new ArrayList();

void loadWater() {
  background(0);
  // Create interactive map centered around Switzerland
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(7, new Location(46.986991, 8.178334));
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
    fill(147, 203, 255, 100);
    ellipse(pos.x, pos.y, waterSize, waterSize);
  }
}
