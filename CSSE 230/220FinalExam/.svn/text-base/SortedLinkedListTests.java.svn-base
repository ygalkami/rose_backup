// You must  not change this file.

import junit.framework.TestCase;


public class SortedLinkedListTests extends TestCase {
   
   static int totalPoints = 0;

   
   public void testConstructor() {
      SortedLinkedList<Integer> list = new SortedLinkedList<Integer>();
      assertEquals("[ ]", list.toString());
      totalPoints += 2;
   }
   
   public void testAdd1() {
      SortedLinkedList<Integer> list = new SortedLinkedList<Integer>();
      list.add(10);
      assertEquals("[ 10 ]", list.toString());
      totalPoints += 3;
   }
   
    
   public void testAdd2() {
      SortedLinkedList<Integer> list = new SortedLinkedList<Integer>();
      list.add(20);
      list.add(10);
      assertEquals("[ 10 20 ]", list.toString());
      totalPoints += 4;
   }

   public void testAdd3() {
      SortedLinkedList<Integer> list = new SortedLinkedList<Integer>();
      list.add(10);
      list.add(5);
      list.add(20);
      assertEquals("[ 5 10 20 ]", list.toString());
      totalPoints += 4;
   }
   
   public void testListConstructor() {
      LinkedList<Integer> list = new LinkedList<Integer>();
      list.add(10);
      list.add(5);
      list.add(20);
      list.add(7);
      list.add(25);
      list.add(18);
      list.add(19);
      list.remove(new Integer(7));
      SortedLinkedList<Integer> sortedList = new SortedLinkedList<Integer>(list);
      assertEquals("[ 5 10 18 19 20 25 ]", sortedList.toString());
      totalPoints += 5;
   }
   
   public void testIllegalAdd() {
      SortedLinkedList<Integer> list = new SortedLinkedList<Integer>();
      list.add(10);
      try {
         list.add(1, 10);
         fail("Should get UnsupportedOperationException");
      } catch (UnsupportedOperationException e){
        totalPoints += 2;
      }
   }
   
   public void testTotal() {
      System.out.println("Total points = " + totalPoints);
   }
}
   

   
 