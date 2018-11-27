String windFile = "wind_nospaces.csv";


int windSize = 3;





ArrayList<WindPos> windPositions = new ArrayList();


void loadWind() {
  background(0);
  // Create interactive map centered around Switzerland
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(7, new Location(46.986991, 8.178334));
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);

  // Load CSV Wind data
  Table windDataCSV = loadTable(windFile, "header, csv");
  for (TableRow windPosRow : windDataCSV.rows()) {

    WindPos windPos = new WindPos();

    float lat = windPosRow.getFloat("Latitude");
    float lng = windPosRow.getFloat("Longitude");
    windPos.location = new Location(lat, lng);

    windPositions.add(windPos);
  }

}


void vizWind() {
  //background(255);

  pushMatrix();
  translate(width/2, height/2);
  //rotate(rotate);
  pushMatrix();
  translate(-width/2, -height/2);



  //map.draw();
  //fill(0, 200);
  //rect(0, 0, width, height);
  noStroke();

  for (WindPos windPos : windPositions) {

    ScreenPosition pos = map.getScreenPosition(windPos.location);
    fill(147, 255, 199, 100);
    //fill(0);
    ellipse(pos.x, pos.y, windSize, windSize);
  }


  /*
  popMatrix();
  rotate += 0.01;
  popMatrix();
  */
}
