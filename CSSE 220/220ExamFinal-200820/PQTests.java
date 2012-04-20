// For technical reasons, I decided not to give this problem on the exam.
// I left it here for posterity.

import java.util.NoSuchElementException;

import junit.framework.TestCase;


public class PQTests extends TestCase {
   
   static int pointTotal = 0;
   
   public void testEmptyPQ() {
      try {
         PQ<Integer> pq = new PQ<Integer>();
         Integer i = pq.findMin();
         fail("should throw NoSuchElementException");
      } catch(NoSuchElementException e){
         pointTotal += 3;
      }
   }
   
   public void testSingleElementPQ(){
      PQ<Integer> pq = new PQ<Integer>();
      pq.insert(4, 5);
      int i = pq.findMin();
      assertEquals(5, i);
      pq.deleteMin();
      try {
         Integer j = pq.findMin();
         fail("should throw NoSuchElementException");
      } catch(NoSuchElementException e){
         pointTotal += 3;
      }
   }
   
   public void testTwoElementPQ(){
      PQ<Integer> pq = new PQ<Integer>();
      pq.insert(4, 5);
      pq.insert(5, 4);
      int i = pq.findMin();
      assertEquals(5, i);
      pq.deleteMin();
      i = pq.findMin();
      assertEquals(4, i);
      pq.deleteMin();
      try {
         Integer j = pq.findMin();
         fail("should throw NoSuchElementException");
      } catch(NoSuchElementException e){
         pointTotal += 3;
      }
   }
   
   public void testTwoElementPQ2(){
      PQ<Integer> pq = new PQ<Integer>();
      pq.insert(5, 4);
      pq.insert(4, 5);
      int i = pq.findMin();
      assertEquals(5, i);
      pq.deleteMin();
      i = pq.findMin();
      assertEquals(4, i);
      pq.deleteMin();
      try {
         Integer j = pq.findMin();
         fail("should throw NoSuchElementException");
      } catch(NoSuchElementException e){
         pointTotal += 5;
      }
   }
   
   public void testMultiElementPQ(){
      PQ<Integer> pq = new PQ<Integer>();
      pq.insert(5, 4);
      pq.insert(4, 5);
      pq.insert(6, 3);
      pq.insert(6, 12);
      pq.insert(3, 6);
      int i = pq.findMin();
      assertEquals(6, i);
      pq.deleteMin();
      pq.insert(2,7);
      i = pq.findMin();
      assertEquals(7, i);
      pq.deleteMin();
      i = pq.findMin();
      assertEquals(5, i);
      pq.deleteMin();
      i = pq.findMin();
      assertEquals(4, i);
      pq.deleteMin();
      i = pq.findMin();
      assertEquals(3, i);
      pq.deleteMin();
      i = pq.findMin();
      assertEquals(12, i);
      pq.deleteMin();

      try {
         Integer j = pq.findMin();
         fail("should throw NoSuchElementException");
      } catch(NoSuchElementException e){
         pointTotal += 6;
      }
   }
   
   
   public void testTotal() {
      System.out.println("Total points = " + pointTotal);
   }

}
