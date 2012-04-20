
public class BinarySearchTree<T extends Comparable<T>> {
	
	private BinaryNode<T> root;
	
	public BinarySearchTree() {
		this.root = null;
	}
	
	// Does this tree contain obj?
	public boolean contains(T obj){
		if (obj == null) 
			throw new IllegalArgumentException("cannot search for null");
		return contains(obj, this.root);
	}
	
	// Does this subtree contain obj
	protected boolean contains(T obj, BinaryNode<T> t) {
		if (t == null)
			return false;
		int comp = t.element.compareTo(obj);
		if (comp == 0)
			return true;
		if (comp < 0)
			return contains(obj, t.right);
		return contains(obj, t.left);
		
	}
	
	
	// insert obj, if not already there
	public void insert(T obj) {
		if (obj == null) 
			throw new IllegalArgumentException("cannot search for null");
		this.root = insert(obj, this.root);		
	}
	
	// insert obj, if not already there
	protected BinaryNode<T> insert(T obj, BinaryNode<T> t) {
		if (t == null)
			return new BinaryNode<T>(obj, null, null);
		int comp = t.element.compareTo(obj);
		if (comp < 0)
			t.right = insert(obj, t.right);
		else if (comp > 0)
			t.left = insert(obj, t.left);
		return t;
		
	}
 
	protected BinaryNode<T> firstInorder(BinaryNode<T> t) {
		if (t.left == null)
			return t;
		return firstInorder(t.left);
	}
	
    // delete obj, if it's there
	public void delete(T obj) {
		if (obj == null) 
			throw new IllegalArgumentException("cannot search for null");
		this.root = delete(obj, this.root);	
	}
	
	protected BinaryNode<T> delete(T obj, BinaryNode<T> t) {
		if (t == null)
			return null;
		int comp = t.element.compareTo(obj);
		if (comp < 0)
			t.right = delete(obj, t.right);
		else if (comp > 0)
			t.left = delete(obj, t.left);
		else if (comp == 0) {
			if (t.right == null)
				return t.left;
			if (t.left == null)
				return t.right;
			BinaryNode<T> succ = firstInorder(t.right);
			t.element = succ.element;
			t.right = delete(succ.element, t.right);
		}
		return t;
	}
	
 	
	public static void main(String[] args) {
		BinarySearchTree<Integer> tree = new BinarySearchTree<Integer>();
		tree.insert(30);
		tree.insert(50);
		tree.insert(40);
		tree.insert(20);
		tree.insert(40);
		tree.root.printInOrder(); System.out.println();
		tree.root.printPreOrder(); System.out.println();
		System.out.println(tree.contains(40));		
		System.out.println(tree.contains(25));		
		System.out.println(tree.contains(35));
		tree.insert(35);
		tree.insert(37);
		tree.insert(45);
		tree.insert(60);
		tree.insert(70);
		tree.insert(65);
		tree.insert(43);
		tree.insert(41);		
		tree.root.printInOrder(); System.out.println();
		tree.root.printPreOrder(); System.out.println();
		System.out.println("------------------------");
		tree.delete(40);
		tree.root.printInOrder(); System.out.println();
		tree.root.printPreOrder(); System.out.println();

	}

}
