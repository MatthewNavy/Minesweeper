int rows = 20;
int cols = 20;
Cell[][] cells = new Cell[rows][cols];
int size = 30;
int flags = 0;
int mines = 0;

void setup(){
  println("Hello and welcome to Minesweeper!\nLeft Click to reveal, Right Click to place flags.\nPlace all flags correctly to win.\n");
  size(601,601);
  background(100);
  
  //initialize cells
  for(int r = 0; r < rows; r++){
    for(int c = 0; c < cols; c++){
       cells[r][c] = new Cell(r*size,c*size,size,r,c);
    }
  }
  
  //set bombs
  calcBombs();
  
  //calculate number of neighbors
  calcNeighbors();
}

//check if cell is on edge of grid
boolean inBoundary(int x, int y){
  if(x >= 0 && x < rows && y >= 0 && y < cols){
    return true; 
  }
  return false;
}

void draw(){
  //draw cells
  for(int r = 0; r < rows; r++){
    for(int c = 0; c < cols; c++){
      cells[r][c].show();
      if(cells[r][c].red){
         cells[r][c].setRed();
       }
    }
  }
  if(mines == flags){
    println("YOU WIN! :)");
     restart(); 
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    for(int r = 0; r < rows; r++){
      for(int c = 0; c < cols; c++){
        Cell a = cells[r][c];
        if(mouseX < a.x + a.w && mouseX > a.x && mouseY < a.y + a.w && mouseY > a.y){
          cells[r][c].click();
        }
        if(mouseX < a.x + a.w && mouseX > a.x && mouseY < a.y + a.w && mouseY > a.y && cells[r][c].isBomb){
          frameRate(0.1);
          cells[r][c].show();
          println("YOU LOSE :(");
          restart();
        }
      }
    }
  }
  if(mouseButton == RIGHT){
    for(int r = 0; r < rows; r++){
      for(int c = 0; c < cols; c++){
        Cell a = cells[r][c];
        if(mouseX < a.x + a.w && mouseX > a.x && mouseY < a.y + a.w && mouseY > a.y){
          pushStyle();
          if(cells[r][c].red)
          {
            cells[r][c].red = false;
            if(cells[r][c].isBomb){
              flags--;
            }
          }
          else{
            cells[r][c].red = true;
            if(cells[r][c].isBomb){
              flags++;
            }
          }
          redraw();
          popStyle();
        }
      }
    }
  }
}

void restart(){
  frameRate(10);
  mines = 0;
  flags = 0;
  for(int r = 0; r < rows; r++){
    for(int c = 0; c < cols; c++){
       cells[r][c].isBomb = false;
       cells[r][c].clicked = false;
       cells[r][c].numNeighbors = 0;
       cells[r][c].red = false;
    }
  }
       calcBombs();
       calcNeighbors();
}

void calcBombs(){
  for(int r = 0; r < rows; r++){
    for(int c = 0; c < cols; c++){
       double rand = Math.random();
       if(rand < 0.14)
       {
         cells[r][c].isBomb = true;
         mines++;
       }
    }
  }
}
  
void calcNeighbors(){
  for(int r = 0; r < rows; r++){
    for(int c = 0; c < cols; c++){
       int total = 0;
       for(int i = -1; i <= 1; i++){
         for(int j = -1; j <= 1; j++){
            if(inBoundary(r+i,c+j)){
              if(cells[r+i][c+j].isBomb){
                total++; 
              }
            }
         }
       }
       cells[r][c].numNeighbors = total;
       if(cells[r][c].isBomb){
         cells[r][c].numNeighbors = 0;
       }
    }
  }
}