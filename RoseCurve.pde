
int numWaves;  //number of waves per a circle
int numSamplePts; //points per a wave

PVector[] pts; //array for points
PVector[] newPts; //array for new points

PVector centrePt; //center of circle
float radius; 

float amp; 
float ampBase;

float theta; //angle of a wave

float period; //millisecond

float offset; //for change of amplitude

int idShiftForConnect; //difference of index

float deltaTheta; //2pi/要素数
PVector xAxis;
PVector xVec; //unit vector

boolean firstDrawFlg;


void setup(){
  size(800, 800); 
  
  numWaves = 4;
  numSamplePts = 200;
  
  pts = new PVector[numWaves * numSamplePts];
  newPts = new PVector[numWaves * numSamplePts];
  
  centrePt = new PVector(0.5*width, 0.5*height);
  radius = 100;
  
  ampBase = 50;
  amp = ampBase;
  
  theta = 0;
  
  period = 8000; //(millisecond)
  
  offset = 3;
  
  idShiftForConnect = 50;
  
  deltaTheta = TWO_PI / (numWaves * numSamplePts);
  
  xAxis = new PVector(1, 0);
  xVec = xAxis.copy(); 

  firstDrawFlg = true;

}


void draw(){
  background(30);
  
  amp = ampBase * (sin(TWO_PI/period * millis()) + offset); //millis() millisecond
  
  xVec = xAxis.copy();  //initialize xAxis
  
  for(int i = 0; i < newPts.length; i++){
    
    float r = radius + amp * sin(numWaves * theta ); //the size of radius vector
    
    PVector rVec = PVector.mult(xVec, r); //definition of radius vector
      
    newPts[i] = PVector.add(centrePt, rVec);
      
    if(!firstDrawFlg) {
      
      int idPrePt = (i + idShiftForConnect)% pts.length; //iterate index of the array
      PVector prePt = pts[idPrePt].copy();
      
      stroke(200, 200);
      strokeWeight(0.2);
      line(prePt.x, prePt.y, newPts[i].x, newPts[i].y);
      
    }
    
    stroke(255, 200);
    strokeWeight(1);
    ellipse(newPts[i].x, newPts[i].y, 2, 2);
    
    theta += deltaTheta; //update of angle
    
    xVec.rotate(deltaTheta);
    
  }
  
  theta = 0; //reset of radius vector
  
  for(int i = 0; i < newPts.length; i++){     //save newPt for next update
    pts[i] = newPts[i].copy();
  }
  
  if(firstDrawFlg) firstDrawFlg = false;  //reset flag
  
}

void keyPressed(){
  if(key == 'p'|| key == 'P'){ //printout
    save("img/20221228_roseCurve_1.png");
  }
}
