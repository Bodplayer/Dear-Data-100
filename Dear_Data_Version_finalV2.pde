Table soundTable;
int displayLimit = 5;
float fadeMode = 0.0;
float currentAlpha = 255.0;

void setup() {
  size(1100, 750);
  soundTable = loadTable("sound_dataa.csv", "header");
}

void draw() {
  background(8, 10, 18);

  fill(60, 70, 100);
  noStroke();
  for (int i = 0; i < 60; i++) {
    float starX = (i * 137.5) % width;
    float starY = (i * 93.3) % height;
    ellipse(starX, starY, (i % 3) + 1, (i % 3) + 1);
  }

  fill(160, 180, 220);
  textAlign(CENTER, CENTER);
  textSize(12);
  text("08:00", 120, 35);
  text("12:00", 480, 35);
  text("18:00", 1020, 35);

  stroke(30, 40, 70, 150);
  strokeWeight(1);
  for (float xPos = 120; xPos <= 1020; xPos += 90) {
    line(xPos, 50, xPos, 700);
  }

  float targetAlpha = 255.0;
  if (fadeMode == 1.0) {
    targetAlpha = 30.0;
  }
  
  currentAlpha = currentAlpha + (targetAlpha - currentAlpha) * 0.1;

  float count = 1.0;

  int maxRows = displayLimit;
  if (maxRows > soundTable.getRowCount()) {
    maxRows = soundTable.getRowCount();
  }

  for (int i = 0; i < maxRows; i++) {
    TableRow row = soundTable.getRow(i);
    
    float day = row.getFloat("day");
    float hour = row.getFloat("hour");
    float minute = row.getFloat("minute");
    float volume = row.getFloat("volume");
    float distress = row.getFloat("distress");
    float category = row.getFloat("category");
    
    float alpha = 255.0;
    if (i < displayLimit - 5) {
      alpha = currentAlpha;
    }
      
    drawPlanetRow(day, hour, minute, volume, distress, category, count, alpha);
    count = count + 1.0;
  }

  fill(140, 160, 200);
  textSize(11);
  text("Click or SPACE to launch | Press 'f' to toggle fade (" + maxRows + " / " + soundTable.getRowCount() + " sectors)", 550, 725);
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

void drawPlanetRow(float day, float hour, float minute, float volume, float distress, float soundCategory, float number, float alpha) {
  float r = 200.0;
  float g = 200.0;
  float b = 200.0;

  if (soundCategory == 1.0) {
    r = 255.0; g = 90.0; b = 70.0;
  }
  if (soundCategory == 2.0) {
    r = 255.0; g = 220.0; b = 80.0;
  }
  if (soundCategory == 3.0) {
    r = 100.0; g = 190.0; b = 255.0;
  }
  if (soundCategory == 4.0) {
    r = 210.0; g = 120.0; b = 255.0;
  }

  float totalHours = (hour - 8.0) + (minute / 60.0);
  float x = 120.0 + (totalHours * 90.0);
  float y = 70.0 + ((day - 1.0) * 40.0);

  fill(180, 200, 230, alpha);
  textSize(11);
  textAlign(RIGHT, CENTER);
  text("Day " + int(day), 80, y);

  stroke(45, 60, 100, alpha * 0.6);
  strokeWeight(1);
  line(110, y, 1030, y);

  float planetSize = volume * 4.0 + 5.0;

  fill(r, g, b, alpha * 0.2);
  noStroke();
  ellipse(x, y, planetSize + 14, planetSize + 14);

  fill(r, g, b, alpha);
  stroke(255, alpha * 0.9);
  strokeWeight(distress * 0.6);
  ellipse(x, y, planetSize, planetSize);

  fill(255, alpha * 0.4);
  noStroke();
  ellipse(x - 2, y - 2, planetSize * 0.3, planetSize * 0.3);

  fill(220, 230, 255, alpha);
  textSize(8);
  textAlign(CENTER, CENTER);
  text(int(number), x, y - planetSize - 8);
}
