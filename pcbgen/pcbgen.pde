import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus


color BACKGROUND_COLOR = color(0); //color(29);
color GREEN = color(255); //color(50, 254, 128);
color GOLD = color(255); //color(228, 171, 41);

int NUM_POINTS = 400;
int SEGMENT_LEN_SCALE = 200;
int ENDSTOP_CHANCE = 85;
int DENSITY_FACTOR = 22;
int ANGLE_FRAGMENTATION = 4;
int FRAME_DELAY = 30;
int MAX_STROKE_WIDTH = 20;

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

void setup() {

  //size(1920, 1080);
  fullScreen();
  background(BACKGROUND_COLOR);
  stroke(GOLD);
  rectMode(CENTER);
  //fill_matrix_center();
  smooth(80);
  
  myBus = new MidiBus(this, "Akai MPD32", "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

}

float strokeW =MAX_STROKE_WIDTH;

void draw() {
  
  background(BACKGROUND_COLOR);
  for( int n = 0; n < 20; n++){
  strokeWeight(strokeW);

  for ( int i = 0; i < (int) random(0, (DENSITY_FACTOR-strokeW)/2); i++) random_trace();

  strokeW--;
  if (strokeW < 0) {
    strokeW = MAX_STROKE_WIDTH;
  }
  }
  delay(FRAME_DELAY);
}

void keyPressed(){
  if (key == 'c') clear_matrix();
}

void clear_matrix(){
    for(int i = 0; i < NUM_POINTS; i++){
    header_matrix[i][0] = 0;
    header_matrix[i][1] = 0;
  }
}
void dispose(){
  myBus.dispose();
  println("done");
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

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  
  if( number == 12) ENDSTOP_CHANCE = (int)map(value,0,127,0,100);
  else if (number == 13) SEGMENT_LEN_SCALE = (int)map(value,0,127,0,400);
  else if (number == 14) DENSITY_FACTOR = (int) map(value,0,127,10,50);
  else if (number == 15) ANGLE_FRAGMENTATION = (int) map(value,0,127,1,24);
  else if (number == 17) FRAME_DELAY = (int) map(value,0,127,1,240);
  else if (number == 16) MAX_STROKE_WIDTH = (int) map(value,0,127,1,100);
}

float traceX, traceY = 0;

void random_point_from_matrix(){
  int p = (int) random(0,NUM_POINTS);
  traceX = header_matrix[p][0];
  traceY = header_matrix[p][1];
}

void random_trace() {
  //startpoint
  random_point_from_matrix();
  if(traceX == 0) return;
  float startX = traceX;
  float startY = traceY;
  boolean firstPass = true;

  while ( chance(ENDSTOP_CHANCE) ) {

    line_random_45();
    if (firstPass) {
      pushStyle();
      noStroke();
      fill(GREEN);
      ellipse(startX, startY, strokeW*2, strokeW*2);
      fill(BACKGROUND_COLOR);
      ellipse(startX, startY, strokeW, strokeW);
      popStyle();
      firstPass = false;
    }
  }

  pushStyle();
  noStroke();
  fill(GOLD);
  ellipse(traceX, traceY, strokeW*2, strokeW*2);
  fill(BACKGROUND_COLOR);
  ellipse(traceX, traceY, strokeW, strokeW);
  popStyle();
}

boolean chance ( int percent) {
  return random(100) < percent;
}


void line_random_45() {
  float len = randomGaussian()*SEGMENT_LEN_SCALE;
  float ang = random_45_angle();

  float xEnd = traceX+len*cos(ang);
  float yEnd = traceY+len*sin(ang);

  //println(" DIR: " + ang + " x:" + xEnd + " | y:" + yEnd);

  line(traceX, traceY, xEnd, yEnd);
  traceX = xEnd;
  traceY = yEnd;
}

float random_45_angle() {
  float randAng = random(0, TWO_PI);
  return randAng - randAng%(PI/ANGLE_FRAGMENTATION);
}

void pline(float x, float y, float ang, float len) {
  float xEnd = x+len*cos(ang);
  float yEnd = y+len*sin(ang);
  line(x, y, xEnd, yEnd);
}
float randomX() {
  return random(0, width);
}

float randomY() {
  return random(0, height);
}
