PFont pcbFont;

import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus


color BACKG = color(29);
color GOLD = color(228, 171, 41);
color GREEN = color(50, 254, 128);

ArrayList <Trace> traces;
String[] namelist = {"SCHEK", "NINECANS", "SYNESTETICA", "NTA", "HT", "SHUBENTEGA", "SYDORETS", "GELIOLIN", "VORON","716"}; 
int fieldW,fieldH;

void setup() {

  //size(1920, 1080);
  fullScreen();
  smooth(8);
  background(BACKG);
  pcbFont = createFont("Montserrat-Medium.ttf", 32);
  
   fieldW = width*2/3;
   fieldH = height*2/3;
  
  textFont(pcbFont);
  textSize(20);
  //myBus = new MidiBus(this, "Akai MPD32", "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  traces = new ArrayList<Trace>();
  fill(GOLD);
 
  rectMode(CENTER);
  rect(width/2,height/2, fieldW,fieldH);
  for(int i = 0; i < 25; i++) traces.add(new Trace());
  draw_grid();
}

boolean pause = true;
void draw() {
  if(pause) return;
  for (Trace t : traces) {
    t.draw();
  }

}

void create_random_traces(){
  traces.clear();
  for (int i = 0; i<random(10,40); i++){
    traces.add(new Trace());
  }
}

void draw_grid(){
  stroke(BACKG);
  int i = 0;
  int j = 0;
  
  while (i < width){
    while(j < height){
      point(i,j);
      j+=GRID_STEP;
    }
    i+=GRID_STEP;
    j = 0;
  }
}

String randomString(int len) {
  String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  String result = "";

  for (int i = 0; i < len; i++) {
    int index = int(random(chars.length()));
    result += chars.charAt(index);
  }

  return result;
}


int prevInd = 0;

String random_out_of_list(String[] list){
  int len = list.length;
  int ind = (int) random(0,len);
  
  if(ind == prevInd) ind = len-ind-1;
  
  prevInd = ind; 
  return list[ind];
}

void keyPressed(){
  if(key == ' ') pause = !pause;
}


void dispose(){
  //myBus.dispose();
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
