import processing.serial.*;

Serial port;
String data;
int angle, distance;

void setup() {
  size(800, 600);
  port = new Serial(this, Serial.list()[0], 9600);
  port.bufferUntil('\n');
  background(0);
}

void draw() {
  fill(0, 10);
  rect(0, 0, width, height);  // fading background
  drawRadar();
  drawLine(angle, distance);
}

void serialEvent(Serial p) {
  data = p.readStringUntil('\n');
  if (data != null) {
    data = trim(data);
    String[] values = split(data, ',');
    if (values.length == 2) {
      angle = int(values[0]);
      distance = int(values[1]);
    }
  }
}

void drawRadar() {
  stroke(0, 255, 0);
  noFill();
  ellipse(width/2, height, 400, 400);
  ellipse(width/2, height, 300, 300);
  ellipse(width/2, height, 200, 200);
  ellipse(width/2, height, 100, 100);
  line(width/2, height, width/2 + 200*cos(radians(angle)), height - 200*sin(radians(angle)));
}

void drawLine(int a, int d) {
  float x = width/2 + d * cos(radians(a));
  float y = height - d * sin(radians(a));
  stroke(255, 0, 0);
  line(width/2, height, x, y);
}
