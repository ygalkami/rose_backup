import java.util.ArrayList;
import java.util.TreeSet;


public class Hardy2 {
	public static boolean exists(ArrayList<Integer> array, int check) {
		for (int i = 0; i < array.size(); i++) {
			if (array.get(i) == check)
				return true;
		}
		return false;
	}
	
	public static void main(String[] args) {
		int N = 10000;
		int num = 5;
		int matches = 0;
		ArrayList<Integer> cubes = new ArrayList<Integer>();
		TreeSet<Integer> finallist = new TreeSet<Integer>();
		while (matches < num) {
			N += 100000;
			for (int i = 1; i < N; i++) {
				int i3 = i * i * i;
				if (i3 > N)
					break;
				for (int j = i; j < N; j++) {
					int j3 = j * j * j;
					if (j3 + i3 > N) 
						break;
					if (exists(cubes, (i3+j3))) {
						matches++;
						if (matches == num)
							break;
						finallist.add((j3+i3));
					}
					else{
						cubes.add((j3 + i3));
					}
				}
			}
		}
		System.out.println(matches);
		System.out.println(cubes);
		System.out.println(finallist);
	}
}
