import java.util.NoSuchElementException;

import com.sun.corba.se.impl.naming.cosnaming.NamingUtils;


public class LinkedList<T> {
   private ListNode<T> header, last;
   
   public LinkedList() {
      header = last = new ListNode<T>( );
   }
   
   public LinkedList (T e) {
      last = new ListNode<T>(e);
      header = new ListNode<T>(null, last);
   }
   
   public boolean add(T e){
      last = last.next = new ListNode<T>(e);
      return true;
   }
   
//   public int size() {
//      if (first == null)
//         return 0;
//      else {
//         int count = 0;
//         ListNode<T> current = first;
//         while (current != null){
//            count ++;
//            current = current.next;
//         }
//         return count;
//      }
//   }
   
   public int size() {
      return size(header.next);
   }
   
   public int size(ListNode<T> p) {
      return (p == null)? 0 : 1 + size(p.next);
   }
   
   @Override public String toString() {
      String result = "[ ";
      for (ListNode<T> p = header.next; p != null; p = p.next)
         result += (p.element + " ");
      return result + "]";
   }
   
   public void add(int i, T e){
      if (i<0)
         throw new IndexOutOfBoundsException("negative index: " + i);
      else {
         ListNode<T> p = header;
         for(int pos = 0; pos < i-1; pos++){
            p = p.next;
            if (p.next == null)
               throw new IndexOutOfBoundsException("index too big: " + i);
          }
         p.next = new ListNode<T>(e, p.next);
         if ( p == last)
            last = p.next;
      }
   }
   
   public boolean remove (T obj){
      for(ListNode<T> p= header; p.next != null; p = p.next)
         if (p.next.element.equals(obj)){
            if (p.next==last)
               last = p;
            p.next = p.next.next;
            return true;
         }  
      return false;
   }
   
   public Iterator iterator() {
      return new LinkedListIterator();
   }
   
   // returns true if this list contains e, false otherwise
   public boolean contains(T e) {
	   ListNode<T> p = new ListNode<T>();
	   p = header.next;
	   while (p != null) {
		   if (p.element.equals(e))
				   return true;
		   p = p.next;
	   }
      return false;
   }
   
   // If index is a valid position in this list, removes and returns the
   // elemt from that position; otherwise throws an IndexOutOfBoundsException.
   
   public T remove(int index) {
	   ListNode<T> p = header;
	   int count = 0;
	   ListNode<T> r = p;
      if (index < this.size() && index > -1) {
    	  while(p != null) {
    		  if (count == index) {
    			  if (p.equals(header)) {
    				  r = p.next;
    				  header = p.next;
    			  }
    			  else if (count == this.size() - 1) {
    				  r = p.next;
    				  p.next = null;
    				  last = p;
    			  }
    			  else {
    				  r = p.next;
    				  p.next = p.next.next;
    			  }
//    			  System.out.println(this.toString());
    			  return r.element;
    		  }
    		  count++;
    		  p = p.next;
    	  }
      }
      else {
    	  throw new IndexOutOfBoundsException("Index does not exist");
      }
      return null;
   }
   
   // If e is in this list, returns its position; otherwise returns -1.
   public int indexOf(T e) {
      ListNode<T> p = header.next;
      int count = 0;
      while (p != null && this.size() != 0) {
    	  if (p.element == e) {
    		  return count;
    	  }
    	  p = p.next;
    	  count++;
      }
      return -1;
   }
   
   // returns true if this list contains all elements of other, false otherwise
   public boolean containsAll(LinkedList<T> other){
      int count = 0;
      ListNode<T> p = other.header;
      while (p != null) {
    	  if (this.contains(p.element))
    			  count++;
    	  p = p.next;
      }
      if (count == other.size())
    	  return true;
      else
    	  return false;
   }
    
    // reverses the order of the elements in this list.
    // 5 bonus points if you can do this correctly and your code does not contain
    //   the words "new" or "element"
    public void reverse ( ){
    	ListNode<T> p = this.header;
    	while (p != null && this.size()!= 0) {
    		this.add(0, p.element);
    		p = p.next;
    	}
    	System.out.println("2 " + this.toString());
    }
   
   // Begin the LinkedListIterator inner class
   
   public class LinkedListIterator implements Iterator{
      
      private ListNode<T> current, previous;
      
      private LinkedListIterator(){
         current = header;
      }

      public boolean hasNext() {
         return current.next != null;
      }

      public Object next() {
         previous = current;
         current = current.next;
         return current.element;
      }

      public void remove() {
         if (previous == null)
            throw new NoSuchElementException("cannot remove when no previous");
         previous.next = previous.next.next;
         if (current == last)
            last = previous;
         current = previous;
         previous = null;         
      }
   }
   

}
