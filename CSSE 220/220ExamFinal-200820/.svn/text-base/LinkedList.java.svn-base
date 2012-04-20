// You must  not change this file.

import java.util.NoSuchElementException;

public class LinkedList<T extends Comparable<T>> {
   protected ListNode<T> header, last;
   
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
   
   public Iterator<T> iterator() {
      return new LinkedListIterator();
   }
   
   // returns true if this list contains e, false otherwise
   public boolean contains(T e) {
      for (ListNode<T> current = header.next; current != null; current = current.next)
          if (current.element.equals(e))
            return true;
      return false;
   }
   
   // If index is a valid position in this list, removes and returns the
   // elemt from that position; otherwise throws an IndexOutOfBoundsException.
   
   public T remove(int index) {
      ListNode<T> current = header;
      if (index < 0)
         throw new IndexOutOfBoundsException();
      try {
         for (int i=0; i<index; i++)
            current = current.next;
         T itemToReturn = current.next.element;
         if (current.next == last)
            last = current;
         current.next = current.next.next;
         return itemToReturn;
      } catch (NullPointerException e){
         throw new IndexOutOfBoundsException();
      }  
   }
   
   // If e is in this list, returns its position; otherwise returns -1.
   public int indexOf(T e) {
      int i = 0;
      try {
         for(ListNode<T> current = header.next;  ! current.element.equals(e); current = current.next)
            i++;
         return i;
      } catch (NullPointerException ex) {
         return -1;
      }
   }
   
   // returns true if this list contains all elements of other, false otherwise
   public boolean containsAll(LinkedList<T> other){
      Iterator<T> otherIterator = other.iterator();
      while (otherIterator.hasNext())
         if (!this.contains(otherIterator.next()))
            return false;
      return true;
   }
    
    // reverses the order of the elements in this list.
    // 5 bonus points if you can do this correctly and your code does not contain
    //   the words "new" or "element"
    public void reverse ( ){
       ListNode<T> current = header.next, prev = null, temp = null;
       if (current != null)
          last = current;
         while (current != null){
          temp = current;
          current = current.next;
          temp.next = prev;
          prev = temp;          
       }
       header.next = temp;   
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

      public T next() {
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
