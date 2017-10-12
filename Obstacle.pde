public class Obstacle {
	int x2;
	int y2;
	int x1;
	int y1;
	int hor;
	int ver;

	public Obstacle(int x2,int y2,int hor,int ver) {
		this.x2 = x2;
		this.y2 = y2;
		this.hor = hor;
		this.ver = ver;
		this.x1 = x2 + hor;
		this.y1 = y2 + ver;
	}

	public void show() {
	  fill(0,255,0);
  	rect(x2,y2,hor,ver);
	}

 public Matrix[] getEdges() {
   Matrix[] mat = new Matrix[2];
   mat[0] = new Matrix(x2,y2,0,0);
   mat[1] = new Matrix(x1,y1,0,0);
   return mat;
 }

 public Matrix getMidpoint() {
 	int x = (x2 + x1) / 2;
 	int y = (y2 + y1) / 2;
 	return new Matrix(x,y,0,0);
 }


}