
final int SIZE = 30;
final int SCALE = 20;
final int LENGTH = 5;
final int ITERATIONS = 500;

smartSnake snake;
boolean moved = false;
void settings() {
  snake = new smartSnake();
  size(SIZE*SCALE, SIZE*SCALE);
}
void setup(){
    frameRate(1000);
    noStroke();

  
}

void draw(){
    //print(frameRate);
    print("\n");
    
    
    
    
  snake.action();
  
  //snake.render();
  if (snake.train > ITERATIONS){
    snake.render();
  } else {
    fill(0);
    textSize(50);
    text("TRAINING", SIZE*SCALE /2 -125, SIZE*SCALE/2 );
  }
  textSize(13);
  fill(0);
  rect(0, 0,110, 200);
  fill(255);
  text("Score: " + str(snake.len - LENGTH), 10, 15);
  text("Iterations: " + str(snake.train), 10, 35);
  text("High Score: " + str(snake.highScore), 10, 55);
  text("up: " + str(snake.state.get("0")), 10, 75);
  text("right: " + str(snake.state.get("1")), 50, 75);
  text("down: " + str(snake.state.get("2")), 10, 95);
  text("left: " + str(snake.state.get("3")), 65, 95);
  text("x: " + str(snake.state.get("xFood")), 10, 115);
  text("y: " + str(snake.state.get("yFood")), 60, 115);
  text("direction: " +str(snake.direction), 10, 135);
  text("Reward: " +str(snake.state.get("reward")), 10, 155);
  text("iA: " + str(snake.state.get("iAdd")), 10, 175);
  text("jA: " + str(snake.state.get("jAdd")), 50, 175);

}

void keyPressed(){

    switch(keyCode){
      case UP:
        snake.turn(0);
        break;
      case RIGHT:
        snake.turn(1);
        break;
      case DOWN:
        snake.turn(2);
        break;
      case LEFT:
        snake.turn(3);
        break;
      case 82:
        square(0, 0, SIZE * SCALE);
        snake = new smartSnake();
        break;
      case 32:
        delay(1000);
        break;
    }
  
}
