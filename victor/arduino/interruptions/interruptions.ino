int pinBtn = 2;
int pinLed = 8; 
volatile int state = LOW; 
int delayTime = 5000;

void setup() {
  pinMode(pinBtn, INPUT);
  pinMode(pinLed, OUTPUT);

  attachInterrupt(0, click, CHANGE);
  Serial.begin(9600);
}

void loop() {
  digitalWrite(pinLed, state);
  Serial.println(digitalRead(pinBtn));
  delay(delayTime);
}

void click() {
  state = !state;
  Serial.println("changed");
  delayTime = 10;
}
