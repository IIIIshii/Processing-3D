//各オブジェクトのインスタンスを生成

//線を引くやつも実装する

//地面
private float[] Og = {0, 0, 0};
private float[] gtheta = {0, 0, 0};
private float[][] gPoints =  {{15, 0, 0}, {-15, 0, 0}, {0, 0, 15}, {0, 0, -15}};
private String[] gPointsColor = {"000000"};
private int[][] gsurf = {{0, 2, 1, 3}};
private String[] gsurfColor = {"000000"};
object ground = new object(Og, gtheta, gPoints, gPointsColor, gsurf, gsurfColor);

//直方体
private float[] Ob = {0, -3, 0};
private float[] btheta = {0, 0, 0};
private float[][] bPoints =  {{4 + 2, 0, 4 + 2}, {4 + -2, 0, 4 + 2}, {4 + -2, 0, 4 + -2}, {4 + 2, 0, 4 + -2}, {4 + 2, -6, 4 + 2}, {4 + -2, -6, 4 + 2}, {4 + -2, -6, 4 + -2}, {4 + 2, -6, 4 + -2}};
private String[] bPointsColor = {"00ffff"};
private int[][] bsurf = {{0, 1, 2, 3}, {4, 5, 6, 7}};
private String[] bsurfColor = {"ff00ff"};
object block = new object(Ob, btheta, bPoints, bPointsColor, bsurf, bsurfColor);

//プレーヤー
private float[] Op = {0, -15, 0};
private float[] ptheta = {0, 0, 0};
private float[][] pPoints =  {{5, 5, 0}, {-5, 5, 0}, {0, 5, 5}, {0, 5, -5}, {5, -5, 0}, {-5, -5, 0}, {0, -5, 5}, {0, -5, -5}};
private String[] pPointsColor = {"000000"};
private int[][] psurf = {{0, 3, 1, 2}, {4, 7, 5, 6}};
private String[] psurfColor = {"00ff00"};
object Player = new object(Op, ptheta, pPoints, pPointsColor, psurf, psurfColor);


float[] Vcalc(float[] A, float[] B, float C) {
  float[] D = new float[A.length];
  if(A.length != B.length) {
    println("Err in Vcalc");
  }
  for(int i = 0; i < A.length; i++) {
    D[i] += A[i] + C * B[i];
  }
  return D;
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
