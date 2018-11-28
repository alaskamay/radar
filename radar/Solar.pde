String solarFile = "solar_nospaces.csv";
int solarSize = 1;
ArrayList<SolarPos> solarPositions = new ArrayList();

void loadSolar() {
  background(0);
  // Create interactive map centered around Switzerland
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(7, new Location(46.986991, 8.178334));
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
  noStroke();

  for (SolarPos solarPos : solarPositions) {
    ScreenPosition pos = map.getScreenPosition(solarPos.location);
    fill(255, 231, 147, 100);
    ellipse(pos.x, pos.y, solarSize, solarSize);
  }
}
