color BACKGROUND_COLOR = color(29);
color GREEN = color(50,254,128);
color GOLD = color(228,171,41);


void setup(){
  
  size(1920,1080);
  background(BACKGROUND_COLOR);
  stroke(GOLD);
}

float strokeW = 20;

void draw(){
  
  
  strokeWeight(strokeW);
  
  line(randomX(),randomY(),randomX(),randomY());
  
  strokeW--;
  if(strokeW < 0)  {
    strokeW = 20;
    background(BACKGROUND_COLOR);
    delay(2000);
  }
}

float randomX(){
  return random(0,width);
}

float randomY(){
  return random(0,height);
}
