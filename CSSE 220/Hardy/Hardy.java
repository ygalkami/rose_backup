import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;
import java.util.TreeSet;

public class Hardy {
	public static boolean exists(ArrayList<Pair> finallist, int check) {
		for (int i = 0; i < finallist.size(); i++) {
			if (finallist.get(i).cubed == check) {
				return true;
			}
		}
		return false;
	}

	public static void sort(ArrayList<Pair> finallist) {
		int n = finallist.size();
		for (int pass = 1; pass < n; pass++) { 
			for (int i = 0; i < n - pass; i++) {
				if (finallist.get(i).cubed > finallist.get(i + 1).cubed) {
					Pair temp = finallist.get(i);
					finallist.set(i, finallist.get(i + 1));
					finallist.set(i + 1, temp);
				}
			}
		}
	}

	public static void main(String[] args) {
		boolean found = false;
		int nums = 0;
		int matches = 0;
		int N = 10000000;
		ArrayList<Pair> finallist = new ArrayList<Pair>();
		
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		try {
			nums = Integer.parseInt(in.readLine());
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		while (matches < nums) {
			if (matches != 0) 
				N += 50000000;
			for (int a = 1; a <= N; a++) {
				int a3 = a * a * a;
				if (a3 > N)
					break;

				for (int b = a; b <= N; b++) {
					int b3 = b * b * b;
					if (a3 + b3 > N)
						break;

					for (int c = a + 1; c <= N; c++) {
						int c3 = c * c * c;
						if (c3 > a3 + b3)
							break;

						for (int d = c; d <= N; d++) {
							int d3 = d * d * d;
							if (c3 + d3 > a3 + b3)
								break;

							if (c3 + d3 == a3 + b3) {
								if (!exists(finallist, (c3 + d3))) {
									matches++;
									finallist.add(new Pair((c3+d3), a, b, c, d));
									found = true;
									if (matches == nums) {
										break;
									}
								}
								else
									found = false;
							}
						}
					}
				}
			}
		}
		sort(finallist);
		Pair current = finallist.get(nums - 1);
		System.out.println(current.cubed + " = " + current.a + "^3 + " + current.b + "^3 = " + current.c + "^3 + " + current.d + "^3");
	}
}
