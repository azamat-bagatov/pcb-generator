




boolean isGridPoint(int X, int Y) {
  if ( X % GRID_STEP == 0 && Y % GRID_STEP == 0) return true;
  else return false;
}

class Trace {
  float weight = 0;
  float X, Y;
  PVector point, dir, target;
  float step = 0;
  float speed = 0.2;
  float TRACE_OUTLINE_W = 0;
  boolean live = true;

  Trace() {

    dir = new PVector();
    target = new PVector();
    point  = new PVector();
    reset();
    TRACE_OUTLINE_W = weight/2;
  }

  void reset() {
    weight = random(4, 12);
    
    do{
    X = randomXgrid();
    Y = randomYgrid();
    } while ( is_occupied(X,Y)) ; //stupid loop, needs redoing
    
    point.x = X;
    point.y = Y;
    
    do {
      dir.x = (int)random(-1, 2);
      dir.y = (int)random(-1, 2);
    } while (dir.x == 0 && dir.y ==0 ); //stupid loop
    
    target.x = point.x + dir.x*GRID_STEP;
    target.y = point.y + dir.y*GRID_STEP;
    add_point(point.x, point.y);
    drawEnd();
  }

  int update() {
    //move dot one pixel in a dir
    step = step + speed;
    X=lerp(point.x, target.x, step);
    Y=lerp(point.y, target.y, step);

    // if reached target grid point
    if ( onTarget()) {
      add_point(target.x, target.y);
      drupd();      //record old point and target
      
      if ( chance(50) ) {
        //change direction
          randomDir(); 
          updTarget();  
        //terminate if gets out of frame
        if ( chance( (int)outboundFactor() ) ) {
          terminate();
        }
        
      }
      
      else updTarget();
     
      return 1;
    }
    return 0;
  }
  void terminate(){
    drawEnd();
    //reset();
    live = false; 
    println( "END");
  }
  void drawEnd() {
    noStroke();
    fill(BACKG);
    ellipse(X, Y, weight*3, weight*3); //+TRACE_OUTLINE_W*2+2
    fill(GOLD);
    ellipse(X, Y, weight, weight);
  }

  float outboundFactor() {
    //return 0;
    if ( distanceToFieldEdge() > 0 ) return distanceToFieldEdge();
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
    step = 0;
    point.x = target.x;
    point.y = target.y;
    
    target.x = point.x + dir.x*GRID_STEP;
    target.y = point.y + dir.y*GRID_STEP;
    
    int i = 0;
    while( is_occupied(target.x, target.y))  
    {
      i++;
      randomDir();
      target.x = point.x + dir.x*GRID_STEP;
      target.y = point.y + dir.y*GRID_STEP;
      if( i > 9 ) {
        terminate();
        break;
      }
    }
    
    
  }

  void randomDir() {
    int newX, newY;
    do {
      newX = (int)random(-2, 2);
      newY = (int)random(-2, 2);

    } while ((newX == -dir.x && newY == -dir.y) || (newX == 0 && newY == 0) || (newX < 0 ));
    dir.x = newX;
    dir.y = newY;
  }

  float oldX = 0;
  float oldY = 0;
  float oldstX = 0;
  float oldstY = 0;

  void drupd() {
    oldX = target.x;
    oldY = target.y;
    oldstX = point.x;
    oldstY = point.y;
  }
  void draw() {

    //on grate step, record old line
    update();
    stroke(BACKG);
    strokeWeight(weight+TRACE_OUTLINE_W*2);
    line(point.x, point.y, X, Y);
    line(oldstX, oldstY, oldX, oldY);
    //draw new black line
    //strokeWeight(weight+TRACE_OUTLINE_W*2);
    //stroke(BACKG);
    //line(point.x, point.y, X, Y);
    ////draw old line
    //strokeWeight(weight);
    //stroke(GOLD);
    //line(oldstX, oldstY, oldX, oldY);
    
    ////draw new line
    //strokeWeight(weight);
    //stroke(GOLD);
    //line(point.x, point.y, X, Y);
    

  }
}
