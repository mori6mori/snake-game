# Snake Game
## About

A reimagined, single-player version of the classic Snake game, this project challenges players to eat as many cupcakes as possible within a 90-second timer. This game introduces an interactive twist with joystick-controlled movement and speed adjustment via a potentiometer. For more information, read the [full blog post](https://mori-liu.notion.site/Module-2-Project-Proposal-Timed-Snake-Game-with-Adjustable-Speed-and-Joystick-Controls-11b2195ca68280c8ab12e34fcc35210f?pvs=74).

![ezgif-4-c1acbef9d9](https://github.com/user-attachments/assets/6dae66ae-c897-49ff-add9-d5a024141ef8)

Tags: #InteractiveGame #Joystick #Potentiometer #EmbeddedSystem

## Design Goals

The game enhances player engagement through dynamic and physical controls:

<img src="https://github.com/user-attachments/assets/927429f6-fe73-439d-970e-555c57554e49" alt="IMG_5532" width="300" height="300">

* Joystick-Controlled Movement: The joystick provides intuitive, interactive movement control for the snake.
* Adjustable Speed: The potentiometer lets players dynamically adjust speed, balancing faster movements with increased control difficulty.
* Cupcake Counter: Updates in real-time as the snake eats cupcakes, giving immediate player feedback.
* Borderless Movement: The snake can move across the screen’s edges without penalty, reappearing on the opposite side.
* Game Over Screen: After 90 seconds, the game displays a “Game Over” screen showing the total cupcakes eaten, with a restart button to replay.

## Project Structure

```
├── data/                    # Stores any necessary assets like images, sounds, or data files for Processing
├── enclosure/               # Contains files related to the physical enclosure (if applicable)
├── ardurino_sketch/         # Arduino code to integrate joystick and button controls
│   ├── sketch.ino  # Main Arduino code for joystick and button control
├── snake.pde                # Processing code for the main game logic and visuals
```

## Installation Steps
<img width="589" alt="Screenshot 2024-11-07 at 1 13 53 PM" src="https://github.com/user-attachments/assets/f3f9b17e-255e-4b62-9887-8565e08be26a">

1. Setup Hardware Components:
 * Joystick: Connect the joystick to control the snake’s direction.
 * Potentiometer: Attach the potentiometer to adjust the game speed dynamically.
 * Button: Connect a button to allow for restarting the game on press.
2. Upload Code to Arduino:
   * Open the sketch_joystick_button.ino file in the Arduino IDE and upload it to your Arduino board. This code enables joystick and button control for direction and game reset, and potentiometer control for speed adjustment.
3. Run Processing Code:
* Open snake.pde in Processing.
* Run the file to start the game interface.
* The game should respond to joystick inputs for movement, potentiometer adjustments for speed, and button presses for restarting.
  
<img src="https://github.com/user-attachments/assets/c8715425-032c-4b1a-9933-c49e30bb7b05" alt="IMG_4943" width="400"/>

## Usage Instructions

1. Start the Game:
* Launch snake.pde in Processing. This will open the game screen.
* Move the snake using the joystick and adjust the speed with the potentiometer.
2. Game Mechanics:
* You have 90 seconds to eat as many cupcakes as possible. The screen shows a countdown timer and cupcake counter for real-time feedback.
* The snake can move across borders, reappearing on the opposite side without penalty.
3. Restart the Game:
* When the game ends, press the button to reset the timer, cupcake counter, and snake position.
4. Game Over Screen:
* Once time is up, a “Game Over” screen will display, showing the total cupcakes eaten. Press the button to restart and play again.
<img width="300" alt="Screenshot 2024-11-01 at 9 18 20 PM" src="https://github.com/user-attachments/assets/71edd8ce-f050-468e-a01c-aa382e96f2e3">

## Testing and Debugging

1.Joystick Movement: Test various directions to ensure the joystick accurately controls the snake’s movement.

2.Speed Adjustment: Adjust the potentiometer to check that the snake’s speed changes smoothly.

3.Restart Button: Test the button to confirm it successfully restarts the game after the timer expires or upon a manual reset.

