
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


//ウサギ
private float[] Ou = {0, -5, 0};
private float[] utheta = {0, 0, 0};
private float[][] uPoints =  {{3, 3, 0}, {-3, 3, 0}, {0, 3, 3}, {0, 3, -3}, {3, -3, 0}, {-3, -3, 0}, {0, -3, 3}, {0, -3, -3}};
private String[] uPointsColor = {"000000"};
private int[][] usurf = {{0, 3, 1, 2}, {4, 7, 5, 6}};
private String[] usurfColor = {"00ff00"};
object Usagi = new object(Ou, utheta, uPoints, uPointsColor, usurf, usurfColor);



//描画するもののリスト
object[] objectlist = {ground, Player, block, Usagi};
