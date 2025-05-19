float TRACE_OUTLINE_W = 4;
float GRID_STEP = 24;

boolean isGridPoint(int X, int Y) {
  if ( X % GRID_STEP == 0 && Y % GRID_STEP == 0) return true;
  else return false;
}

class Trace {
  //ArrayList<PVector> points;
  float weight = 0;
  float X, Y;
  PVector point, dir, target;
  float step = 0;
  float speed = 0.1;
  
  Trace() {
    
    dir = new PVector();
    target = new PVector();
    point  = new PVector();
    reset();
    
  }
  
  void reset(){
    weight = random(4, 20);
    X = randomXgrid();
    Y = randomYgrid();
    point.x = X;
    point.y = Y;
    println("//" +X+" "+Y);
    do {
      dir.x = (int)random(-1, 2);
      dir.y = (int)random(-1, 2);
    } while (dir.x == 0 && dir.y ==0 );
    target.x = point.x + dir.x*GRID_STEP;
    target.y = point.y + dir.y*GRID_STEP;
    drawEnd();
  }

  void update() {
    //move dot one pixel in a dir
    step = step + speed;
    X=lerp(point.x, target.x, step);
    Y=lerp(point.y, target.y, step);
    
    // if reached target
    if ( onTarget()) {
      println("----!");
      updTarget();
      if ( chance(50) ) {
        randomDir();
        updTarget();
        println("---->");
        if ( chance( (int)outboundFactor() ) ) {
          drawEnd();
          reset();
        }
      }
    }
  }
  
  void drawEnd(){
    noStroke();
          fill(BACKG);
          ellipse(X, Y, weight*2+TRACE_OUTLINE_W*2, weight*2+TRACE_OUTLINE_W*2);
          fill(GOLD);
          ellipse(X, Y, weight*2, weight*2);
          fill(BACKG);
          ellipse(X, Y, weight, weight);
  }
  
  float outboundFactor(){
    //return 0;
    if( distanceToFieldEdge() > 0 ) return distanceToFieldEdge();
    return 0;
  }
  float distanceToFieldEdge() {
    float cx = width / 2.0;
    float cy = height / 2.0;

    float dx = abs(X - cx) - fieldW / 2.0;
    float dy = abs(Y - cy) - fieldH / 2.0;

    float outsideDist = max(dx, 0) + max(dy, 0);  // distance outside field
    float insideDist = min(max(dx, dy), 0);       // distance inside field (negative)

    return (outsideDist > 0) ? outsideDist : insideDist;
  }


  boolean onTarget() {
    return abs(target.x-X) <2 && abs(target.y-Y) < 2;
  }

  void updTarget() {
    point.x = target.x;
    point.y = target.y;
    target.x = target.x + dir.x*GRID_STEP;
    target.y = target.y + dir.y*GRID_STEP;
    println("XY" +X+" "+Y + " | POINT: " + point.x + " " + point.y + " | TARGET:" + target.x + " " + target.y );
    step = 0;
  }

  void randomDir() {
    int newX, newY;
    do {
      newX = (int)random(-2, 2);
      newY = (int)random(-2, 2);
      //println("NEW>" + newX + " " + newY); 
      //println("OLD>" + dir.x + " " + dir.y); 
    } while ((newX == -dir.x && newY == -dir.y) || (newX == 0 && newY == 0) );
    //println(">>>>>" + newX + " " + newY); 
    dir.x = newX;
    dir.y = newY;
  }

  void draw() {
    update();
    strokeWeight(weight+TRACE_OUTLINE_W*2);
    stroke(BACKG);
    line(point.x,point.y,X,Y);
    
    strokeWeight(weight);
    stroke(GOLD);
    line(point.x,point.y,X,Y);
  }
}
