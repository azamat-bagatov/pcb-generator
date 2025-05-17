class Trace {
  ArrayList<PVector> points;
  float weight = 0;
  Trace() {
    points = new ArrayList<PVector>();
    createRandom();
    weight = random(1,20);
  }
  
  void createRandom(){
    float x = randomX();
    float y = randomY();
    points.add(new PVector(x, y));
    int n_segs = (int) abs( randomGaussian()*10);
    println(n_segs);
    for(int i = 0 ; i < n_segs; i++){    
      float len = random(10,200);
      float angle = random_fr_angle();
      points.add( pline(points.get(points.size()-1),len, angle) );
    }
    
  }
  
  void draw(){
    fill(BACKGROUND_COLOR);
    strokeWeight(10);
    stroke(GOLD);
    strokeWeight(weight);
    if(points.size() < 2) return;
    
    for(int i = 1; i < points.size(); i++){
      PVector p1 = points.get(i-1);
      PVector p2 = points.get(i);
      line(p1.x, p1.y, p2.x, p2.y);
      if(i == 1) ellipse(points.get(0).x, points.get(0).y, weight*2,weight*2);
    }
    ellipse(points.get(points.size()-1).x, points.get(points.size()-1).y, weight*2,weight*2);
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
