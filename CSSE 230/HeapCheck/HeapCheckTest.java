import junit.framework.TestCase;

// Recall that the "heapness" does not depend on what 
// is in position 0 of the array.  The actual "tree" contents
// start in position 1.

public class HeapCheckTest extends TestCase {
	public void testHeapCheck1() {
		int [] a1 = {0, 1, 2}; 
		int [] a2 = {0, 2, 1};
		assertTrue(HeapCheck.heapCheck(a1));		
		assertFalse(HeapCheck.heapCheck(a2));
	}
	
	public void testHeapCheck2() {
		int [] a1 = {5, 1}; 
		int [] a2 = {5, 2, 3, 1};
		assertTrue(HeapCheck.heapCheck(a1));		
		assertFalse(HeapCheck.heapCheck(a2));
	}
	
	public void testHeapCheck3() {
		int [] a1 = {0, 1, 2, 3, 4, 5, 6, 7}; 
		int [] a2 = {0, 1, 2, 4, 3, 6, 5, 7};
		assertTrue(HeapCheck.heapCheck(a1));
		assertTrue(HeapCheck.heapCheck(a2));
		a1[1] = 10;
		assertFalse(HeapCheck.heapCheck(a1));
	}
	
	public void testHeapCheck4() {
		int [] a1 = {5, 1, 2, 10, 3, 7, 12, 14, 4, 8}; 
		int [] a2 = {5, 1, 2, 10, 3, 12, 7, 14, 4, 8};
		assertTrue(HeapCheck.heapCheck(a1));		
		assertFalse(HeapCheck.heapCheck(a2));
	}
	
	public void testHeapCheck5() {
		int [] a1 = {5, 1, 2, 10, 3, 7, 12, 14}; 
		int [] a2 = {5, 1, 2, 10, 3, 7, 12, 4};
		assertTrue(HeapCheck.heapCheck(a1));		
		assertFalse(HeapCheck.heapCheck(a2));
	}
}
