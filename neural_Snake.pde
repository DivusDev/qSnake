



class smartSnake extends Snake{
  
  
  //Qlearn table 
  //state consists of apple direction left/none/right,  up/none/down, seeing 1 block up, right, down, left, 0-3 direction of snake
  
  //last 4 is action so up right own left
  
  double[][][][][][][][] Qlearn;
  //how often the action is random
  float epsilon;
  
  float learningRate;
  //reward decay
  float gamma;
  
  HashMap<String, Integer> state;
  
  smartSnake(){
    this.Qlearn = new double[3][3][2][2][2][2][4][4];
    //will be random 10% of the time
    this.epsilon = 0.9;
    this.learningRate = 0.9;
    this.state = new HashMap<String, Integer>();
    this.gamma = 0.9;
  }
  
  
  void action(){
    this.setState();
    //set access variables for accessing state
     int xFood = this.state.get("xFood");
     int yFood = this.state.get("yFood");
     int up = this.state.get("0");
     int right = this.state.get("1");
     int down = this.state.get("2");
     int left = this.state.get("3");
     //accesss state and put action array in new array
     // this.Qlearn[xFood][yFood][up][right][down][left][this.direction];
     int action;
     if (this.train < ITERATIONS){
  
       float rand = random(0,1);
       // 90% chance if epsilon is .9
       if (rand > this.epsilon) {
         //do something random 1 - epsilon % of the time
        action = int(random(0,4));
       } else {
         //epsilon% chance to not explore randomly
        action = Calc.findMaxIndex(this.Qlearn[xFood + 1][yFood + 1][up][right][down][left][this.direction]);
       }
  
         //create next state in state variable;
         //----------------------------------------------------------------change
         if (action != (this.direction + 2) % 4 ){
           getNextState(action);
         }
         else {
           action = ((action + 1) % 4);
         }

         //retreive next state
         int xFoodNext = this.state.get("xFoodNext");
         int yFoodNext = this.state.get("yFoodNext");
         int upNext = this.state.get("0Next");
         int rightNext = this.state.get("1Next");
         int downNext = this.state.get("2Next");
         int leftNext = this.state.get("3Next");
         //set values for oldQ and new Q
         double oldQ = this.Qlearn[xFood + 1][yFood + 1][up][right][down][left][this.direction][action];
         double nextQ = Calc.findMaxIndex(this.Qlearn[xFoodNext + 1][yFoodNext + 1][upNext][rightNext][downNext][leftNext][action]);
         int reward = this.getReward();
         this.collision();
  
         if (!this.game){
           reward = -100;
         }

         this.state.put("reward", reward);
         //use bell equation
         double newQ_Val = (1 - this.learningRate) * oldQ + this.learningRate * (reward + this.gamma * nextQ);
         
         //set qTableVal
         this.Qlearn[xFood + 1][yFood + 1][up][right][down][left][this.direction][action] = newQ_Val;
         snake.turn(action);
         
         this.move();
         
         if (!this.game){
           this.reset();
         }
         
       
       
     } else {
       action = Calc.findMaxIndex(this.Qlearn[xFood + 1][yFood + 1][up][right][down][left][this.direction]);
       this.getReward();
       this.collision();
       
       snake.turn(action);
       this.move();
       if (!this.game){
         this.reset();
       }
     }

     
  }
  
  
  
  void setState(){
    //set state hashtable 
    //set food indicators
        
    this.state.put("xFood", this.i_food != this.coords[0][0] ? (this.i_food - this.coords[0][0])/Math.abs(this.i_food - this.coords[0][0]) : 0);
    this.state.put("yFood", this.j_food != this.coords[0][1] ? (this.j_food - this.coords[0][1])/Math.abs(this.j_food - this.coords[0][1]) : 0);
    //create around coords
    for (int i = 0; i < 4; i++){
      //check if collision
      //if (contains(this.adjacent[i], this.coords, 2)){
      //  print("BLAH");
      //}
      if ( contains(SIZE, this.adjacent[i]) || contains(-1, this.adjacent[i])){
        this.state.put(Integer.toString(i), 1 );
      } else {
        this.state.put(Integer.toString(i), 0 );
      }
    }
  }
  
  void getNextState(int move){
    //create pseudo state
    //created add variables for pseudo next move
    int iAdd = 0;
    int jAdd = 0;
   switch(move){
        case 0:
          jAdd = -1;
        break;
        case 1:
           iAdd = 1;
        break;
        case 2:
          jAdd = 1;
        break;
        case 3:
          iAdd = -1;
        break;

     }
     
    //add iAdd and jAdd to state for use in reward
    this.state.put("iAdd", iAdd);
    this.state.put("jAdd", jAdd);
    //set next state for food
    this.state.put("xFoodNext", this.i_food != this.coords[0][0] + iAdd ? (this.i_food - (this.coords[0][0] + iAdd))/Math.abs(this.i_food - (this.coords[0][0] + iAdd)) : 0);
    this.state.put("yFoodNext", this.j_food != this.coords[0][1]  + jAdd? (this.j_food - (this.coords[0][1] + jAdd))/Math.abs(this.j_food - (this.coords[0][1]+jAdd)) : 0);
    //create around coords using 4-8
    for (int i = 0; i< 4; i++){
      this.nextAdjacent[i][0] = this.adjacent[i][0] + iAdd;
      this.nextAdjacent[i][1] = this.adjacent[i][1] + jAdd;
    }
    
    for (int i = 0; i < 4; i++){
      if (contains(this.nextAdjacent[i], this.coords, 1) || contains(SIZE, this.nextAdjacent[i]) || contains(-1, this.nextAdjacent[i])){
        this.state.put(Integer.toString(i) + "Next", 1 );
      } else {
        this.state.put(Integer.toString(i) + "Next", 0 );
      }
    }
  }
  
  int getReward(){
    int reward = 0;
    
    
    if ( this.state.get("iAdd") == this.state.get("xFood") && this.state.get("iAdd") != 0){
      reward += 1;
      if ( this.state.get("jAdd") == this.state.get("yFood") ){
        reward += 1;
      } 
    } 
    else if ( this.state.get("jAdd") == this.state.get("yFood") && this.state.get("jAdd") != 0 ){
      reward += 1;
    } 
    else {
      reward -= 2;
    }
    if (this.coords[0][0] == this.i_food && this.coords[0][1] == this.j_food){
        reward += 100;
       snake.eat();
     }

    return reward;
  }
  
  void reset(){
    this.game =true;
    this.len = LENGTH;
    this.direction = int(random(4));
    this.coords[0][0] = int(random(SIZE));
    this.coords[0][1] = int(random(SIZE));
    this.coords[1][0] = this.coords[0][0] - 1;
    this.coords[1][1] = this.coords[0][1];
    this.i_food = int(random(SIZE));
    this.j_food = int(random(SIZE));
    this.train += 1;
    if (this.train == ITERATIONS){
      frameRate(30);
      this.epsilon = 1;
    }
    this.last = new int[4];
    
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
      
      //print("Coords", this.coords[0][0], this.coords[0][1], "Adjacent num ", i, "Adjacent: ", this.adjacent[i][0], this.adjacent[i][1], "\n");

    }
  }
  
}
