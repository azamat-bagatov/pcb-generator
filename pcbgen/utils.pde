boolean chance ( int percent) {
  return random(100) < percent;
}

float prev_ang_val = 0;

float random_fr_angle() {
  float randAng = random(0, TWO_PI);
  int ANGLE_FRAGMENTATION = 4;
  
  while(true){
    randAng = random(0, TWO_PI);
    randAng = randAng - randAng%(PI/ANGLE_FRAGMENTATION);
    if( abs(randAng - prev_ang_val) > PI) break;
  }
  prev_ang_val = randAng;
  return randAng;
}

PVector pline(PVector p, float len, float ang) {
  float xEnd = p.x+len*cos(ang);
  float yEnd = p.y+len*sin(ang);

  return new PVector(xEnd,yEnd);
}

float randomX() {
  return random((width - fieldW)/2, width - (width - fieldW)/2 );
}

float randomY() {
  return random((height - fieldH)/2, height - (height - fieldH)/2 );
}

int randomXgrid() {
  return int (GRID_STEP*int(randomX())/GRID_STEP);
}

int randomYgrid() {
  return  int( GRID_STEP*int(randomY())/GRID_STEP);
}

float randomXcentered() {
  return width/2 - ((randomGaussian())*width/10);
}

float randomYcentered() {
  return height/2 - ((randomGaussian())*height/10);
}


int NUM_POINTS = 200;
float[][] header_matrix = new float[NUM_POINTS][2];
float headerStep = 40;

void fill_matrix_center(){
  for(int i = 0; i < NUM_POINTS; i++){
    int stX = int(width - headerStep*NUM_POINTS)/2;
    header_matrix[i][0] = stX + i*headerStep;
    header_matrix[i][1] = height/2;
  }
}

void fill_matrix(){
  int n = 0;
  while (n < NUM_POINTS){
    int len = (int) randomGaussian()*4;
    float startX = randomX();
    float startY = randomY();
    for (int i = 0 ; i < len; i++){
      header_matrix[n][0] = startX + i*headerStep;
      header_matrix[n][1] = startY;
      n++;
      if(n > NUM_POINTS-1) return;
    }
  } 
}

void clear_matrix(){
    for(int i = 0; i < NUM_POINTS; i++){
    header_matrix[i][0] = 0;
    header_matrix[i][1] = 0;
  }
}

//drawing thing
int gx = int( mouseX - mouseX%headerStep);
int gy = int( mouseY - mouseY%headerStep);
int prevX = gx; int prevY = gy;
int ind = 0;

void mouseDragged(){
   gx = int( mouseX - mouseX%headerStep);
   gy = int( mouseY - mouseY%headerStep);
    
  
  if(gx != prevX || gy != prevY) {
  header_matrix[ind][0] = gx;
  header_matrix[ind][1] = gy;
  ind++;
  if (ind > NUM_POINTS-1) ind = 0;
  println(ind);
  prevX = gx;  prevY = gy;
  }
}
