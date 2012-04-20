import junit.framework.TestCase;


public class TestBinaryNodeEquals extends TestCase {
	
	BinaryTree tree1, tree2;
	BinaryNode root1, root2;
	
	public void setUp() throws Exception {
		super.setUp();
		tree1 = BuildTree.preOrderBuild("ABCEDCDCED", "22LR0L0LR0");
		root1 = tree1.root;
		tree2 = BuildTree.preOrderBuild("XAABC", "20200");
		root2 = tree2.root;
		
	}
	
	public void testEquals1() {
		assertTrue(root1.left.left.left.right.equals(root1.right.left.right));
	}
	
	public void testEquals2() {
		assertTrue(root1.left.left.equals(root1.right));
	}
	
	public void testEquals3() {
		assertFalse(root1.left.right.equals(root1.right));
	}
	
	public void testEquals4() {
		assertFalse(root1.left.equals(root1.left.right.left));
	}
	
	public void testEquals5() {
		assertFalse(root1.left.equals(root1.left.right.left.right));
	}
	
	public void testEquals6() {
		assertFalse(root2.left.equals(root2.right));
	}
	
	public void testEquals7() {
		tree1 = BuildTree.preOrderBuild("ABC", "200");
		root1 = tree1.root;
		tree2 = BuildTree.preOrderBuild("ACB", "200");
		root2 = tree2.root;
		assertFalse(root1.equals(root2));
	}




}
