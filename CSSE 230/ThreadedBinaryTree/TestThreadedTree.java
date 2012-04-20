// Test program for Threaded Binary Tree problem/
// Claude Anderson.    January 20, 2005.

import java.util.*;

public class TestThreadedTree {
    public static void main(String [] args)  {
	String s1 = "a recursive method is a method that either directly " +
	    "or indirectly makes a call to itself";
	testOneTree(s1);

	// You may want to comment out the next few lines during preliminary
	// testing, until you get the first example working.
	
	String s2 = "Now is the time for all good men to come to the "
	    + "aid of their country";
	testOneTree(s2);
	String s3 = "It is in vain, sir, to extenuate the matter. " +
	    "Gentlemen may cry, Peace, Peace--but there is no peace. " +
	    "The war is actually begun! The next gale that sweeps from " +
	    "the north will bring to our ears the clash of resounding " +
	    "arms! Our brethren are already in the field! Why stand we " +
	    "here idle? What is it that gentlemen wish? What would they " +
	    "have? Is life so dear, or peace so sweet, as to be purchased " +
	    "at the price of chains and slavery? Forbid it, Almighty God! I " +
	    "know not what course others may take; but as for me, give me " +
	    "liberty or give me death!  -- Patrick Henry" ;
	testOneTree(s3);
    }

    public static void testOneTree (String s) {
	System.out.println();
	System.out.println("----------------------------------------------------");
	System.out.println ("Testing with string:");
	System.out.println("  " + s);
	System.out.println();
	StringTokenizer st = new StringTokenizer(s, " ");
	ThreadedBinarySearchTree<String> t = new ThreadedBinarySearchTree<String>();
        String current = null;
	for (; st.hasMoreTokens(); ) {
	    current = st.nextToken();
	    try {
		if (current != null)
		    t.insert(current);
	    } catch (DuplicateItem e)  {
		System.out.println("duplicate item " + current);
	    }
	}
	
	try  {
	    System.out.println("Found item: " + t.find(new String("the")));
	    System.out.println("Found item: " + t.find(new String("at")));
	} catch (ItemNotFound e) {
	    System.out.println(e.getMessage());
	}
	
	t.printTree();
    }
    
}
