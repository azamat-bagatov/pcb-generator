PFont pcbFont;

//color BACKG = color(29);
//color GOLD = color(228, 171, 41);
color BACKG = color(0);
color GOLD = color(255);

color GREEN = color(50, 254, 128);

ArrayList <Trace> traces;

int fieldW,fieldH;
float GRID_STEP = 24;

HashMap<String, Boolean> occupiedGrid = new HashMap<String, Boolean>();

String gridKey(float x, float y) {
  
  int gx = round(x / GRID_STEP);
  int gy = round(y / GRID_STEP);
  println(" ADD x = " + x + " y = " + y + "gx = " + gx + "gy = "+gy);
  return gx + "," + gy;
}

void add_point(float x, float y) {
  
  occupiedGrid.put(gridKey(x, y), true);
}

boolean is_occupied(float x, float y) {
  return occupiedGrid.containsKey(gridKey(x, y));
}

void setup() {

  fullScreen();
  smooth(8);
  background(BACKG);
  pcbFont = createFont("Montserrat-Medium.ttf", 32);
  
   fieldW = width*2/3;
   fieldH = height*2/3;
  
  textFont(pcbFont);
  textSize(20);

  traces = new ArrayList<Trace>();
  fill(GOLD);
 
  rectMode(CENTER);
  rect(width/2,height/2, fieldW,fieldH);
  for(int i = 0; i < 10; i++) traces.add(new Trace());
  draw_grid();
}


boolean pause = true;

void draw() {
  if(pause) return;
  for (Trace t : traces) {
    if(t.live) t.draw();
    //else traces.remove(t);
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
