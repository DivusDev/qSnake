
static class Calc {
  public double sigmoid(double x) {
    return (1/( 1 + Math.pow(Math.E,(-1*x))));
  }
  
  static public int findMaxIndex(double [] arr) {  
     double max = arr[0];  
     int maxIdx = 0;  
     for(int i = 1; i < arr.length; i++) {  
          if(arr[i] > max) {  
             max = arr[i];  
             maxIdx = i;  
          }  
     }  
     return maxIdx;  
  } 
}

class Matrix
{
   public double [][]data;
   public int rows,cols;
   
   Matrix(int rows, int cols){
      data = new double[rows][cols];
      this.rows = rows;
      this.cols = cols;
      for (int i = 0; i < rows; i++){
       for(int j = 0; j < cols; j++){
         this.data[i][j] = Math.random()*2 - 1;
       }
      }
   }
   
  public void add(double scaler){
    for (int i = 0; i < rows; i++){
       for(int j = 0; j < cols; j++){
         this.data[i][j] += scaler;
       }
      }
  }
  
  public void add(Matrix M){
    for (int i = 0; i < rows; i++){
       for(int j = 0; j < cols; j++){
         this.data[i][j] += M.data[i][j];
       }
    }
  }
  
  public void subtract(double scaler){
    for (int i = 0; i < rows; i++){
       for(int j = 0; j < cols; j++){
         this.data[i][j] -= scaler;
       }
    }
  }
  
  public void subtract(Matrix M){
    for (int i = 0; i < rows; i++){
       for(int j = 0; j < cols; j++){
         this.data[i][j] -= M.data[i][j];
       }
    }
  }
  
  public Matrix multiply(Matrix A, Matrix B){
    if (A.cols != B.rows){
      throw new Error("Error in Matrix multiplication. Rows != cols");
    }
    Matrix result = new Matrix(A.cols, B.rows);
    for (int i = 0; i < result.rows; i++){
       for(int j = 0; j < result.cols; j++){
        double sum = 0;
        for (int k = 0; k < A.cols; k++){
          sum += A.data[i][k] * B.data[k][j];
        }
        result.data[i][j] = sum;
       }
    }
   return result;
  }

  
 
  
}

boolean contains(int item, int[] arr){
  for (int i = 0; i < arr.length; i++) {
      if (arr[i] == item){
        return true;
      }
  }
  return false;
}
boolean contains(int item, int[] arr, int start){
  for (int i = start; i < arr.length; i++) {
      if (arr[i] == item){
        return true;
      }
  }
  return false;
}

boolean contains(int item[], int[][] arr, int start){
  boolean match = true;
  for (int i = start; i < arr.length; i++) {
      for (int k = 0; k < item.length; k++){
        if (item[k] == arr[i][k] && match) {
          match = true;
        }
      }
      match = false;
  }
  return true;
}
