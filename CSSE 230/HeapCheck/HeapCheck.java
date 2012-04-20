
public class HeapCheck {
	
	// Check to see whether the given array is a (min) heap.
	
	public static boolean heapCheck(int [] a) {
		for (int i = 1; i < a.length; i++) {
			if (a[i] < a[i/2] && (i/2) != 0)
				return false;
//				System.out.print(" here");
//			System.out.println("");
		}
		return true;
	}

}
