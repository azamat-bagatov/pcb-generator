color BACKGROUND_COLOR = color(29);
color GREEN = color(50, 254, 128);
color GOLD = color(228, 171, 41);


void setup() {

  //size(1920, 1080);
  fullScreen();
  background(BACKGROUND_COLOR);
  stroke(GOLD);
  rectMode(CENTER);
}

float strokeW = 20;

void draw() {
  background(BACKGROUND_COLOR);
  for( int n = 0; n< 20; n++){
  strokeWeight(strokeW);

  //line(randomX(),randomY(),randomX(),randomY());
  for ( int i = 0; i < (int) random(0, (22-strokeW)/2); i++) random_trace();

  strokeW--;
  if (strokeW < 0) {
    strokeW = 20;
    //background(BACKGROUND_COLOR);
    //delay(2000);
  }
  }
}

float traceX, traceY = 0;

void random_trace() {
  //startpoint
  traceX = randomX();
  traceY = randomY();
  float startX = traceX;
  float startY = traceY;
  boolean firstPass = true;

  while ( chance(95) ) {

    line_random_45();
    if (firstPass) {
      pushStyle();
      noStroke();
      fill(GOLD);
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
  float len = randomGaussian()*100;
  float ang = random_45_angle();

  float xEnd = traceX+len*cos(ang);
  float yEnd = traceY+len*sin(ang);

  println(" DIR: " + ang + " x:" + xEnd + " | y:" + yEnd);

  line(traceX, traceY, xEnd, yEnd);
  traceX = xEnd;
  traceY = yEnd;
}

float random_45_angle() {
  float randAng = random(0, TWO_PI);
  return randAng - randAng%(PI/4);
}

void pline(float x, float y, float ang, float len) {
  float xEnd = x+len*cos(ang);
  float yEnd = x+len*sin(ang);
  line(x, y, xEnd, yEnd);
}
float randomX() {
  return random(0, width);
}

float randomY() {
  return random(0, height);
}
