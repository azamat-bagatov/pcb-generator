class Trace {
  ArrayList<PVector> points;
  float weight = 0;
  float outline = 2;
  Trace() {
    points = new ArrayList<PVector>();
    createRandom();
    weight = random(1,20);
  }
  
  void createRandom(){
    float x = randomXcentered();
    float y = randomYcentered();
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
    
    
    if(points.size() < 2) return;
    
    for(int i = 1; i < points.size(); i++){
      PVector p1 = points.get(i-1);
      PVector p2 = points.get(i);
      
      //stroke line
      strokeWeight(weight+outline*2);
      stroke(BACKGROUND_COLOR);
      line(p1.x, p1.y, p2.x, p2.y);
      
      //trace line
      strokeWeight(weight);
      stroke(GOLD);
      line(p1.x, p1.y, p2.x, p2.y);
      if(i == 1) {
        stroke(BACKGROUND_COLOR);
        ellipse(points.get(0).x, points.get(0).y, weight*2+outline,weight*2+outline);
        stroke(GOLD);
        ellipse(points.get(0).x, points.get(0).y, weight*2,weight*2);
      }
    }
    stroke(BACKGROUND_COLOR);
    ellipse(points.get(points.size()-1).x, points.get(points.size()-1).y, weight*2+outline,weight*2+outline);
    stroke(GOLD);
    ellipse(points.get(points.size()-1).x, points.get(points.size()-1).y, weight*2,weight*2);
  }

}
