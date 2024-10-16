//8*4行列で点の座標を持つ
//各列が(x, y, z, 1)
float[][] dots = new float[8][4];

//回転の速さ
float rotv = 0.02f;


//4×4行列を掛けて平行移動、回転
//カメラは常に原点を向く
//座標はすべて右手系
//スクリーンは左上原点なのでdrawfromCameraで中心原点にする(y軸の向きは反転してるけどワールド座標系をそれに合わせることで対応)
//ワールド座標系は立方体の中心が原点になるようにする


color tes = color(#000000, 125);


//カメラ視点からの描画を担う
class drawfromCam {
  //rが原点からの距離、Θがy軸中心、x軸からz軸へに何度回転したか、γがxz平面と位置ベクトルのなす角(-60≦γ≦60、y負側が正)
  //wが画面の幅、hが画面の高さ、lがw * hのスクリーンと視点の距離(ここで倍率をいじるつもり)
  //物体の大きさが全部小さいので最後の描画で全部10倍に拡大
  float r, theta, gamma, w, h, l;
  
  //コンストラクタ
  drawfromCam(float rin, float thetain, float gammain, float win, float hin, float lin) {
    r = rin;
    theta = thetain;
    gamma = gammain;
    w = win;
    h = hin;
    l = lin;
  }
  
  //座標系の変換
  //スクリーンの座標系にまで変える(w * h → 600 * 600、左上中心)
  //縦回転については後で考える
  //とりあえずZ軸負方向からxyの矢印がスクリーンに重なるように見る
  float[] ChangeLocation(float[] Pos) {
    float[] PosReturn = new float[2];
    /*激やばゾーン
    PosReturn[0] = (w / 2) * (Pos[2] * cos(theta) - Pos[0] * sin(theta)) / ((w / 2) * (Pos[2] * sin(theta) + Pos[0] * cos(theta)) * (Pos[2] * sin(theta) + Pos[0] * cos(theta) - r));
    PosReturn[1] = (-2) * Pos[1] / (h * (r - Pos[2] * sin(theta) - Pos[0] * cos(theta)));
    PosReturn[0] = (PosReturn[0] * 300 / (w / 2)) + 300;
    PosReturn[1] = (PosReturn[1] * 300 / (h / 2)) + 300;*/
    
    PosReturn[0] = (l * Pos[0] / (r + Pos[2])) * 300 / (w / 2) + 300;
    PosReturn[1] = (l * Pos[1] / (r + Pos[2])) * 300 / (h / 2) + 300;
    
    return PosReturn;
  }
  
  //実際に描く
  
  //特異点
  void drawdot(float[] Pos) {
    float[] Draw;
    Draw = ChangeLocation(Pos);
    color(#0000ff);
    fill(#00ffff);
    ellipse(Draw[0], Draw[1], 10, 10);
    return;
  }
  //点
  void drawdotPlus(float[] Pos) {
    float[] Draw;
    Draw = ChangeLocation(Pos);
    //color(#ff0000);
    fill(#ff0000);
    ellipse(Draw[0], Draw[1], 10, 10);
    return;
  }
  
  
  //線を引く
  void drawline(float[] Pos0, float[] Pos1) {
    float[] Draw1, Draw2;
    Draw1 = ChangeLocation(Pos0);
    Draw2 = ChangeLocation(Pos1);
    strokeWeight(5);
    stroke(#ffff00);
    
    line(Draw1[0], Draw1[1], Draw2[0], Draw2[1]);
    strokeWeight(0);
    return;
  }
  
  //面を塗る
  void drawSurface(float[] Pos0, float[] Pos1, float[] Pos2, float[] Pos3, color c) {
    float[] Draw1, Draw2, Draw3, Draw4;
    Draw1 = ChangeLocation(Pos0);
    Draw2 = ChangeLocation(Pos1);
    Draw3 = ChangeLocation(Pos2);
    Draw4 = ChangeLocation(Pos3);
    fill(c,125);
    quad(Draw1[0], Draw1[1], Draw2[0], Draw2[1], Draw3[0], Draw3[1], Draw4[0], Draw4[1]);
    return;
  }
  
  //呼び出し用
  void drawall() {
    //点を描く
      for(int i = 0; i < 7; i++) {
        float[] Pos = new float[] {dots[i][0], dots[i][1], dots[i][2], 1};
        drawdotPlus(Pos);
      }
      float[] Pos = new float[] {dots[7][0], dots[7][1], dots[7][2], 1};
      drawdot(Pos);
      
      //線を引く
      drawline(dots[0], dots[1]);
      drawline(dots[0], dots[2]);
      drawline(dots[0], dots[4]);
      drawline(dots[3], dots[1]);
      drawline(dots[3], dots[2]);
      drawline(dots[3], dots[7]);
      drawline(dots[5], dots[1]);
      drawline(dots[5], dots[7]);
      drawline(dots[5], dots[4]);
      drawline(dots[6], dots[7]);
      drawline(dots[6], dots[2]);
      drawline(dots[6], dots[4]);
      
      
      //面を塗る
      drawSurface(dots[0], dots[1], dots[3], dots[2], #00ff00);
      drawSurface(dots[4], dots[5], dots[7], dots[6], #00ffff);
      drawSurface(dots[4], dots[5], dots[1], dots[0], #ffffff);
      drawSurface(dots[2], dots[3], dots[7], dots[6], #0000ff);
      drawSurface(dots[0], dots[2], dots[6], dots[4], #ff0000);
      drawSurface(dots[1], dots[3], dots[7], dots[5], #ff00ff);
      
  }
}

//1ならX軸,2ならY軸,3ならZ軸、負なら逆回転
void RotateBox(int rot) {
  for(int i = 0; i < 8; i++) {
    float[] Pos = {dots[i][0], dots[i][1], dots[i][2], 1};
    if(rot == 1) {
      float[] RetPos = RotateX(Pos, rotv);
      dots[i][0] = RetPos[0];
      dots[i][1] = RetPos[1];
      dots[i][2] = RetPos[2];
    } else if(rot == -1) {
      float[] RetPos = RotateX(Pos, -rotv);
      dots[i][0] = RetPos[0];
      dots[i][1] = RetPos[1];
      dots[i][2] = RetPos[2];
    } else if(rot == 2) {
      float[] RetPos = RotateY(Pos, rotv);
      dots[i][0] = RetPos[0];
      dots[i][1] = RetPos[1];
      dots[i][2] = RetPos[2];
    } else if(rot == -2) {
      float[] RetPos = RotateY(Pos, -rotv);
      dots[i][0] = RetPos[0];
      dots[i][1] = RetPos[1];
      dots[i][2] = RetPos[2];
    } else if(rot == 3) {
      float[] RetPos = RotateZ(Pos, rotv);
      dots[i][0] = RetPos[0];
      dots[i][1] = RetPos[1];
      dots[i][2] = RetPos[2];
    } else if(rot == -3) {
      float[] RetPos = RotateZ(Pos, -rotv);
      dots[i][0] = RetPos[0];
      dots[i][1] = RetPos[1];
      dots[i][2] = RetPos[2];
    }
  }
}

//カメラクラスの初期化
//カメラ側の回転も実装したい
drawfromCam Camera = new drawfromCam(5.0f, 0f, 0f, 2f, 2f, 2f);

void setup() {
  size(600, 600);
  background(0);
  
  //点を置く
  dots[0] = SetPosMat(1, 1, 1);
  dots[1] = SetPosMat(1, 1, -1);
  dots[2] = SetPosMat(1, -1, 1);
  dots[3] = SetPosMat(1, -1, -1);
  dots[4] = SetPosMat(-1, 1, 1);
  dots[5] = SetPosMat(-1, 1, -1);
  dots[6] = SetPosMat(-1, -1, 1);
  dots[7] = SetPosMat(-1, -1, -1);
  //println(dots[0]);
}
void draw() {
  background(0);
  
  //カメラ操作
  //行列での回転と角度の取り方が違うので注意(ChangeLocationみて)
  if(keyPressed) {
    if(key == 'a') {
      Camera.theta -= 0.01;
      //println("Moved!");
    } else if(key == 'd') {
      Camera.theta += 0.01;
      //println("Moved!");
    } else if(key == 'w' && Camera.gamma < 60) {
      Camera.gamma += 10;
    } else if(key == 'a' && Camera.gamma > -60) {
      Camera.gamma -= 10;
    } else if(key == 'z') {
      Camera.l += 0.5f;
    } else if(key == 'x') {
      Camera.l -= 0.5f;
    } else if(keyCode == UP) {
      RotateBox(1);
    } else if(keyCode == DOWN) {
      RotateBox(-1);
    } else if(keyCode == LEFT) {
      RotateBox(2);
    } else if(keyCode == RIGHT) {
      RotateBox(-2);
    } else if(key == 'p') {
      RotateBox(3);
    } else if(keyCode == SHIFT) {
      RotateBox(-3);
    }
  }
  
  //図形を描画
  Camera.drawall();
}


//座標をコンソールに表示
void keyReleased() {
   if(key == 'g') {
      for(int i = 0; i < 8; i++) {
        print("x: " + dots[i][0]);
        print("y: " + dots[i][1]);
        println("z: " + dots[i][2]);
      }
      println();
    }
}


//Z軸中心の回転
//4*1行列を受け取って返す
//軸の正方向から原点を向いて反時計回り(xからyへ)
float[] RotateZ(float[] Pos, float theta) {
 float[][] Rotator = new float[4][4];
 //回転行列
 Rotator[0][0] = cos(theta);
 Rotator[0][1] = (-1) * sin(theta);
 Rotator[1][0] = sin(theta);
 Rotator[1][1] = cos(theta);
 Rotator[2][2] = 1;
 Rotator[3][3] = 1;
 
 float[] AnsPos = MatPos(Rotator, Pos);
 return AnsPos;
}

//X軸中心の回転
//4*1行列を受け取って返す
//軸の正方向から原点を向いて反時計回り
float[] RotateX(float[] Pos, float theta) {
 float[][] Rotator = new float[4][4];
 //回転行列
 Rotator[0][0] = 1;
 Rotator[1][1] = cos(theta);
 Rotator[1][2] = (-1) * sin(theta);
 Rotator[2][1] = sin(theta);
 Rotator[2][2] = cos(theta);
 Rotator[3][3] = 1;
 
 float[] AnsPos = MatPos(Rotator, Pos);
 return AnsPos;
}

//Y軸中心の回転
//4*1行列を受け取って返す
//軸の正方向から原点を向いて反時計回り
float[] RotateY(float[] Pos, float theta) {
 float[][] Rotator = new float[4][4];
 //回転行列
 Rotator[0][0] = cos(theta);
 Rotator[0][2] = sin(theta);
 Rotator[1][1] = 1;
 Rotator[2][0] = (-1) * sin(theta);
 Rotator[2][2] = cos(theta);
 Rotator[3][3] = 1;
 
 float[] AnsPos = MatPos(Rotator, Pos);
 return AnsPos;
}

//座標の平行移動
//4*1行列を受け取って返す
float[] Translation(float[] Pos, float[] Trans) {
  float[][] Translator = new float[4][4];
  //平行移動用の行列
  Translator[0][0] = 1;
  Translator[1][1] = 1;
  Translator[2][2] = 1;
  Translator[3][3] = 1;
  Translator[0][3] = Trans[0];
  Translator[1][3] = Trans[1];
  Translator[2][3] = Trans[2];
  
  float[] AnsPos = MatPos(Translator, Pos);
  return AnsPos;
}


//4*4行列同士の掛け算
float[][] MatMat(float[][] Mat1, float[][] Mat2) {
  float[][] Mat3 = new float[4][4];
  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 4; j++) {
      for(int k = 0; k < 4; k++) {
        Mat3[i][j] += Mat1[i][k] * Mat2[k][j];
      }
    }
  }
  return Mat3;
}


//4*4行列を4*1行列(座標)に掛ける
float[] MatPos(float[][] Mat, float[] PosMat) {
  float[] ResPos = new float[4];
  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 4; j++) {
      ResPos[i] += Mat[i][j] * PosMat[j];
    }
  }
  return ResPos;
}

//(x, y, z)座標を(x, y, z, 1)tにして返す
//カメラ描画以外では基本この形にしてやりとりする
float[] SetPosMat(float x, float y, float z) {
  float[] Mat = new float[] {x, y, z, 1f};
  return Mat;
}
