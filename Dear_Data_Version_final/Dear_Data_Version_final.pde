Table soundTable;
int displayLimit = 5;
float fadeMode = 0.0;

void setup() {
  size(1000, 500);
  soundTable = loadTable("sound_dataa.csv", "header");
}

void draw() {
  background(12, 15, 22);

  fill(120, 130, 150);
  textAlign(CENTER, CENTER);
  textSize(12);
  text("08:00", 50, 280);
  text("12:00", 410, 280);
  text("18:00", 950, 280);

  stroke(40, 50, 70);
  strokeWeight(1);
  for (float h = 50; h <= 950; h += 45) {
    line(h, 245, h, 255);
  }

  stroke(60, 75, 100);
  strokeWeight(2);
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
        alpha = 35.0;
      }
    }
      
    drawObservationBar(hour, minute, volume, distress, category, count, alpha);
    count = count + 1.0;
  }

  fill(100, 115, 140);
  textSize(11);
  text("Click or SPACE to reveal batch | Press 'f' to toggle fade (" + maxRows + " / " + soundTable.getRowCount() + " observations)", 500, 460);
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
    r = 255.0; g = 80.0; b = 80.0;
  }
  if (soundCategory == 2.0) {
    r = 255.0; g = 210.0; b = 70.0;
  }
  if (soundCategory == 3.0) {
    r = 90.0; g = 170.0; b = 255.0;
  }
  if (soundCategory == 4.0) {
    r = 200.0; g = 110.0; b = 255.0;
  }

  float totalHours = (hour - 8.0) + (minute / 60.0);
  float x = 50.0 + (totalHours * 90.0);
  float barHeight = volume * 30.0;

  stroke(r, g, b, alpha * 0.25);
  strokeWeight(distress * 3.5 + 4);
  line(x, 250.0, x, 250.0 - barHeight);

  stroke(r, g, b, alpha);
  strokeWeight(distress * 2.0);
  line(x, 250.0, x, 250.0 - barHeight);

  fill(r, g, b, alpha * 0.3);
  noStroke();
  ellipse(x, 250.0 - barHeight, 14, 14);

  fill(r, g, b, alpha);
  ellipse(x, 250.0 - barHeight, 7, 7);

  fill(240, alpha);
  textSize(9);
  textAlign(CENTER, CENTER);
  text(int(number), x, 250.0 - barHeight - 14.0);
}
