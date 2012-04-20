import java.util.ArrayList;

import junit.framework.TestCase;


public class JUnitTests extends TestCase {
	
	int [] [] numLists ;
	
	public void  setUp() {
		//Create a random-order array of integers.
		int randListSize = 20;
		int [] randArray = new int [randListSize];
		ArrayList<Integer> al = new ArrayList<Integer>();
		for (int i=0; i<randListSize; i++)
			al.add(i);
		for (int i=0; i<randListSize; i++) {
			int selection = (int)(Math.random()*al.size());
			randArray[i] = al.get(selection);
			al.remove(selection);
		}
		// Create several number arrays for testing.
		int [] [] numArrays = {
            {2, 3, 5 },
            {5, 3, 2},
            {4},
            {3, 12, 20, 73, 16, 24, 18, 4, 2, 83, 15, 11, 13, 44, 
             43, 42, 41, 56, 80, 96, 7, 1, 0, 55},
            {},
            {38},
            randArray };
		numLists = numArrays;
	}
	
	// Compare the integers in a string to those in and array.
	public static void compareArrayToOutputString(int[] nums, String s){
		String [] sArray = s.split(" ");
		assertEquals(nums.length, sArray.length);
		// Compare individual elements next.
		for (int i=0; i<nums.length; i++)
			assertEquals(nums[i], Integer.parseInt(sArray[i]));
	}
	
	// build and test a tree, based on an array of integers.
	
	public void checkTree(int j) {
		BinarySearchTree<Integer> t = new BinarySearchTree<Integer>();
        int [] nums = numLists[j];
        for (int i : nums)
           t.insert(i);
        // For each tree, the three lines of output should be identical.
        java.util.Arrays.sort(nums);
        compareArrayToOutputString(nums, t.printTreeInOrder());
        t.turnTreeIntoCircularList();
        compareArrayToOutputString(nums, t.printListForward());
        compareArrayToOutputString(nums,  t.printListBackward());      
	}
	
	public void testTree0() {
		checkTree(0);
	}
	
	public void testTree1() {
		checkTree(1);
	}
	
	public void testTree2() {
		checkTree(2);
	}
	
	public void testTree3() {
		checkTree(3);
	}
	
	public void testTree4() {
		BinarySearchTree<Integer> t = new BinarySearchTree<Integer>();
        int [] nums = numLists[4];
        for (int i : nums)
           t.insert(i);
        assertEquals("", t.printTreeInOrder());
        t.turnTreeIntoCircularList();
        assertEquals("", t.printListForward());
        assertEquals("", t.printListBackward());      
	}
	
	public void testTree5() {
		checkTree(5);
	}
	
	// run some more tests on random trees
	public void testTree6() {
		checkTree(6);
	}
	
	public void testTree7() {
		checkTree(6);
	}
	
	public void testTree8() {
		checkTree(6);
	}
	
	public void testTree9() {
		checkTree(6);
	}

}
