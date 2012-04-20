import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;


public class Powers {
	public static int power(int X, int N) {
		int test = 0;
		int squared = 1;
		int base = 0;
		ArrayList<Integer> powers = new ArrayList<Integer>();
		
		while (N > 0) {
			
			if (N % 2 == 1)
				squared = squared * base;
			base = base * base;
			N = N / 2;
		}
		
		System.out.println(squared);
	}
}
