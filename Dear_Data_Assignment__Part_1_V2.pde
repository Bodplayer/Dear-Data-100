

void setup() {
  size(1000, 500);
}

void draw() {
  background(30);

  fill(200);
  text("8:00", 50, 270);
  textAlign(CENTER, CENTER);
  text("8:00", 50, 270);
  text("12:00", 500, 270);
  text("18:00", 950, 270);

  stroke(100);
  strokeWeight(3);
  line(50, 250, 950, 250);
  float count = 1.0;
  // 1
  drawObservationBar(8.0, 44.0, 4.0, 4.0, 230.0, 70.0, 70.0, count);
  count = count + 1.0;
  // 2
  drawObservationBar(9.0, 21.0, 2.0, 1.0, 230.0, 70.0, 70.0, count);
  count = count + 1.0;
  // 3
  drawObservationBar(9.0, 22.0, 2.0, 2.0, 240.0, 200.0, 60.0, count);
  count = count + 1.0;
  // 4
  drawObservationBar(9.0, 31.0, 1.0, 1.0, 80.0, 150.0, 220.0, count);
  count = count + 1.0;
  // 5
  drawObservationBar(10.0, 4.0, 3.0, 2.0, 180.0, 100.0, 220.0, count);
  count = count + 1.0;
  // 6
  drawObservationBar(10.0, 7.0, 4.0, 1.0, 240.0, 200.0, 60.0, count);
  count = count + 1.0;
  // 7
  drawObservationBar(10.0, 17.0, 2.0, 1.0, 80.0, 150.0, 220.0, count);
  count = count + 1.0;
  // 8
  drawObservationBar(10.0, 34.0, 4.0, 4.0, 180.0, 100.0, 220.0, count);
  count = count + 1.0;
}

void drawObservationBar(float hour, float minute, float volume, float distress, float r, float g, float b, float number) {

  float totalHours = (hour - 8) + (minute / 60.0);
  float x = 50 + (totalHours * 90);
  float barHeight = volume * 30;
  stroke(r, g, b);
  strokeWeight(distress * 2);
  line(x, 250, x, 250-barHeight);

  fill(r, g, b);
  noStroke();
  ellipse(x, 250 - barHeight, 7, 7);

  fill(250);
  textSize(10);
  textAlign(CENTER, CENTER);
  text(int(number), x, 250 - barHeight - 12);
}
