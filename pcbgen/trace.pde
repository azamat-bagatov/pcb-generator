class Trace {
  ArrayList<PVector> points;

  Trace() {
    points = new ArrayList<PVector>();
  }
  
  void createRandom(){
    float x = randomX();
    float y = randomY();

    while(true){
      points.add(new PVector(x, y));
      float len = random(10,200);
      
      if(chance(5)) {
        
        break;
      }
    }
    
  }

  //void randomPath() {
  //  int len = (int)random(5, 10);
  //  int x = (int)random(cols) * grid;
  //  int y = (int)random(rows) * grid;
  //  points.add(new PVector(x, y));
  //  for (int i = 0; i < len; i++) {
  //    int dir = (int)random(4);
  //    if (dir == 0) x += grid;
  //    if (dir == 1) x -= grid;
  //    if (dir == 2) y += grid;
  //    if (dir == 3) y -= grid;
  //    points.add(new PVector(x, y));
  //  }
  //}

  //void display() {
  //  stroke(c);
  //  noFill();
  //  strokeWeight(2);
  //  for (int i = 1; i < points.size(); i++) {
  //    PVector p1 = points.get(i-1);
  //    PVector p2 = points.get(i);
  //    if (random(1) > 0.8) {
  //      bezier(p1.x, p1.y, p1.x+10, p1.y+10, p2.x-10, p2.y-10, p2.x, p2.y);
  //    } else {
  //      line(p1.x, p1.y, p2.x, p2.y);
  //    }
  //    if (random(1) > 0.9) drawVia(p1.x, p1.y);
  //  }
  //}


}
