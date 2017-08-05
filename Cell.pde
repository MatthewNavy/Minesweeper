class Cell{
  float x;
  float y;
  float w;
  boolean isBomb;
  boolean clicked;
  int numNeighbors;
  int r;
  int c;
  boolean red;
  
  
  Cell(float x_, float y_, float w_, int r_, int c_){
    x = x_;
    y = y_;
    w = w_;
    isBomb = false;
    clicked = false;
    numNeighbors = 0;
    r = r_;
    c = c_;
    red = false;
  }
  
  void show(){
    fill(150);
    rect(x,y,w,w);
    if(clicked){
      if(numNeighbors > 0){
        fill(80);
        rect(x,y,w,w);
        fill(180);
        textSize(22);
        textAlign(CENTER,CENTER);
        text(numNeighbors,x+15.5,y+13.5);
      }
      else{
        fill(80);
        rect(x,y,w,w);
      }
    }
    if(isBomb && clicked){
      fill(80);
      rect(x,y,w,w);
      ellipseMode(CENTER);
      fill(0);
      ellipse(x+w/2,y+w/2,w-10,w-10);
    }
}
  
  void click(){
    clicked = true;
    if(numNeighbors == 0 && !isBomb){
     for(int i = -1; i <= 1; i++){
        for(int j = -1; j <= 1; j++){
          if(inBoundary(r+i,c+j) && !cells[r+i][c+j].clicked){
              cells[r+i][c+j].click();
          }
        }
     }
   }
  }
  
  void setRed(){
    if(!clicked){
      colorMode(RGB);
      fill(255,0,0);
      rect(x,y,w,w);
      fill(180);
      textSize(22);
      textAlign(CENTER,CENTER);
      text("B",x+15.5,y+13.5);
    }
  }
}