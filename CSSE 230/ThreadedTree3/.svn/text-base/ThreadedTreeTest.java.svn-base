import java.util.ArrayList;
import java.util.Collections;
import java.util.StringTokenizer;

import junit.framework.TestCase;


public class ThreadedTreeTest extends TestCase {
	
	
	String s1, s2, s3;
	
	ThreadedBinarySearchTree<String> t1, t2, t3;
	
	ArrayList<String> list1, list2, list3;

	protected void setUp() throws Exception {
		super.setUp();
		s1 = "a recursive method is a method that either directly " +
	    "or indirectly makes a call to itself";
	    t1 = buildTree(s1);
	    list1 = toArrayList(s1);
	    Collections.sort(list1);


		s2 = "Now is the time for all good men to come to the "
				+ "aid of their country";
		t2 = buildTree(s2);
	    list2 = toArrayList(s2);
	    Collections.sort(list2);

		s3 = "It is in vain, sir, to extenuate the matter. "
				+ "Gentlemen may cry, Peace, Peace--but there is no peace. "
				+ "The war is actually begun! The next gale that sweeps from "
				+ "the north will bring to our ears the clash of resounding "
				+ "arms! Our brethren are already in the field! Why stand we "
				+ "here idle? What is it that gentlemen wish? What would they "
				+ "have? Is life so dear, or peace so sweet, as to be purchased "
				+ "at the price of chains and slavery? Forbid it, Almighty God! I "
				+ "know not what course others may take; but as for me, give me "
				+ "liberty or give me death!  -- Patrick Henry";
		t3 = buildTree(s3);
	    list3 = toArrayList(s3);
	    Collections.sort(list3);

	}
	
	public ThreadedBinarySearchTree<String> buildTree(String s) {

		StringTokenizer st = new StringTokenizer(s, " ");
		ThreadedBinarySearchTree<String> t = new ThreadedBinarySearchTree<String>();
		String current = null;
		for (; st.hasMoreTokens();) {
			current = st.nextToken();
			try {
				if (current != null)
					t.insert(current);
			} catch (DuplicateItem e) {
				//System.out.println("duplicate item " + current);
			}
		}
		return t;
	}
	
	public ArrayList<String> toArrayList(String s) {
		ArrayList<String> list = new ArrayList<String>();
		StringTokenizer st = new StringTokenizer(s, " ");
		for (; st.hasMoreTokens();){ 
			String current = st.nextToken();
		    if (!(list.contains(current)))
		    	list.add(current);
		}
		return list;
	}
	
	 private ThreadedBinaryNode<String> find(String x, ThreadedBinaryNode<String> t)
	    throws ItemNotFound   {
	    if (x.compareTo(t.element) < 0)
	      if(t.isLeftThread)
	        throw new ItemNotFound("Item " + x + "  not found");
	      else
	        return find(x, t.left);
	    else if (x.compareTo(t.element) > 0)
	      if(t.isRightThread)
	        throw new ItemNotFound("Item " + x + " not found");
	      else
	        return find(x, t.right);
	    else
	      return t;
	  }
	 
	public void testTree1a () {
		System.out.println ("T1 forward:");
		t1.traverseInOrder();
		System.out.println ("T1 backward:");
		t1.traverseInOrderBackwards();
		ThreadedBinaryNode<String> n = find("makes", t1.root);

		assertEquals("method", n.inOrderSuccessor().element);
		assertEquals("itself", n.inOrderPredecessor().element);
		assertEquals("or", n.inOrderSuccessor().inOrderSuccessor().element);
		assertEquals("is", n.inOrderPredecessor().inOrderPredecessor().element);
		assertEquals("recursive", n.inOrderSuccessor().inOrderSuccessor().inOrderSuccessor().element);
		assertEquals("indirectly", n.inOrderPredecessor().inOrderPredecessor().inOrderPredecessor().element);
	}
	
	public void testTree1b() {
		ThreadedBinaryNode<String> n = t1.firstInOrderNode();
		ThreadedBinaryNode<String> next;
		int count = 0;
		while (n != null) {
			// System.out.print((count++)+" "+list1.get(count)+" ");
			assertEquals(list1.get(count++), n.element);
			next = n.inOrderSuccessor();
			if (next != null)
				assertEquals(n, next.inOrderPredecessor());
			n = next;
		}
		assertEquals(count, list1.size());
	}
	
	// This one is only here so you can see all of the nodes of the tree.
	public void testTree2a () {
		System.out.println ("T2 forward:");
		t2.traverseInOrder();
		System.out.println ("T2 backward:");
		t2.traverseInOrderBackwards();
	}


	public void testTree2b() {
		ThreadedBinaryNode<String> n = t2.firstInOrderNode();
		ThreadedBinaryNode<String> next;
		int count = 0;
		while (n != null) {
			// System.out.print((count++)+" "+list2.get(count)+" ");
			assertEquals(list2.get(count++), n.element);
			next = n.inOrderSuccessor();
			if (next != null)
				assertEquals(n, next.inOrderPredecessor());
			n = next;
		}
		assertEquals(count, list2.size());
	}

	public void testTree3a () {
		System.out.println ("T3 forward:");
		t3.traverseInOrder();
		System.out.println ("T3 backward:");
		t3.traverseInOrderBackwards();
	}


	public void testTree3b() {
		ThreadedBinaryNode<String> n = t3.firstInOrderNode();
		ThreadedBinaryNode<String> next;
		int count = 0;
		while (n != null) {
			// System.out.print((count++)+" "+list3.get(count)+" ");
			assertEquals(list3.get(count++), n.element);
			next = n.inOrderSuccessor();
			if (next != null)
				assertEquals(n, next.inOrderPredecessor());
			n = next;
		}
		assertEquals(count, list3.size());
	}
	
	public void testParent1() {
		ThreadedBinaryNode<String> n = t1.firstInOrderNode();
		int count = 0;
		while (n != null) {
			count++;
			if (n== t1.root)
				assertNull(n.getParent());
			else {
			  ThreadedBinaryNode<String> p = n.getParent();
			  assertNotNull(p);
			  assertTrue((!p.isLeftThread && p.left==n) ||
			             (!p.isRightThread && p.right==n));
			}
			n = n.inOrderSuccessor();
		}
		assertEquals(list1.size(),count);
	}
	
	public void testParent2() {
		ThreadedBinaryNode<String> n = t2.firstInOrderNode();
		int count = 0;
		while (n != null) {
			count++;
			if (n== t2.root)
				assertNull(n.getParent());
			else {
			  ThreadedBinaryNode<String> p = n.getParent();
			  assertNotNull(p);
			  assertTrue((!p.isLeftThread && p.left==n) ||
			             (!p.isRightThread &&p.right==n));
			}
			n = n.inOrderSuccessor();
		}
		assertEquals(list2.size(),count);
	}
	
	public void testParent3() {
		ThreadedBinaryNode<String> n = t3.firstInOrderNode();
		int count = 0;
		while (n != null) {
			count++;
			if (n == t3.root)
				assertNull(n.getParent());
			else {
			  ThreadedBinaryNode<String> p = n.getParent();
			  assertNotNull(p);
			  assertTrue((!p.isLeftThread && p.left==n) ||
			             (!p.isRightThread &&p.right==n));
			}
			n = n.inOrderSuccessor();
		}
		assertEquals(list3.size(),count);
	}

}
