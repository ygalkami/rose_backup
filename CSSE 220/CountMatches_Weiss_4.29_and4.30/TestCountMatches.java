import junit.framework.TestCase;

// This tests solutions to Weiss 3rd editionh problems 4.29 and 4.30

public class TestCountMatches extends TestCase {
   
   int[] a = { 3, -5, 0, 7, 3, -8, 0, -7, 6, 0, 2, 4, 1, 3, 0 };
   
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

}
