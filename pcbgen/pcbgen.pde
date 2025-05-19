PFont pcbFont;

import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus


color BACKGROUND_COLOR = color(29);
color GREEN = color(50, 254, 128);
color GOLD = color(228, 171, 41);

ArrayList <Trace> traces;
String[] namelist = {"SCHEK", "NINECANS", "SYNESTETICA", "NTA", "HT", "SHUBENTEGA", "SYDORETS", "GELIOLIN", "VORON","716"}; 


void setup() {

  //size(1920, 1080);
  fullScreen();
  smooth(8);
  background(BACKGROUND_COLOR);
  pcbFont = createFont("Montserrat-Medium.ttf", 32);
  
  textFont(pcbFont);
  textSize(20);
  //myBus = new MidiBus(this, "Akai MPD32", "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
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
long nametimer = millis();
long wordstimer = millis();
String displayName = "LOADING...";
String randomWords = "XXXXXX...";

void draw() {
  background(BACKGROUND_COLOR);
  
  
  float rectW = width/4;
  float rectH = height/4;
  float rectX = width/2 - rectW/2;
  float rectY = height/2 - rectH/2;
  
  
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
  
  //draw window bar
  int barheight = 20;
  stroke(GOLD);
  strokeWeight(2);
  fill(GOLD);
  rect(rectX-5, rectY-barheight-5,rectW+10, barheight);
  //draw rings
  noStroke();
  fill(BACKGROUND_COLOR);
  int esz = barheight - 8;
  for (int i = 0; i < 3; i++){
    ellipse(rectX+rectW + esz - (esz+esz/2)*(i+1), rectY-barheight+6, esz, esz);
  }
  
  
  fill(GREEN);
  textAlign(RIGHT);
  text(millis(),rectX+rectW - 5, rectY+rectH - 5);
  
  text("'ONECRU",rectX+rectW-5, rectY + 20);
  
  textAlign(LEFT);
  text(displayName,rectX+5, rectY + 20);
  text(randomWords,rectX+5, rectY+rectH-5);
  
  //every x seconds update traces
  if(millis() - timer > 1500){
    timer = millis();
    create_random_traces();
  }
  //every x seconds update text
   if(millis() - nametimer > 750){
    nametimer = millis();
    displayName = random_out_of_list(namelist);
  }
  
  //every x seconds update text
   if(millis() - wordstimer > 375){
    wordstimer = millis();
    randomWords = "#" + randomString(12);
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
  if (key == 'c') clear_matrix();
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
