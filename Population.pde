import java.util.Random;
import java.util.ArrayList;

public class Population {
	Obstacle target;
	int lenPop;
	int lenDNA;
	int mutRate;
	double totalFitness;
	double maxFitness;
	Random rand = new Random();
	Obstacle[] obstacles;
	int numObstacles;
	double numThere = 0;
	double percentage = 0;

	Rocket[] rockets;
	ArrayList<Rocket> parents;

	public Population(Obstacle target, int lenPop, int mutRate, int lenDNA, Obstacle[] obstacles) {
		this.target = target;
		this.lenPop = lenPop;
		this.lenDNA = lenDNA;
		this.mutRate = mutRate;
		totalFitness = 0;
		maxFitness = 0;
		this.obstacles = obstacles;
		this.numObstacles = obstacles.length;
		rockets = new Rocket[lenPop];
		for (int i = 0; i < lenPop; i++) {
			rockets[i] = new Rocket(target, lenDNA, mutRate);
		}
		parents = new ArrayList<Rocket>();
	}

	public void setMutRate(int mutRate) {
		this.mutRate = mutRate;
		for (int i = 0; i < lenPop; i++) {
			rockets[i].setMutRate(mutRate);
		}
	}

	public void show() {
		for (int i = 0; i < lenPop; i++) {
			rockets[i].show();
		}
	}

	public void calculateFitness() {
		for (int i = 0; i < lenPop; i++) {
			rockets[i].update();
			for (int z = 0; z < numObstacles; z++) {
				rockets[i].checkCollision(obstacles[z]);
			}
			rockets[i].updateFitness();
		}
	}

	public void naturalSelection() {
		makeParents();
		Rocket child;
		Rocket one;
		Rocket two;
		for (int i = 0; i < lenPop; i++) {
			int oneRand = rand.nextInt(parents.size());
			int twoRand = rand.nextInt(parents.size());
			one = parents.get(oneRand);
			two = parents.get(twoRand);
			child = one.crossOver(two);
			
			rockets[i] = child;
		}
	}

	private void makeParents() {
		parents.clear();
		double weight;
		int n;
		for (int i = 0; i < lenPop; i++) {
			if (rockets[i].getDead() && percentage > 18) {
				weight = 0;
			}
			weight = (rockets[i].getFitness() / totalFitness) * 1000;
			n = (int) Math.floor(weight);
			//System.out.printf("Weight: %d\n", n);
			for (int z = 0; z < n; z++) {
				parents.add(rockets[i]);
			}
		}
	}

	public double calculateTotalFitness() {
		totalFitness = 0;
		double totalfit = 0;
		for (int i = 0; i < lenPop; i++) {
			totalfit = totalfit + rockets[i].getFitness();
		}
		totalFitness = totalfit;
		return totalFitness;
	}

	public double calculatePerc() {
		numThere = 0;
		for (int i = 0; i < lenPop; i++) {
			if (rockets[i].getThere()) {
				numThere++;
			}
		}
		percentage = (numThere / lenPop) * 100;
		return (numThere / lenPop);
	}

	public double calculateMaxFitness() {
		maxFitness = 0;
		double maxFit = 0;
		for (int i = 0; i < lenPop; i++) {
			if (maxFit < rockets[i].getFitness()) {
				maxFit = rockets[i].getFitness();
			}
		}
		maxFitness = maxFit;
		return maxFitness;
	}
}