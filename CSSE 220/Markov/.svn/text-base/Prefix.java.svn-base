
public class Prefix {
	FixedLengthQueue current;
	
	public Prefix (int n) {
		this.current = new FixedLengthQueue(n);
		for (int i = 0; i < n; i++) {
			this.current.add("NONWORD");
		}
	}
	
	public void add(String stringtoadd) {
		this.current.add(stringtoadd);
	}
	
	public FixedLengthQueue getqueue() {
		return this.current;
	}
	
	public String toString() {
		return this.current.toString();
	}
}
