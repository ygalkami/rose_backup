/* 
 * Add to this comment your answers the questions posed in the problem statement
 * 
 * a) If they are equal you return 0 instead of 1.
 * 
 * b) You don't test to see if they are the same element.
 * 
 */


import java.util.NoSuchElementException;
import java.util.TreeSet;

public class PQ<T> {
   
   // You are not allowed to change this instance variable or add any
   // additional instance variables.
   private TreeSet<PQElement<T>> treeSet;
   
   public PQ() {
	   treeSet = new TreeSet<PQElement<T>>();
   }
   
   // Return an element with the smallest priority
   public T findMin() {
//	  System.out.println("find min " + treeSet + " " + treeSet.first().getElement());
	  if (treeSet.isEmpty()) {
		  throw new NoSuchElementException("There are no elements in the queue");
	  }
      return (T) treeSet.first().getElement();		  
   }
   
   // delete the minimum-priority element.
   public void deleteMin(){
	   treeSet.remove(treeSet.first());
	   if (treeSet.size() == 0) {
		   this.treeSet = new TreeSet<PQElement<T>>();
	   }
   }
   
   // Insert an element with the given priority.
   public void insert(int priority, T element) {
      if (treeSet.isEmpty())  {
    	  treeSet.add(new PQElement(priority, element));
      }
      else {
    	  System.out.println(treeSet + " " + priority + " " + element);
	      for (PQElement PQ : treeSet) {
	    	  if (PQ.compareTo(new PQElement(priority, element)) == 0) {
	    		  treeSet.add(new PQElement(priority, element));
	    	  }
	    	  if (PQ.compareTo(treeSet.last()) == 0) {
	    		  treeSet.add(new PQElement(priority, element));
	    	  }
	      }
      }
   }
   
   public int size() {
	   return treeSet.size();
   }
   
   
   
   
   

}