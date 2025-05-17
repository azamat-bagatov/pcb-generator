PFont pcbFont;

import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus


color BACKGROUND_COLOR = color(29);
color GREEN = color(50, 254, 128);
color GOLD = color(228, 171, 41);

ArrayList <Trace> traces;



void setup() {

  //size(1920, 1080);
  fullScreen();
  smooth(8);
  background(BACKGROUND_COLOR);
  pcbFont = createFont("OCR-a___.ttf", 32);
  
  textFont(pcbFont);
  myBus = new MidiBus(this, "Akai MPD32", "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  traces = new ArrayList<Trace>();
  create_random_traces();
    
}

void create_random_traces(){
  traces.clear();
  for (int i = 0; i<random(10,40); i++){
    traces.add(new Trace());
  }
}

long timer = millis();
void draw() {
  background(BACKGROUND_COLOR);
  
  float rectX = width/2 - width/10;
  float rectY = height/2 - height/10;
  float rectW = width/5;
  float rectH = height/5;
  
  clip(rectX, rectY,rectW, rectH);
  for (Trace t : traces) {
    t.draw();
  }
  noClip();
  //draw frame
  noFill();
  stroke(GOLD);
  strokeWeight(2);
  rect(rectX, rectY,rectW, rectH);
  rect(rectX-5, rectY-5,rectW+10, rectH+10);
  
  
  fill(GREEN);
  textAlign(RIGHT);
  text(millis(),rectX+rectW - 5, rectY+rectH - 5);
  
  text("'ONECRU",rectX+rectW - 5, rectY + 25);
  
  //every 2 seconds update
  if(millis() - timer > 1500){
    timer = millis();
    create_random_traces();
  }
}

void keyPressed(){
  if (key == 'c') clear_matrix();
}


void dispose(){
  myBus.dispose();
  println("done");
}



void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  
  //if( number == 12) ENDSTOP_CHANCE = (int)map(value,0,127,0,100);
  //else if (number == 13) SEGMENT_LEN_SCALE = (int)map(value,0,127,0,400);
  //else if (number == 14) DENSITY_FACTOR = (int) map(value,0,127,10,50);
  //else if (number == 15) ANGLE_FRAGMENTATION = (int) map(value,0,127,1,24);
  //else if (number == 17) FRAME_DELAY = (int) map(value,0,127,1,240);
  //else if (number == 16) MAX_STROKE_WIDTH = (int) map(value,0,127,1,100);
}
