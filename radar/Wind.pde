String windFile = "wind_nospaces.csv";
int windSize = 10;
ArrayList<WindPos> windPositions = new ArrayList();

void loadWind() {
  background(0);
  // Create interactive map centered around Switzerland
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(new Location(46.986991, 8.178334), 8);
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
  float pointDist;
  float pointRad;
  float pointAngle;
  float pointerDist;
  float pointOpacity;
  float pointRadInner;
  float pointerDistMin = 0;
  float pointerDistMax = 150;
  float circleSizeWind;
  noStroke();

  for (WindPos windPos : windPositions) {
    ScreenPosition pos = map.getScreenPosition(windPos.location);
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
      fill(255, 0, 255, pointOpacity);
      ellipse(pos.x, pos.y, windSize, windSize);
      if(wind > 0 && pointerDist > 0) {
        noFill();
        stroke(255, 0, 255, pointOpacity);
        strokeWeight(3);
        circleSizeWind = map(pointerDist, 0, 150, 60, 0);
        ellipse(pos.x, pos.y, circleSizeWind, circleSizeWind);
      }
    }
  }
}