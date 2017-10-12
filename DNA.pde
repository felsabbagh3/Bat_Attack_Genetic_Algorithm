import java.util.Random;

public class DNA {

	int lenDNA;
	double[] genes;
	int mutRate;
	Random rand = new Random();

	public DNA(int lenDNA, int mutRate) {
		this.lenDNA = lenDNA;
		this.mutRate = mutRate;
		genes = new double[lenDNA];
		for (int i = 0; i < lenDNA; i++) {
			genes[i] = (rand.nextDouble() * Math.PI / 4) - (Math.PI / 8);
		}
	}

	public DNA(double[] genes, int mutRate) {
		this.genes = genes;
		this.mutRate = mutRate;
		lenDNA = genes.length;
	}

	public double[] getGenes() {
		return genes;
	}

	public void setMutRate(int mutRate) {
		this.mutRate = mutRate;
	}

	public DNA crossOver(DNA wife) {
		double[] newGenes = new double[lenDNA];
		double[] otherGenes = wife.getGenes();
		int mid = rand.nextInt(lenDNA);
		for (int i = 0; i < mid; i++) {
			newGenes[i] = genes[i];
		}
		for (int i = mid; i < lenDNA; i++) {
			newGenes[i] = otherGenes[i];
		}

		for (int i = 0; i < lenDNA; i++) {
			if (rand.nextInt(100) < mutRate) {
				newGenes[i] = (rand.nextDouble() * Math.PI / 4) - (Math.PI / 8);
			}
		}


		return new DNA(newGenes, mutRate);
	}
}