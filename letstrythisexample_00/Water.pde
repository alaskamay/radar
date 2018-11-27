
String waterFile = "water_nospaces.csv";


int size3 = 1;





ArrayList<WindPos> waterPositions = new ArrayList();


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

  for (WindPos waterPos : waterPositions) {

    ScreenPosition pos = map.getScreenPosition(waterPos.location);
    fill(255, 231, 147, 100);
    //fill(0);
    ellipse(pos.x, pos.y, size3, size3);
  }


  popMatrix();
  rotate += 0.01;
  popMatrix();
}