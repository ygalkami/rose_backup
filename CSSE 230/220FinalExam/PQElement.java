/**
 * An element of a Priority Queue
 * You should not change this file at all.
 */ 
public class PQElement<T> implements Comparable<PQElement<T>>{
   
   private int priority;
   private T element;
   
   public PQElement(int pri, T elt) {
      this.priority = pri;
      this.element = elt;
   }
   
   int getPriority() {
      return this.priority;
   }
   
   
   T getElement() {
      return this.element;
   }
   
   /**
    * Compare first by priority, and then by element.
    */
   public int compareTo(PQElement<T> other){
      if (this.priority == other.priority)
         if (this.element.equals(other.element))
           return 0;
         else return 1;
      return this.priority - other.priority;
   }
   
   /**
    * Create a string representing this PQElement.
    */
   public String toString( ) {
      return "(" + this.priority + ", " + this.element + ")";
   }
}
