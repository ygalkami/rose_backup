import junit.framework.TestCase;


public class LinkedListTests extends TestCase {
   
   LinkedList<Integer> list1, list2, list3, list4;
   
   static int totalPoints = 0;

   protected void setUp() throws Exception {
      super.setUp();
      list1 = new LinkedList<Integer>();
      list3 = new LinkedList<Integer>();
      list2 = new LinkedList<Integer>(5);
      list4 = new LinkedList<Integer>();

      list1.add(3);
      list2.add(4);
      list1.add(0, 0);
      list1.add(1, 1);
      list1.add(3, 4);
      list3.add(0, 25);

      // Add some more elements:
      list1.add(20);
      list1.add(25);
      list1.add(30);
      
      for (int i=0; i<15; i++)
         list2.add(i*2%5);
  }
   
   public void testContains1_2_points() {
      assertTrue(list1.contains(1));
      assertFalse(list1.contains(47));
      totalPoints += 3;
   }
   
   public void testContains2_2_points() {
      assertTrue(list1.contains(3));
      assertFalse(list1.contains(467));
      totalPoints += 3;
   }  
   
   public void testContains3_2_points() {
      assertTrue(list1.contains(30));
      assertFalse(list1.contains(4567));
      totalPoints += 3;
   } 
   
   public void testContains4_2_points() {
      assertFalse(list4.contains(3));
      assertTrue(list1.contains(3));
      totalPoints += 3;
   }
   
   public void testRemove1_2_points() {
      assertEquals(new Integer(1),list1.remove(0));
      assertEquals ("[ 0 4 3 20 25 30 ]", list1.toString());
      totalPoints += 4;
   }
  
   public void testRemove2_2_points() {
      assertEquals(new Integer(4),list1.remove(2));
      assertEquals ("[ 1 0 3 20 25 30 ]", list1.toString());
      totalPoints += 4;
   }
   
   public void testRemove3_2_points() {
      assertEquals(new Integer(30),list1.remove(6));
      assertEquals ("[ 1 0 4 3 20 25 ]", list1.toString());
      totalPoints += 4;
   }
   
   public void testRemove4_2_points() {
      try {
         list1.remove(7);
         fail("Should get IndexoutOfBounds");
      } catch (IndexOutOfBoundsException e){
         
      }
      totalPoints += 2;
   }
   
   public void testRemove5_2_points() {
      try {
         list4.remove(7);
         fail("Should get IndexoutOfBounds");
      } catch (IndexOutOfBoundsException e){
         
      }
   }
   
   public void testRemove6_1_point() {
      try {
         list4.remove(-1);
         fail("Should get IndexoutOfBounds");
      } catch (IndexOutOfBoundsException e){
         
      }
      totalPoints += 2;
   }
   
   public void testRemove7_2_points() {
      assertEquals(new Integer(30),list1.remove(6));
      list1.add(5);
      assertEquals ("[ 1 0 4 3 20 25 5 ]", list1.toString());
      totalPoints += 3;
   }
   
   public void testIndexOf1_2_points() {
      assertEquals(0, list1.indexOf(1));
      totalPoints += 2;
   }
   
   public void testIndexOf2_2_points() {
      assertEquals(4, list1.indexOf(20));
      totalPoints += 3;
   }
     
   public void testIndexOf3_2_points() {
      assertEquals(6, list1.indexOf(30));
      totalPoints += 3;
   }
   
   public void testIndexOf4_2_points() {
      assertEquals(-1, list1.indexOf(40));
      totalPoints += 2;
   }
   
   public void testIndexOf5_2_points() {
      assertEquals(-1, list4.indexOf(40));
      totalPoints += 2;
   }
   
   public void testIndexOf6_2_points() {
      assertEquals(6, list2.indexOf(3));
      totalPoints += 2;
   }  
   
   public void testContainsAll1_2_points() {
      list4.add(20); list4.add(30);
      assertTrue(list1.containsAll(list4));
      assertFalse(list4.containsAll(list1));
      totalPoints +=3;
   }
   
   public void testContainsAll2_2_points() {
      list4.add(20); list4.add(460); list4.add(30);
      assertFalse(list1.containsAll(list4));
      assertTrue(list1.containsAll(list3));
      totalPoints +=3;
   }
   
   public void testContainsAll1_3_points() {
      assertTrue(list1.containsAll(list4));
      assertFalse(list4.containsAll(list3));
      totalPoints +=3;
   }
   
 
   
   public void testReverse1_1_point() {
      list4.reverse();
      assertEquals(0, list4.size());
      totalPoints += 1;
   }  
   
   public void testReverse2_2_points() {
      list4.add(7);
      System.out.println(list4);
      list4.reverse();
      System.out.println(list4);
      assertEquals("[ 7 ]", list4.toString());
      totalPoints += 1;
   } 
   
   public void testReverse3_2_points() {
      list4.add(7); list4.add(2);
      list4.reverse();
      assertEquals("[ 2 7 ]", list4.toString());
      totalPoints += 1;
   } 
   
   public void testReverse4_2_points() {
      list4.add(7); list4.add(2); list4.add(6);
      list4.reverse();
      assertEquals("[ 6 2 7 ]", list4.toString());
      totalPoints += 1;
   } 
   
   public void testReverse5_2_points() {
      list4.add(7); list4.add(2); list4.add(6);
      list4.reverse();
      list4.add(10);
      assertEquals("[ 6 2 7 10 ]", list4.toString());
      totalPoints += 2;
   } 
   
   
      
   
   public void testTotal() {
      System.out.println("Total Points: " + totalPoints);
   }

}
