// This was not a Final Exam problem;  it is here for the purpose of having you practice with turnin on AFS.

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Scanner;

/* Solution to Hardy's Taxi Problem CSSE 220.  September, 2007.
 * HashSet version.
 */

public class Hardy {
	
	// A triple represents a, b, and a^3 + b^3.
	static class Triple implements Comparable<Triple> {
		long cubeSum; // a^3 + b^3
		int n1, n2;   // a and b
		
		public Triple (int a, int b) {
			this.cubeSum = getCube(a) + getCube(b);
			this.n1 = a;
			this.n2 = b;
		}
		
		public boolean equals(Object other) {
			return other != null && ((Triple)other).cubeSum == this.cubeSum;
		}
      
      public int compareTo(Triple other){
         long diff = this.cubeSum - other.cubeSum;
         return ( diff < 0)? -1 : ((diff == cubeSum) ? 0 : 1);
      }
      
      @Override public int hashCode() {
         return (new Long(cubeSum)).hashCode();
      }
      
      @Override public String toString() {
         return String.format("<%s,%s,%s>", cubeSum, n1, n2);
      }
	}
	
	public static  int MAX_DUPLICATES;
	
	// CubeSums we have found so far.
	public static HashMap<Long,Triple> sumMap = new HashMap<Long,Triple>();
	
   // Cube cache, so we dopn't have to recompute the same cubes.
	public static ArrayList<Long> cubes = new ArrayList<Long>();  
	
   // list of already-found solutions.
	public static ArrayList<Triple> duplicates = new ArrayList<Triple>(); 

	public static int duplicateCount=0;  // This was called N in the problem statement. 
	
   // If we have seen this cube before, look it up.
   // If not, cache it.
	public static long getCube(int n) {
		if (n < cubes.size()) 
			return cubes.get(n);
		long longN = (long)n;
		long longCube = longN * longN * longN;
		cubes.add(longCube);
		return longCube;
	}
	
	public static void main(String[] args) {
		
		int a, b = 0;  // The numbers whose cubes we will add.
        Scanner scanner = new Scanner(System.in);
        MAX_DUPLICATES = scanner.nextInt();
        
        /* Go systematically through pairs of numbers a <= b,
         * computing and storing the sum of their cubes.
         * When we find one, see if that sum has been previously found.
         * If so, and not already in duplicates list, add it.
         */
      long stoppingPoint = Long.MAX_VALUE; // initially infinite.
      long max = Long.MAX_VALUE;           //  until we find N solutions.
       
       /* When we have found N Hardy numbers, they may not be the N smallest solutions, 
       * so we keep looking, but then we can limit the values of a and b.  
       * The Nth Hardy number will be no larger than max, the largest of the
       * first N that we found.  And the b whose cube contributes to the Nth
       * cube sum cannot be larger than the square root of max.  So once we 
       * find max, we set stoppingPoint to be that square root.  
       */
      
       while (b  < stoppingPoint){
         a = 0;
			while (a <= b) {
				Triple triple = new Triple(a, b);
            if (triple.cubeSum > max)
               break;
				if (sumMap.get(triple.cubeSum) == null){ // It is a new sum that we have not seen before.
                   sumMap.put(triple.cubeSum, triple);
            }
				else {
					if (!duplicates.contains(triple)){
						duplicates.add(triple);
						duplicateCount ++;
                  if (duplicateCount == MAX_DUPLICATES) {
                      max = Collections.max(duplicates).cubeSum;
                      stoppingPoint = integerCubeRoot(max);
                   }
					}
				}
				a++;
			}
			b++;
		}
     Collections.sort(duplicates);
     Triple triple = duplicates.get(MAX_DUPLICATES - 1 );
     Triple other = sumMap.get(triple.cubeSum);
     System.out.println(triple.cubeSum + " = " + triple.n1 + "^3 + " + triple.n2 + "^3 = " + 
             other.n1 + "^3 + " + other.n2 + "^3");
	}
	
   
	private static long integerCubeRoot(long n) {
	 long trial = 1;
		while (trial * trial * trial < n)
				trial++;
		return trial;
	}

}

