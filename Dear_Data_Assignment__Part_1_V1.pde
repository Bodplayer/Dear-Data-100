void setup() {
  size(1000, 500);
}

void draw() {
  background(30);
  text("8:00", 50, 270);
  textAlign(CENTER, CENTER);
  textSize(20);

  text("12:00", 500, 270);
  textAlign(CENTER, CENTER);
  textSize(20);

  text("18:00", 950, 270);
  textAlign(CENTER, CENTER);
  textSize(20);

  stroke(100);
  strokeWeight(3);
  line(50, 250, 950, 250);
}
