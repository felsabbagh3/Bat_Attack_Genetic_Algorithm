public class Matrix {
  int[] vec;
  int[] cent;
  int w;
  int h;
  
  public Matrix(int x, int y, int centX, int centY) {
    vec = new int[2];
    cent = new int[2];
    vec[0] = x + centX;
    cent[0] = centX;
    vec[1] = y + centY;
    cent[1] = centY;
  }
  
  public int getIndex(int i) {
    return vec[i];
  }

  public double calculateDist(Obstacle targett) {
    Matrix target = targett.getMidpoint();
    double first = Math.pow(target.getIndex(0) - cent[0], 2);
    double second = Math.pow(target.getIndex(1) - cent[1], 2);
    double sum = first + second;
    return Math.sqrt(  sum  );
  }
  
  public int getCenter(int i) {
    return cent[i];
  }
  
  
    public void addVec(Matrix x) {
    int[] vec2 = {x.getIndex(0), x.getIndex(1)};
    vec[0] = vec[0] + vec2[0];
    cent[0] = cent[0] + vec2[0];
    vec[1] = vec[1] + vec2[1];
    cent[1] = cent[1] + vec2[1];
  }
  
  
   public void rotate(double angle) {
      int x = vec[0] - cent[0];
      int y = vec[1] - cent[1];
      double cosa=Math.cos(angle);
      double sina=Math.sin(angle);
      vec[0]= (int) Math.round(x*cosa - y*sina) + cent[0];
      vec[1]= (int) Math.round(x*sina + y*cosa) + cent[1];
   }
  
}