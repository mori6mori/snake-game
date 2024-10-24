/*
  Combined Joystick and Button Example
  - Joystick X, Y, and SW are connected to pins 39, 32, and 33.
  - Pushbutton is connected to pin 2 (with internal pullup resistor).
  - LED is connected to pin 15 with a 220Ω resistor.
  - Prints out X, Y, Z values to Serial when joystick moves or switch is pressed.
  - Turns on LED when the button is pressed.
*/

// Joystick pins
int xyzPins[] = {39, 32, 33};  // X, Y, Z(switch) pins

// LED and button pins
#define BUTTON_PIN 2
#define LED_PIN 15

// Variables to store the previous values of X, Y, and Z to detect changes
int prevX = 0;
int prevY = 0;
int prevZ = 0;

void setup() {
  Serial.begin(9600);

  // Setup Joystick
  pinMode(xyzPins[2], INPUT_PULLUP);  // Pull-up resistor for the joystick switch
  
  // Setup Button and LED
  pinMode(BUTTON_PIN, INPUT_PULLUP);  // Button with internal pullup
  pinMode(LED_PIN, OUTPUT);           // LED pin as output
}

void loop() {
  // Read Joystick values
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);

  // Read Button state
  int buttonState = digitalRead(BUTTON_PIN);

  // Only print the joystick values if there's a change in X, Y, or Z values
  if (xVal != prevX || yVal != prevY || zVal != prevZ) {
    Serial.printf("Joystick: X=%d, Y=%d, Z=%d\n", xVal, yVal, zVal);
    
    // Update the previous values with the current values
    prevX = xVal;
    prevY = yVal;
    prevZ = zVal;
  }

  // Control LED with the button
  if (!buttonState) {  // Button is pressed (LOW state)
    digitalWrite(LED_PIN, HIGH);  // Turn on LED
    Serial.println("Button pressed, LED ON");
  } else {
    digitalWrite(LED_PIN, LOW);  // Turn off LED
  }

  delay(100);  // Adjust delay as needed
}