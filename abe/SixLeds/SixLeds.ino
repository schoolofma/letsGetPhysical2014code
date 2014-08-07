int sensorPin = A5; 
int sensorValue = 0;

int brightValue = 0;
int darkValue = 0;

long which;

// These outputs can be PMW controlled
int outputs[6] = { 3, 5, 6, 9, 10, 11 };

// Circular array
// This allows us to remember the last 6 values
int pastValueID = 0;
int pastValues[6] = { 0, 0, 0, 0, 0, 0 };

void setup() {
  for(int i=0; i<6; i++) {
    pinMode(outputs[i], OUTPUT);     
  }
  // Two seconds sequence to warn the user about
  // callibration phase
  while(millis() < 2000) {
    int which = outputs[map(millis(), 0, 2000, 0, 6)];
    analogWrite(which, 255);
    delay(20);
  }
  // Grab maximum brightness now
  brightValue = analogRead(sensorPin);

  // Two seconds sequence to warn the user about
  // callibration phase
  while(millis() < 4000) {
    int which = outputs[map(millis(), 2000, 4000, 0, 6)];
    analogWrite(which, 0);
    delay(20);
  }
  // Grab minimum brightness (cover the light sensor)
  darkValue = analogRead(sensorPin);
}

void loop() {
  sensorValue = analogRead(sensorPin);

  int mapped = map(sensorValue, brightValue, darkValue, 0, 255);
    
  pastValues[pastValueID] = constrain(mapped, 0, 255);
  
  for(int i=0; i<6; i++) {
    analogWrite(outputs[i], pastValues[(pastValueID - i + 6) % 6]);
  }
  
  pastValueID = (pastValueID + 1) % 6;

  delay(50);
}
