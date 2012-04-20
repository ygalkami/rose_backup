import java.math.BigInteger;
import java.util.Scanner;



public class Facotrial {
	public static final int MAX = 25;
	
	public static BigInteger factorial (int n) {
		BigInteger product = BigInteger.ONE;
		int i;
		for (i=2; i<=n; i++) {
			product = product.multiply(new BigInteger(i + ""));
		}
		return product;
	}
	
	public static void main(String[] args) {
//		Scanner sc = new Scanner(System.in);
//		System.out.print("Eneter a number whose factorial you want: ");
//		int n = sc.nextInt();
//		System.out.println(n + "! = " + factorial(n));
		
		System.out.println(5 + ' ' + 7);
		System.out.println(5 + " " + 7);
	}

}