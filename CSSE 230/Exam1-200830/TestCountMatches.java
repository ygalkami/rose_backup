import java.util.HashMap;
import java.util.TreeSet;

import junit.framework.TestCase;

// This tests solutions to Weiss 3rd edition problems 4.29 and 4.30
// And also CSSE 230 Exam 1, Spring, 2008.

public class TestCountMatches extends TestCase {
   
   int[] a = { 3, -5, 0, 7, 3, -8, 0, -7, 6, 0, 2, 4, 1, 3, 0 };
   int [] b = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8};
   
   // Old test cases.  These should already work.
   
   public void testCountmatches1() {
      assertEquals(4, Ex4_29_4_30.countMatches(a, new EqualsZero()));
   }
   
   public void testCountmatches2() {
      assertEquals(8, Ex4_29_4_30.countMatches(a, new IsPositive()));
   }
   
   public void testCountmatches3() {
      assertEquals(3, Ex4_29_4_30.countMatches(a, new EqualsK(3)));
   }
   
   public void testCountmatches4() {
      assertEquals(4, Ex4_29_4_30.countMatches(a, new EqualsK(0)));
   }
   
   // New test cases.  
   // You need to define the two new classes before these will compile or run correctly.
   
   public void testCountmatches5() {
	   HashMap<Integer, Integer> hm = new HashMap<Integer, Integer>();
	   for (int i=0; i<10; i++)
		   hm.put(i, i%4);
	   Matchable m = new MapsTo(hm, 3);
	   assertEquals(4, Ex4_29_4_30.countMatches(b, m));
	   Matchable m2 = new MapsTo(hm, 0);
	   assertEquals(6, Ex4_29_4_30.countMatches(b, m2));
   }
   
   public void testCountmatches6() {
	   int[] intArray = {4, 6, 2, 9, 3};
	   TreeSet<Integer> ts = new TreeSet<Integer>();
	   for (int i=0; i<intArray.length; i++)
		   ts.add(intArray[i]);
	   Matchable m = new MemberOf(ts);
	   assertEquals(6, Ex4_29_4_30.countMatches(a, m));
	   assertEquals(9, Ex4_29_4_30.countMatches(b, m));
   }

}
