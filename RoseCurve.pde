
//配列、三角関数、Roseカーブ

//Roseカーブ　　https://en.wikipedia.org/wiki/Rose_(mathematics)


int numWaves;  //円一周における波の数
int numSamplePts; //一つの波を何個の点で表すか

PVector[] pts; //前のフレームで計算した点を格納するための配列
PVector[] newPts; //今のフレームで計算した点を格納するための配列

PVector centrePt; //円の中心
float radius; //円の半径

float amp; //波の振幅
float ampBase;//波の振幅の基準

float theta; //波の角度

float period; //周期(ミリ秒)

float offset; //振幅を変化させる三角関数のオフセット値

int idShiftForConnect; //どれだけ違うインデックスの点を結び合わせるか

float deltaTheta; //　2pi/要素数
PVector xAxis; //x軸 
PVector xVec; //単位ベクトル 

boolean firstDraw; //最初のDrawの場合のフラグを立てる


void setup(){
  size(800, 800); 
  
  numWaves = 8;
  numSamplePts = 50;
  
  pts = new PVector[numWaves * numSamplePts];
  newPts = new PVector[numWaves * numSamplePts];
  
  //debug
  //null pointer error  メモリの場所がわからない
  //println(pts);
  //noLoop();
  
  centrePt = new PVector(0.5*width, 0.5*height);
  radius = 100;
  
  ampBase = 50;
  amp = ampBase;
  
  theta = 0;
  
  period = 8000; //(ミリ秒)
  
  offset = 3;
  
  idShiftForConnect = 50;
  
  deltaTheta = TWO_PI / (numWaves * numSamplePts);
  
  xAxis = new PVector(1, 0);
  xVec = xAxis.copy();  //xVecにxAxisをコピーする　//xVec =xAxis;ではダメ  

  firstDraw = true;

  //noLoop();

}



void draw(){
  background(30);   
  
  //millis() ミリ秒
  amp = ampBase * (sin(TWO_PI/period * millis()) + offset);
  
  //xVecを初期値に戻す
  xVec = xAxis.copy(); 
  
  for(int i = 0; i < newPts.length; i++){
    
    //半径ベクトルの大きさ
    float r = radius + amp * sin(numWaves * theta );
    
    //半径ベクトルの定義
    PVector rVec = PVector.mult(xVec, r); //mult  xVecのr倍
      
    newPts[i] = PVector.add(centrePt, rVec); //add centrePtにrVecをたす
      
    if(!firstDraw) {     //if(firstDraw==false)
      
      //配列のインデックスを循環させる
      int idPrePt = (i + idShiftForConnect)% pts.length;
      PVector prePt = pts[idPrePt].copy();
      
      stroke(200, 200);
      strokeWeight(0.2);
      line(prePt.x, prePt.y, newPts[i].x, newPts[i].y);
      
      
      
      
    }
    
    
    stroke(255, 200);
    strokeWeight(1);
    ellipse(newPts[i].x, newPts[i].y, 2, 2);
    
    theta += deltaTheta;
    //角度のアップデート
    
    xVec.rotate(deltaTheta);
    
    
  }
  
  //半径ベクトルの角度をリセット
  theta = 0;
  
  //newPtを次のアップデートのために保存する
  for(int i = 0; i < newPts.length; i++){
    pts[i] = newPts[i].copy();
  }
  
  //フラグをリセットする
  //
  //if(firstDraw){
  //  firstDraw = false;
  //}
  if(firstDraw) firstDraw = false;  //１行で書けば、{}の省略可能
  
}

void keyPressed(){
  if(key == 'p'|| key == 'P'){ //printout
    save("img/20221228_roseCurve.png");
  }
}
