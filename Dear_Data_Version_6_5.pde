Table soundTable;
int displayLimit = 5;
float fadeMode = 0.0;

void setup() {
  size(1000, 500);
  soundTable = loadTable("sound_data1.csv", "header");
}

void draw() {
  background(30);

  fill(200);
  textAlign(CENTER, CENTER);
  textSize(14);
  text("8:00", 50, 270);
  text("12:00", 410, 270);
  text("18:00", 950, 270);

  stroke(100);
  strokeWeight(3);
  line(50, 250, 950, 250);

  float count = 1.0;

  int maxRows = displayLimit;
  if (maxRows > soundTable.getRowCount()) {
    maxRows = soundTable.getRowCount();
  }

  for (int i = 0; i < maxRows; i++) {
    TableRow row = soundTable.getRow(i);
    
    float hour = row.getFloat("hour");
    float minute = row.getFloat("minute");
    float volume = row.getFloat("volume");
    float distress = row.getFloat("distress");
    float category = row.getFloat("category");
    
    float alpha = 255.0;
    if (fadeMode == 1.0) {
      if (i < displayLimit - 5) {
        alpha = 60.0;
      }
    }
      
    drawObservationBar(hour, minute, volume, distress, category, count, alpha);
    count = count + 1.0;
  }

  fill(150);
  textSize(12);
  text("Click or SPACE to show more | Press 'f' to toggle fade (" + maxRows + " / " + soundTable.getRowCount() + ")", 500, 450);
}

void keyPressed() {
  if (key == ' ') {
    handleClicks();
  }
  if (key == 'f' || key == 'F') {
    if (fadeMode == 0.0) {
      fadeMode = 1.0;
    } else {
      fadeMode = 0.0;
    }
  }
}

void mousePressed() {
  handleClicks();
}

// Helper method to handle the step-by-step increase and clean reset
void handleClicks() {
  if (displayLimit >= soundTable.getRowCount()) {
    displayLimit = 5;
  } else {
    displayLimit = displayLimit + 5;
    if (displayLimit > soundTable.getRowCount()) {
      displayLimit = soundTable.getRowCount();
    }
  }
}

void drawObservationBar(float hour, float minute, float volume, float distress, float soundCategory, float number, float alpha) {
  float r = 200.0;
  float g = 200.0;
  float b = 200.0;

  if (soundCategory == 1.0) {
    r = 230.0; g = 70.0; b = 70.0;
  }
  if (soundCategory == 2.0) {
    r = 240.0; g = 200.0; b = 60.0;
  }
  if (soundCategory == 3.0) {
    r = 80.0; g = 150.0; b = 220.0;
  }
  if (soundCategory == 4.0) {
    r = 180.0; g = 100.0; b = 220.0;
  }

  float totalHours = (hour - 8.0) + (minute / 60.0);
  float x = 50.0 + (totalHours * 90.0);
  float barHeight = volume * 30.0;

  stroke(r, g, b, alpha);
  strokeWeight(distress * 2.0);
  line(x, 250.0, x, 250.0 - barHeight);

  fill(r, g, b, alpha);
  noStroke();
  ellipse(x, 250.0 - barHeight, 7.0, 7.0);

  fill(250, alpha);
  textSize(10);
  textAlign(CENTER, CENTER);
  text(int(number), x, 250.0 - barHeight - 12.0);
}
