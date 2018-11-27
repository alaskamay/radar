
String solarFile = "solar_nospaces.csv";


int size1 = 1;



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
  //background(255);

  pushMatrix();
  translate(width/2, height/2);
  rotate(rotate);
  pushMatrix();
  translate(-width/2, -height/2);



  //map.draw();
  //fill(0, 200);
  //rect(0, 0, width, height);
  noStroke();

  for (SolarPos solarPos : solarPositions) {

    ScreenPosition pos = map.getScreenPosition(solarPos.location);
    fill(255, 231, 147, 100);
    //fill(0);
    ellipse(pos.x, pos.y, size1, size1);
  }


  popMatrix();
  rotate += 0.01;
  popMatrix();
}