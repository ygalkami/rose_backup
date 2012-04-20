import java.util.TreeSet;


public class Tray {
	public TreeSet<Integer> config = new TreeSet<Integer>();	// a set of the hashes for the board
	
	public Tray (Block[] array) {
		// for each block add its individual hash code to the set
		for (Block a : array) {
			if (a != null)
				config.add(this.hashBlock(a));
			else
				break;
		}
	}
	
	public void add (int toadd) {
		// add the hash code to the set
		config.add(toadd);
	}
	
	public int hashBlock(Block current) {
		// calculate the hash code for the block
		int sum = 0;
		int blocksum = 0;
		int prime = 257;
		blocksum += current.col * prime;
		blocksum += current.row;
		blocksum *= prime;
		blocksum += current.height;
		blocksum *= prime;
		blocksum += current.width;
		blocksum *= prime;
//		System.out.println("H: " + current.height + "; W: " + current.width + "; R: " + current.row + "; C: " + current.col + " -> " + blocksum);
		return Math.abs(blocksum);
	}
	
	public boolean contains(int a) {
		// see if the set contains a specific hash code already
		if (config.contains(a))
			return true;
		return false;
	}
	
	public String toString() {
		return config.toString();
	}
}
