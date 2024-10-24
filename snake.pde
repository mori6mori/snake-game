import processing.serial.*;  // Import the serial library
PImage backgroundImage; 

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

int analogMax = 4095;  // Maximum analog value from the joystick
float sensitivity = 0.5;  // Adjust to make movement smooth

ArrayList<PVector> snake = new ArrayList<PVector>();
PVector pos;

PVector food;
PImage foodImage;  // Declare a variable for the food image
float foodSizeMultiplier = 1.6;  // Multiplier to make the food larger

PVector dir = new PVector(0, 0);  // Initial direction of movement

int size = 40;
int w, h;

int spd = 20;  // Speed of snake movement (frames)
int len = 4;   // Initial length of the snake

int lastResetTime = 0;  // Last time the reset occurred
int resetCooldown = 2000;  // Cooldown period to prevent repeated resets

boolean firstRead = true;  // Track the first joystick read

void setup() {
  size(1080, 720);
  w = width / size;
  h = height / size;

  pos = new PVector(w / 2, h / 2);
  backgroundImage = loadImage("background.jpeg");  
  food = new PVector(int(random(w)), int(random(h)));
  foodImage = loadImage("food.png");  

  noStroke();
  fill(0);

  // List all available serial ports
  printArray(Serial.list());
  // Open the correct serial port (adjust index if necessary)
  String portName = Serial.list()[1];  // Change index if necessary
  println("Connecting to: " + portName);
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  //background(200);
  image(backgroundImage, 0, 0, width, height);  
  drawSnake();
  drawFood();

  // Check if new data is available from the serial port
  if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
    val = trim(val);  // Clean up the input

    if (val != null && val.length() > 0) {
      // Split the joystick values
      int[] xyz = int(split(val, ','));
      
      // Ensure that we have exactly 3 values (X, Y, Z from the joystick)
      if (xyz.length == 3) {
        int xVal = xyz[0];  // Joystick X value
        int yVal = xyz[1];  // Joystick Y value
        int zVal = xyz[2];  // Joystick Z value (switch)
        
        // Skip the first read to prevent erroneous reset on startup
        if (firstRead) {
          firstRead = false;  // After the first read, continue as normal
          return;  // Skip this first cycle
        }
        
        // Handle joystick movement based on X and Y values
        if (xVal < 1800) {  // Move left
          dir = new PVector(-1, 0);
        } else if (xVal > 2200) {  // Move right
          dir = new PVector(1, 0);
        }
        if (yVal < 1800) {  // Move up
          dir = new PVector(0, -1);
        } else if (yVal > 2200) {  // Move down
          dir = new PVector(0, 1);
        }
        
        // Only reset if the Z button (switch) is pressed and there is enough time since the last reset
        if (zVal == 0 && millis() - lastResetTime > resetCooldown) {
          reset();
          lastResetTime = millis();  // Update last reset time to prevent frequent resets
        }
      }
    }
  }

  // Move the snake every few frames
  if (frameCount % spd == 0) {
    updateSnake();
  }
}

void drawFood() {
  //fill(255, 0, 0);  // Red food
  //rect(food.x * size, food.y * size, size, size);
  float largerFoodSize = size * foodSizeMultiplier;  // Calculate new food size
  image(foodImage, food.x * size - (largerFoodSize - size) / 2, food.y * size - (largerFoodSize - size) / 2, largerFoodSize, largerFoodSize);
}

void newFood() {
  food = new PVector(int(random(w)), int(random(h)));
}

void drawSnake() {
  fill(255);
  rect(pos.x * size, pos.y * size, size, size);
  for (int i = 0; i < snake.size(); i++) {
    rect(snake.get(i).x * size, snake.get(i).y * size, size, size);
  }
}

void updateSnake() {
  if (dir.x != 0 || dir.y != 0) {
    snake.add(new PVector(pos.x, pos.y));  // Add the current position to the snake's body
  }

  // Keep the snake's length fixed
  while (snake.size() > len) {
    snake.remove(0);
  }

  // Move snake in the current direction
  pos.add(dir);

  // Check if the snake eats the food
  if (pos.x == food.x && pos.y == food.y) {
    newFood();
    len += 1;  // Grow the snake
    spd = constrain(spd - 1, 0, 20);  // Increase speed
  }

  // Check for collision with itself (head touching any part of the body)
  for (int i = 0; i < snake.size(); i++) {
    if (pos.x == snake.get(i).x && pos.y == snake.get(i).y) {
      reset();  // Restart the game when snake touches itself
    }
  }

  // Handle boundaries (snake wraps around)
  if (pos.x < 0) { pos.x = w - 1; }
  if (pos.x >= w) { pos.x = 0; }
  if (pos.y < 0) { pos.y = h - 1; }
  if (pos.y >= h) { pos.y = 0; }
}
void reset() {
  spd = 20;  // Reset speed
  len = 5;   // Reset length
  pos = new PVector(w / 2, h / 2);  // Reset position
  dir = new PVector(0, 0);  // Stop movement
  newFood();
  snake = new ArrayList<PVector>();
}
