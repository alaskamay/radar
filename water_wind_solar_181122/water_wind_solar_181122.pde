import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;

String waterFile = "water_nospaces.csv";
String solarFile = "solar_nospaces.csv";
String windFile = "wind_nospaces.csv";


int size = 4;
int sizeW = 10;
float rotate = 0.1;

UnfoldingMap map;

ArrayList<WaterPos> waterPositions = new ArrayList();
ArrayList<SolarPos> solarPositions = new ArrayList();
ArrayList<WindPos> windPositions = new ArrayList();

void setup() {
  size(800, 600, P2D);
  smooth();

  background(100);

  // Create interactive map centered around Switzerland
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(7, new Location(46.986991, 8.178334));
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);

  // Load CSV Water data
  Table waterDataCSV = loadTable(waterFile, "header, csv");
  for (TableRow waterPosRow : waterDataCSV.rows()) {
    // Create new empty object to store data
    WaterPos waterPos = new WaterPos();

    float lat = waterPosRow.getFloat("Latitude");
    float lng = waterPosRow.getFloat("Longitude");
    waterPos.location = new Location(lat, lng);

    // Add to list of all water positions
    waterPositions.add(waterPos);
  }

  // Load CSV Solar data
  Table solarDataCSV = loadTable(solarFile, "header, csv");
  for (TableRow solarPosRow : solarDataCSV.rows()) {

    SolarPos solarPos = new SolarPos();

    float lat = solarPosRow.getFloat("Latitude");
    float lng = solarPosRow.getFloat("Longitude");
    solarPos.location = new Location(lat, lng);

    solarPositions.add(solarPos);
  }

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



void draw() {
  pushMatrix();
  translate(width/2, height/2);
  //rotate(rotate);
  pushMatrix();
  translate(-width/2, -height/2);



  map.draw();
  fill(0, 100);
  rect(0, 0, width, height);
  noStroke();

  // Iterate over all water positions
  for (WaterPos waterPos : waterPositions) {
    // Convert geo locations to screen positions
    ScreenPosition pos = map.getScreenPosition(waterPos.location);
    fill(147, 203, 255, 100);
    //fill(180);
    ellipse(pos.x, pos.y, size, size);
  }

  for (SolarPos solarPos : solarPositions) {

    ScreenPosition pos = map.getScreenPosition(solarPos.location);
    fill(255, 231, 147, 100);
    //fill(0);
    ellipse(pos.x, pos.y, size, size);
  }

  for (WindPos windPos : windPositions) {

    ScreenPosition pos = map.getScreenPosition(windPos.location);
    fill(147, 255, 199, 200);
    //fill(255);
    ellipse(pos.x, pos.y, sizeW, sizeW);
  }

  popMatrix();
  //rotate += 0.01;
  popMatrix();
}