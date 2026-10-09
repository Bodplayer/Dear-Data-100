void setup() {
  size(1000, 500);
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

  // Catagory Codes:
  // 1.0 = Car Horn (Red)
  // 2.0 = Laughter (Yellow)
  // 3.0 = Keyboard Typing (Blue)
  // 4.0 = Overhearing Conversations (Purple)

  // Array format: {hour, minute, volume, distress, soundCategory}
  float[][] observations = {
    {8.0, 44.0, 4.0, 4.0, 1.0},
    {9.0, 21.0, 2.0, 1.0, 1.0},
    {9.0, 22.0, 2.0, 2.0, 2.0},
    {9.0, 31.0, 1.0, 1.0, 3.0},
    {10.0, 4.0, 3.0, 2.0, 4.0},
    {10.0, 7.0, 4.0, 1.0, 2.0},
    {10.0, 17.0, 2.0, 1.0, 3.0},
    {10.0, 34.0, 4.0, 4.0, 4.0},
    {13.0, 1.0, 3.0, 3.0, 4.0},
    {13.0, 8.0, 4.0, 5.0, 4.0},
    {14.0, 2.0, 2.0, 1.0, 2.0},
    {15.0, 6.0, 3.0, 2.0, 3.0},
    {15.0, 11.0, 2.0, 3.0, 4.0},
    {15.0, 17.0, 1.0, 2.0, 4.0},
    {15.0, 44.0, 4.0, 5.0, 3.0},
    {15.0, 57.0, 3.0, 2.0, 2.0},
    {17.0, 2.0, 3.0, 4.0, 4.0}
  };

  for (int i = 0; i < observations.length; i++) {
    drawObservationBar(
      observations[i][0], // hour
      observations[i][1], // minute
      observations[i][2], // volume
      observations[i][3], // distress
      observations[i][4], // soundCategory
      count
    );
    count = count + 1.0;
  }
}

void drawObservationBar(float hour, float minute, float volume, float distress, float soundCategory, float number) {

  float r = 200.0;
  float g = 200.0;
  float b = 200.0;

  if (soundCategory == 1.0) { // Car Horn - Red
    r = 230.0;
    g = 70.0;
    b = 70.0;
  }
  if (soundCategory == 2.0) { // Laughter - Yellow
    r = 240.0;
    g = 200.0;
    b = 60.0;
  }
  if (soundCategory == 3.0) { // Keyboard - Blue
    r = 80.0;
    g = 150.0;
    b = 220.0;
  }
  if (soundCategory == 4.0) { // Conversations - Purple
    r = 180.0;
    g = 100.0;
    b = 220.0;
  }

  float totalHours = (hour - 8.0) + (minute / 60.0);
  float x = 50.0 + (totalHours * 90.0);
  float barHeight = volume * 30.0;

  stroke(r, g, b);
  strokeWeight(distress * 2.0);
  line(x, 250.0, x, 250.0 - barHeight);

  fill(r, g, b);
  noStroke();
  ellipse(x, 250.0 - barHeight, 10.0, 10.0);

  fill(250);
  textSize(10);
  textAlign(CENTER, CENTER);
  text(int(number), x, 250.0 - barHeight - 12.0);
}
