/**
 * 
 * @author anderson and (your name)
 *
 * @param <T> Any Comparable type
 * 
 * A linked list whose elements are kept in sorted order.
 */
public class SortedLinkedList<T extends Comparable<T>> extends LinkedList<T>{
   
	protected ListNode header, last;
	
   public SortedLinkedList() {
	   header = last = new ListNode<T>( );
   }
   
   /**
    * Create a sorted list containing the same elements as the parameter
    * 
    * @param list the input list
    */
   public SortedLinkedList(LinkedList<T> list) {
	   	last = list.last;
		header = new ListNode<T> (null, last);
      }
   
   public int size() {
	   return size(header.next);
   }
   
   @Override public String toString() {
	      String result = "[ ";
	      for (ListNode<T> p = header.next; p != null; p = p.next)
	         result += (p.element + " ");
	      return result + "]";
   }
   
   /**
    *  Add this element to the list, keeping the list sorted.
    */
   @Override public boolean add(T elementToAdd){
       int size = this.size();
       int i = 0;
       ListNode<T> current = header.next;
       while(i < size && current.element.compareTo(elementToAdd) < 0){
             current = current.next;
             i++;
       }
       if(i >= size){
             super.add(elementToAdd);
       } else {
             super.add(i + 1, elementToAdd);
       }
       return true;
   }
   
   /**
    * Throw an UnsupportedOperationException, since the list will not stay sorted 
    * if we can add an element in an arbitrary position.
    */
   @Override public void add(int i, T elementToAdd){
	   throw new UnsupportedOperationException("The list will not stay sorted if you try to add an element at an arbitary position");
   }

}
