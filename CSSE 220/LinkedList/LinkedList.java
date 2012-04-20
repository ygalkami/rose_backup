import java.util.NoSuchElementException;


public class LinkedList<T> {
	private ListNode<T> header, last;
	
	public LinkedList() {
		header = last = new ListNode<T>();
	}
	
	public LinkedList(T e) {
		last = new ListNode<T> (e);
		header = new ListNode<T> (null, last);
	}
	
	public boolean add(T e) {
		last = last.next = new ListNode<T>(e);		
		return true;
	}
	
//	public int size() {
//		if (this.first == null) 
//			return 0;
//		else {
//			int counter = 0;
//			ListNode<T> current = this.first;
//			while (current != null) {
//				counter++;
//				current = current.next;
//			}
//			return counter;
//		}
//	}
	
	public int size() {
		return size(header.next);
	}
	
	public int size(ListNode<T> p) {
		return (p == null)? 0 : 1 + size(p.next);
	}
	
	@Override
	public String toString() {
		String result = "[ ";
		for (ListNode<T> p = header.next; p != null; p = p.next) {
			result += (p.element + " ");
		}
		return result + "]";
	}
	
	public void add(int i, T e) throws IndexOutOfBoundsException {
		if (i < 0) {
			throw new IndexOutOfBoundsException("negative index: " + i);
		}
		else {
			ListNode<T> p = this.header;
			for (int pos = 0; pos < i - 1; pos++) {
				p = p.next;
				if (p.next == null) {
					throw new IndexOutOfBoundsException("Index too big: " + i);
				}
			}
			p.next = new ListNode<T>(e, p.next);
			if (p == last) {
				last = p.next;
			}
		}
	}
	
	public boolean remove (T obj) {
		ListNode<T> p = this.header;
		
		for (int i = 0; i < this.size() - 1; i++) {
			p = p.next;
			if (p.next.element.equals(obj)){
				if (p.next == last) {
					last = p;
				}
				p.next = p.next.next;
				return true;
			}
		}
		return false;
	}
	
	public Iterator iterator() {
		return (Iterator) new LinkedListIterator();
	}
	
	public class LinkedListIterator implements Iterator {
		private ListNode<T> current;
		private ListNode<T> previous;
		
		private LinkedListIterator() {
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
			if (previous == null) {
				throw new NoSuchElementException("Cannot remove when no previous element");
			}
			previous.next = previous.next.next;
			if (current == last)
				last = previous;
			current = previous;
			previous = null;
		}
	}
	
}