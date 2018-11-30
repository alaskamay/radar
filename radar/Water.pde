String waterFile = "water_nospaces.csv";
int waterSize = 6;
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
  float pointerDistMin = 0;
  float pointerDistMax = 120;
  float circleSizeWater;
  noStroke();

  for (WaterPos waterPos : waterPositions) {
    ScreenPosition pos = map.getScreenPosition(waterPos.location);
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
      fill(0, 255, 255, pointOpacity);
      ellipse(pos.x, pos.y, waterSize, waterSize);
      if(water > 0 && pointDist > 0) {
        noFill();
        stroke(0, 255, 255, pointOpacity);
        strokeWeight(1);
        circleSizeWater = map(pointerDist, 0, 150, 50, 0);
        ellipse(pos.x, pos.y, circleSizeWater, circleSizeWater);
      }
    }
  }
}