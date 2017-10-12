/**
 * Vertices 
 * by Simon Greenwold.
 * 
 * Draw a cylinder centered on the y-axis, going down 
 * from y=0 to y=height. The radius at the top can be 
 * different from the radius at the bottom, and the 
 * number of sides drawn is variable.
 */
int h = 700;
int w = 700;

Obstacle target;
int lenPop;
int lenDNA;
int mutRate;
int ty = 100;
int tx = 350;
Population population;
double totalFit;
double maxFit;

int startTime;
int duration;
Obstacle[] obstacle;
int numObstacles;
int generation;
double perPop;

void setup() {
  
  target = new Obstacle(340,40,20,20);
  lenPop = 1000;
  lenDNA = 700;
  mutRate = 1;
  duration = 7000;
  startTime = millis();
  numObstacles = 5;
  obstacle = new Obstacle[numObstacles];
  obstacle[0] = new Obstacle(300,350,450,20);
  obstacle[1] = new Obstacle(0,350, 200, 20);
  obstacle[2] = new Obstacle(500, 150,250, 20);
  obstacle[3] = new Obstacle(0,150,400,20);
  obstacle[4] = new Obstacle(0,550,400,20);
  //obstacle[0] = new Obstacle(200,350,300,20);
  population = new Population(target, lenPop, mutRate, lenDNA, obstacle);
  generation = 1;
  size(700, 700, P2D);
}

void draw() {
  background(155);
  target.show();
  
  for (int i = 0; i < numObstacles; i++) {
    obstacle[i].show();
  }

  if ((millis() - startTime) <= duration) {
    population.calculateFitness();
  } else {
    System.out.printf("Generation: %d\n", generation);
    System.out.printf("mutRate: %d\n", mutRate);
    perPop = population.calculatePerc();
    System.out.printf("perPop: %f\n", perPop * 100);
    maxFit = population.calculateMaxFitness();
    totalFit = population.calculateTotalFitness();
    System.out.printf("maxFit: %f \ntotalFit: %f \n\n\n", maxFit, totalFit);

    if ((perPop * 100) > 18) {
      population.setMutRate(0);
      mutRate = 0;
    } else {
      mutRate = 1;
      population.setMutRate(1);
    }

    population.naturalSelection();
    startTime = millis();
    
    generation++;
  }
}