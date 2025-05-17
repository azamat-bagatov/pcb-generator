boolean chance ( int percent) {
  return random(100) < percent;
}
int  ANGLE_FRAGMENTATION = 4;

float random_45_angle() {
  float randAng = random(0, TWO_PI);
  return randAng - randAng%(PI/ANGLE_FRAGMENTATION);
}

PVector pline(PVector p) {
  float xEnd = x+len*cos(ang);
  float yEnd = y+len*sin(ang);
  line(x, y, xEnd, yEnd);
  float[] coords = {xEnd,yEnd};
  return coords;
}

float randomX() {
  return random(0, width);
}

float randomY() {
  return random(0, height);
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
