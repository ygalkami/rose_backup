import junit.framework.TestCase;


public class TestPreInBuild extends TestCase {

	
	public void testPreIn1() {
		BinaryNode t = PreorderInorderBuild.buildFromPreOrderInorder("", "");
		this.assertNull(t);
	}
	
	public void testPreIn2() {
		BinaryNode t = PreorderInorderBuild.buildFromPreOrderInorder("A", "A");
		assertEquals(1, BinaryNode.size(t));
		assertEquals(0, BinaryNode.height(t));
	}
	
	public void testPreIn3() {
		BinaryNode t = PreorderInorderBuild.buildFromPreOrderInorder("AB", "AB");
		assertEquals(2, BinaryNode.size(t));
		assertEquals(1, BinaryNode.height(t));
		assertNull(t.left);
		assertNotNull(t.right);
		assertEquals(new Character('B'), (Character)(t.right.element));
	}

	public void testPreIn4() {
	BinaryNode t = PreorderInorderBuild.buildFromPreOrderInorder("AB", "BA");
	assertEquals(2, BinaryNode.size(t));
	assertEquals(1, BinaryNode.height(t));
	assertNull(t.right);
	assertNotNull(t.left);
	assertEquals(new Character('B'), (Character)(t.left.element));
	assertNull(t.left.right);
	}
	
	public void testPreIn5() {
		BinaryNode t = PreorderInorderBuild.buildFromPreOrderInorder("ABC", "BAC");
		assertEquals(3, BinaryNode.size(t));
		assertEquals(1, BinaryNode.height(t));
		assertNotNull(t.right);
		assertNull(t.right.right);
		assertNotNull(t.left);
		assertEquals(new Character('B'), (Character)(t.left.element));
		assertNull(t.left.right);
	}
	
	public void testPreIn6() {
		BinaryNode t = PreorderInorderBuild.buildFromPreOrderInorder(
				             "ABCDEFGHI", "BDCFEAIHG");
		assertEquals(9, BinaryNode.size(t));
		assertEquals(4, BinaryNode.height(t));
		assertNotNull(t.right);
		assertEquals(new Character('F'), (Character)(t.left.right.right.left.element));
		assertNull(t.left.left);
	}
	
	public void testPreIn7() {
		BinaryNode t = PreorderInorderBuild.buildFromPreOrderInorder(
				             "ABCDEFGHI", "IHGFEDCBA");
		assertEquals(9, BinaryNode.size(t));
		assertEquals(8, BinaryNode.height(t));
		assertNull(t.right);
		assertEquals(new Character('E'), (Character)(t.left.left.left.left.element));
		assertNull(t.left.right);
	}
	
	
}