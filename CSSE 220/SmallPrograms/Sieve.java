
public class Sieve {

	public static boolean isprime(int testint) {
		boolean prime = true;
		for (int i=2; i<testint; i++){
			if (testint % i == 0) {
				prime = false;
				break;
			}
		}
		return prime;
	}
	public static void main(String[] args) {
		int lower = Integer.parseInt(args[0]);
		int upper = Integer.parseInt(args[1]);
		
		if (lower == 1) {
			lower = 2;
		}
			
			for (int i=lower; i<=upper; i++){
				if (isprime(i) == true)
					System.out.print(i + " ");
			}
			System.out.println("\n");

	}

}
