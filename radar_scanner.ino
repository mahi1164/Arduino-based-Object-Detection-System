#include <Servo.h>

#define trigPin 9
#define echoPin 10
Servo myServo;

int angle;
long duration;
int distance;

void setup() {
  Serial.begin(9600);
  myServo.attach(11);  // Attach servo to pin 11
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

void loop() {
  for (angle = 0; angle <= 180; angle++) {
    myServo.write(angle);
    delay(20);
    distance = getDistance();
    sendData(angle, distance);
  }

  for (angle = 180; angle >= 0; angle--) {
    myServo.write(angle);
    delay(20);
    distance = getDistance();
    sendData(angle, distance);
  }
}

int getDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2;  // cm
  return distance;
}

void sendData(int angle, int distance) {
  Serial.print(angle);
  Serial.print(",");
  Serial.println(distance);
}
