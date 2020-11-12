

class Snake {
  
  
  int[][] coords;
  int len;
  int direction;
  boolean game;
  int i_food;
  int j_food;
  //up down left right from snake head
  int[][] adjacent;
  int[][] nextAdjacent;
  int train;
  int highScore;
    int[] last;

  
  Snake(){
    this.coords = new int[30][2];
    this.len = LENGTH;
    this.direction = 1;
    this.coords[0][0] = int(random(1, SIZE - 1));
    this.coords[0][1] = int(random(1, SIZE - 1));
    this.coords[1][0] = this.coords[0][0] - 1;
    this.coords[1][1] = this.coords[0][1];
    this.game = true;
    this.i_food = int(random(SIZE));
    this.j_food = int(random(SIZE));
    this.adjacent = new int[4][2];
    for (int i = 0; i < 4; i++){
      int iAdd = 0; int jAdd = 0;

      switch(i){
        case 0: jAdd = -1; break;
        case 1: iAdd = 1;  break;
        case 2: jAdd = 1;  break;
        case 3: iAdd = -1; break;
     }
      this.adjacent[i][0] = this.coords[0][0] + iAdd;
      this.adjacent[i][1] = this.coords[0][1] + jAdd;

    }
    this.nextAdjacent = new int[4][2];
    this.train = 0;
    this.last = new int[4];

  }
  
  
  void turn(int direction){
    if (direction != (this.direction + 2) % 4 ){
      for (int i = 2; i > 0; i--){
        this.last[i] = this.last[i-1];
      }
      this.last[0] = this.direction;
      this.direction = direction;
    }
  }
  
  void move(){
    int iAdd = 0;
    int jAdd = 0;

    for (int k = this.len - 1; k > 0; k--){
       //this.coords[k] = this.coords[k - 1];
       this.coords[k][0] = this.coords[k-1][0];
       this.coords[k][1] = this.coords[k-1][1];

    }

     switch(this.direction){
        case 0:
          this.coords[0][1] = this.coords[1][1] - 1;
          jAdd = -1;
        break;
        case 1:
          this.coords[0][0] = this.coords[1][0] + 1;
          iAdd = 1;
        break;
        case 2:
          this.coords[0][1] = this.coords[1][1] + 1;
          jAdd = 1;
        break;
        case 3:
          this.coords[0][0] = this.coords[0][0] - 1;
          iAdd = -1;
        break;

     }

     //if (this.coords[0][0] == this.i_food && this.coords[0][1] == this.j_food){
     //  snake.eat();
     //}
     for (int i = 0; i < 4; i++){
       this.adjacent[i][0] += iAdd;
       this.adjacent[i][1] += jAdd;
     }
     
  }
  
  void render(){
    for (int i = 0; i < SIZE && this.game; i++){
     for (int j = 0; j < SIZE && this.game; j++){
       fill(255);
       noStroke();
       square(i*SCALE, j* SCALE, SCALE);
     }
    }
    for (int k = 0; k < this.len && this.game; k++)  {
      fill(#FF0000);
      stroke(0);
      square(this.coords[k][0] * SCALE, this.coords[k][1]* SCALE, SCALE);
    }
    
    fill(0,255,0);
    square(this.i_food*SCALE, this.j_food*SCALE, SCALE);
  }
  
  void collision(){
    for (int k = 1; k < len && this.game; k++){
      if (this.coords[0][0] == this.coords[k][0] && this.coords[0][1] == this.coords[k][1]){
        this.game = false;
      }
    }
    if (contains(SIZE ,this.coords[0]) || contains( -1 ,this.coords[0]) ){
      this.game = false;
    }
    
  }
  
  void eat(){
    this.coords[this.len][0] = this.coords[this.len - 1][0];
    this.coords[this.len][1] = this.coords[this.len - 1][1];
    this.len++;
    this.i_food = int(random(1, SIZE - 1));
    this.j_food = int(random(1, SIZE - 1));
    if (this.len - LENGTH > this.highScore){
      this.highScore = this.len - LENGTH;
    }
  }
}
