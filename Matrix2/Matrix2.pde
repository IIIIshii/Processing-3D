//各オブジェクトのインスタンスを生成

//線を引くやつも実装する

//地面
private float[] Og = {0, 0, 0};
private float[] gtheta = {0, 0, 0};
private float[][] gPoints =  {{15, 0, 0}, {-15, 0, 0}, {0, 0, 15}, {0, 0, -15}};
private String[] gPointsColor = {"000000"};
private int[][] gsurf = {{0, 1, 2, 3}};
private String[] gsurfColor = {"000000"};
Object ground = new Object(Og, gtheta, gPoints, gPointsColor, gsurf, gsurfColor);



//プレーヤー
private float[] Op = {0, -10, 0};
private float[] ptheta = {0, 0, 0};
private float[][] pPoints =  {{5, 0, 0}, {-5, 0, 0}, {0, 0, 5}, {0, 0, -5}, {5, -10, 0}, {-5, -10, 0}, {0, -10, 5}, {0, -10, -5}};
private String[] pPointsColor = {"000000"};
private int[][] psurf = {{0, 1, 2, 3}};
private String[] psurfColor = {"000000"};
Object Player = new Object(Op, ptheta, pPoints, pPointsColor, psurf, psurfColor);


float[] Vcalc(float[] A, float[] B, float C) {
  if(A.length != B.length) {
    println("Err in Vcalc");
  }
  for(int i = 0; i < A.length; i++) {
    A[i] += C * B[i];
  }
  return A;
}



//8*4行列で点の座標を持つ
//各列が(x, y, z, 1)
//float[][] dots = new float[8][4];

//回転の速さ
//float rotv = 0.02f;




//4×4行列を掛けて平行移動、回転
//カメラは常に原点を向く
//座標はすべて右手系
//スクリーンは左上原点なのでdrawfromCameraで中心原点にする(y軸の向きは反転してるけどワールド座標系をそれに合わせることで対応)
//ワールド座標系は立方体の中心が原点になるようにする


//color tes = color(#000000, 125);
