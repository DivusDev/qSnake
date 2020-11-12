
final int SIZE = 30;
final int SCALE = 20;
Snake snake;

void settings() {
  snake = new Snake();
  size(SIZE*SCALE, SIZE*SCALE);
}
void setup(){
    frameRate(7);
    noStroke();

  
}

void draw(){
  snake.move();
  snake.collision();
  snake.render();
  
  
  
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
  }
  
  
}
