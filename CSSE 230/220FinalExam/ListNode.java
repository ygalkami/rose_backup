// You must  not change this file.

public class ListNode<T extends Comparable> {
   T element;
   ListNode<T> next;

   public ListNode(T e, ListNode<T> n) {
      this.element = e;
      this.next = n;      
   }
   
   public ListNode(T e) {
      this(e, null);
   }
   
   public ListNode() {
      this(null, null);
   }
}


