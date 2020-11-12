

class Snake {
  
  int[] i;
  int[] j;
  int len;
  int direction;
  boolean game;
  int i_food;
  int j_food;
  
  Snake(){
    this.i = new int[100];
    this.j = new int[100];
    this.len = 10;
    this.direction = 1;
    this.i[0] = SIZE / 2;
    this.j[0] = SIZE / 2;
    this.i[1] = this.i[0] - 1;
    this.j[1] = this.j[0];
    this.game = true;
    this.i_food = int(random(SIZE));
    this.j_food = int(random(SIZE));

  }
  
  
  void turn(int direction){
    if (direction != (this.direction + 2) % 4 ){
      this.direction = direction;
    }
  }
  
  void move(){
    for (int k = this.len - 1; k > 0 && len > 1; k--){
       this.i[k] = this.i[k - 1];
       this.j[k] = this.j[k - 1];
    }
     switch(this.direction){
        case 1:
          this.i[0] = this.i[1] + 1;
        break;
        case 2:
          this.j[0] = this.j[1] + 1;
        break;
        case 3:
          this.i[0] = this.i[1] - 1;
        break;
        case 0:
          this.j[0] = this.j[1] - 1;
        break;
     }
     if (this.i[0] == SIZE){
       this.i[0] = 0;
     } else if (this.i[0] == -1) {
       this.i[0] = SIZE - 1;
     } else if (this.j[0] == SIZE ){
       this.j[0] = 0;
     } else if (this.j[0] == -1) {
       this.j[0] = SIZE - 1;
     }
     
     if (this.i[0] == this.i_food && this.j[0] == this.j_food){
       snake.eat();
     }
  }
  
  void render(){
    for (int i = 0; i < SIZE && this.game; i++){
     for (int j = 0; j < SIZE && this.game; j++){
       fill(255);
       square(i*SCALE, j* SCALE, SCALE);
     }
    }
    for (int k = 0; k < this.len; k++){
      fill(#FF0000);
      square(this.i[k] * SCALE, this.j[k]* SCALE, SCALE);
    }
    square(this.i_food*SCALE, this.j_food*SCALE, SCALE);
  }
  
  void collision(){
    for (int k = 1; k < len && this.game; k++){
      if (this.i[0] == this.i[k] && this.j[0] == this.j[k]){
        this.len = 0;
        textSize(40);
        fill(0);
        text("GAME OVER",SIZE/2 * SCALE - 50, SIZE/2 * SCALE - 5);
        this.game = false;
      }
    }
  }
  
  void eat(){
    this.len++;
    this.i_food = int(random(SIZE));
    this.j_food = int(random(SIZE));
  }
}
