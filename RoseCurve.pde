
//配列、三角関数、Roseカーブ

//Roseカーブ　　https://en.wikipedia.org/wiki/Rose_(mathematics)


int numWaves;  //円一周における波の数
int numSamplePts; //一つの波を何個の点で表すか

PVector[] pts; //点を格納するための配列

PVector centrePt; //円の中心
float radius; //円の半径

float amp; //波の振幅

float theta; //波の角度

float deltaTheta; //　2pi/要素数
PVector xAxis; //x軸 
PVector xVec; //単位ベクトル 

int counterNumPts; //今何個目の点を計算しているか


void setup(){
  size(800, 600); 
  
  numWaves = 8;
  numSamplePts = 100;
  
  pts = new PVector[numWaves * numSamplePts];
  
  //debug
  //null pointer error  メモリの場所がわからない
  //println(pts);
  //noLoop();
  
  centrePt = new PVector(0.5*width, 0.5*height);
  radius = 200;
  
  amp = 200;
  theta = 0;
  
  deltaTheta = TWO_PI / (numWaves * numSamplePts);
  
  xAxis = new PVector(1, 0);
  xVec = xAxis.copy();  //xVecにxAxisをコピーする　//xVec =xAxis;ではダメ

  counterNumPts = 0;
  


}



void draw(){
  background(30);
  
  //カウンターが箱の要素数より小さかったら、カウンターをアップデートする
  if(counterNumPts < pts.length){
    //カウントのアップデート
    counterNumPts += 1;
  }
  
  //xVecを初期値に戻す
  xVec = xAxis.copy(); 
  
  for(int i = 0; i < counterNumPts; i++){
    
    //半径ベクトルの大きさ
    float r = radius + amp * cos(numWaves * theta );
    
    //配列の中身に要素がなければ計算する
    if(pts[i] == null){
      
      //半径ベクトルの定義
      PVector rVec = PVector.mult(xVec, r); //mult  xVecのr倍
      
      pts[i] = PVector.add(centrePt, rVec); //add centrePtにrVecをたす
      
    }
    
    stroke(255, 200);
    strokeWeight(1);
    ellipse(pts[i].x, pts[i].y, 2, 2);
    
    theta += deltaTheta;
    //角度のアップデート
    
    xVec.rotate(deltaTheta);
    
    
  }
  
    
  theta = 0;
  
}
