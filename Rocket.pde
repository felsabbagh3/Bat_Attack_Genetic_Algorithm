import java.util.Random;
public class Rocket {
  Random rand = new Random();
  double ar = 4.1617914502878;
  Matrix p1 = new Matrix(- 10, (int) ar, w/2, 11*h/12);
  Matrix p2 = new Matrix(10, (int) ar, w/2, 11*h/12);
  Matrix p3 = new Matrix(0, (int) -ar, w/2, 11*h/12);
  Matrix movVec = new Matrix(0,-3, 0,0);
  double fitness;
  boolean dead;
  boolean there;


  int count;
  int prev;
  int mutRate;
  DNA dna;
  Obstacle target;
  int lenDNA;
  public Rocket(Obstacle target, int lenDNA, int mutRate) {
    dead = false;
    there = false;
    fitness = 0;
    count = 0;
    this.target = target;
    this.lenDNA = lenDNA;
    this.mutRate = mutRate;

    dna = new DNA(lenDNA, mutRate);

  }

  public void setMutRate(int mutRate) {
    this.mutRate = mutRate;
    dna.setMutRate(mutRate);
  }

  public Rocket(DNA dna, Obstacle target, int mutRate) {
    dead = false;
    there = false;
    fitness = 0;
    count = 0;
    this.dna = dna;
    this.target = target;
    this.mutRate = mutRate;
  }
  
  public void show() {
      fill(0);
      noStroke();
      triangle(p1.getIndex(0), p1.getIndex(1), p2.getIndex(0), p2.getIndex(1), p3.getIndex(0), p3.getIndex(1));
  }
  
  public void update() {
    if (!dead) {
      rotate();
      count++;
      prev = millis();
      count++;
      p1.addVec(movVec);
      p2.addVec(movVec);
      p3.addVec(movVec);
    }
    this.isOut();
    this.isThere();
    this.show();
  }

  public DNA getDNA() {
    return dna;
  }

  public Rocket crossOver(Rocket wife) {
    DNA childDNA = dna.crossOver(wife.getDNA());
    return new Rocket(childDNA, target, mutRate);
  }

  public void isThere() {
    Matrix[] edges = target.getEdges();
    Matrix topLeft = edges[0];
    Matrix bottomRight = edges[1];
    int currX = p1.getCenter(0);
    int currY = p1.getCenter(1);
    if ((currX > topLeft.getIndex(0)) && (currX < bottomRight.getIndex(0))
            && (currY > topLeft.getIndex(1)) && (currY < bottomRight.getIndex(1))) {
      dead = true;
      there = true;
    }
  }

  public boolean getThere() {
    return there;
  }

  public void isOut() {
    if ((p1.getCenter(0) > 700) || (p1.getCenter(0) < 0) || (p1.getCenter(1) > 700) || (p1.getCenter(1) < 0)) {
      dead = true;
    }
  }

  public boolean getDead() {
    return dead;
  }

  public void checkCollision(Obstacle ob) {
    Matrix[] edges = ob.getEdges();
    Matrix topLeft = edges[0];
    Matrix bottomRight = edges[1];
    int currX = p1.getCenter(0);
    int currY = p1.getCenter(1);
    if ((currX > topLeft.getIndex(0)) && (currX < bottomRight.getIndex(0))
            && (currY > topLeft.getIndex(1)) && (currY < bottomRight.getIndex(1))) {
      dead = true;
    }
  }

  public void updateFitness() {
    if (!this.getThere()) {
      double dist = p1.calculateDist(target);
      if (dist < 1) dist = 0.5;
      fitness = ((1 / dist) * 100);
      fitness = Math.pow(fitness, 2);
      //fitness = Math.pow(2, fitness);
    } else {
      fitness = 1000;
    }
  }

  public double getFitness() {
    return fitness;
  }

  public void rotate() {
    if (count < dna.getGenes().length) {
      double angle = dna.getGenes()[count];
      //double angle = genes[count];
      movVec.rotate(angle);
      p1.rotate(angle);
      p2.rotate(angle);
      p3.rotate(angle);
    }
  }
  
  
}