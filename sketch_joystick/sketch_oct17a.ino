/*
  LILYGO Joystick Example
  Joystick X, Y, and SW are connected to pins 39, 32, and 33
  Prints out X, Y, Z values to Serial only when joystick moves or switch is pressed
*/

int xyzPins[] = {39, 32, 33};  // x, y, z(switch) pins

// Variables to store the previous values of X, Y, and Z to detect changes
int prevX = 0;
int prevY = 0;
int prevZ = 0;

void setup() {
  Serial.begin(9600);
  pinMode(xyzPins[2], INPUT_PULLUP);  // Pull-up resistor for the switch
}

void loop() {
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);

  // Only print the values if there's a change in X, Y, or Z values
  if (xVal != prevX || yVal != prevY || zVal != prevZ) {
    Serial.printf("%d,%d,%d", xVal, yVal, zVal);
    Serial.println();
    
    // Update the previous values with the current values
    prevX = xVal;
    prevY = yVal;
    prevZ = zVal;
  }

  delay(100);  // Adjust delay as needed
}
