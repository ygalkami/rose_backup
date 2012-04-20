
public class BinarySearchTree<T extends Comparable<T>> {
	
	private BinaryNode<T> root;
	
	public BinarySearchTree() {
		this.root = null;
	}
	
	// Does this tree contain obj?
	public boolean contains(T obj){
		return contains(obj, this.root);
	}
	
	// DOets the subtree at t contain obj?
	protected boolean contains(T obj, BinaryNode<T> t){
		if (t == null)
			return false;
		int comp = t.element.compareTo(obj);
		if (comp < 0) 
			return contains(obj, t.right);
		if (comp > 0)
			return contains(obj, t.left);
		else return true;	
	}
	
	// insert obj, if not already there
	public void insert(T obj) {
		this.root = insert (obj, this.root);
	}
	
    //	insert obj in to tree at t, if not already there
	protected BinaryNode<T> insert (T obj, BinaryNode<T> t) {
		if (t == null)
			return new BinaryNode<T> (obj, null, null);
		int comp = t.element.compareTo(obj);
		if (comp < 0) 
			t.right = insert(obj, t.right);
		else if (comp > 0) {
			t.left = insert(obj, t.left);
			t.rank++;
		}
		else
			throw new IllegalArgumentException("DuplicateItem");
		return t;	
	}
	
	public T findKth(int k) {
		return findKth(k, root).element;
	}
	
	protected BinaryNode<T> findKth(int k, BinaryNode<T> t) {
		if (t == null)
			throw new IndexOutOfBoundsException("Cannont insert a null node");
		if (k == t.rank)
			return t;
		if (k < t.rank)
			return findKth(k, t.left);
		return findKth(k - t.rank - 1, t.right);
	}
	
    // delete obj, if it's there
	public void delete(T obj) {
		this.root = delete (obj, this.root);
	}
	
    // delete obj  from tree at t, if it's there
	protected BinaryNode<T>  delete(T obj, BinaryNode<T> t) {
		if (t == null)
			return null;
		int comp = t.element.compareTo(obj);
		if (comp == 0) {
			if(t.right == null)
				return t.left;
		    if (t.left == null) 
		    	return t.right;
		    BinaryNode<T> lower = leftmost(t.right);
		    t.element = lower.element;
		    t.right = delete(lower.element, t.right);
		}
		else if (comp < 0) 
			t.right = delete(obj, t.right);
		else if (comp > 0)
			t.left = delete(obj, t.left);
		return t;
	}
	
	public BinaryNode<T> leftmost (BinaryNode<T> t) {
		while (t.left == null)
			t = t.left;
		return t;
	}
	
	public static void main(String[] args) {
		BinarySearchTree<Integer> tree = new BinarySearchTree<Integer>();
		tree.insert(30);
		tree.insert(50);
		tree.insert(40);
		tree.insert(20);
		try {
			tree.insert(40);
		} catch (IllegalArgumentException e) {
			System.out.println("Tried to insert duplicate item");
		}
		tree.root.printInOrder(); System.out.println();
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
		System.out.println("Testing findKth");
		for (int i = -1; i < 17; i++) {
			try {
				System.out.print(tree.findKth(i) + " ");
			}
			catch(IndexOutOfBoundsException e) {
				System.out.print(" Not found ");
			}
		}
		System.out.println();
		
		tree.root.printInOrder(); System.out.println();
		tree.root.printPreOrder(); System.out.println();
		System.out.println("------------------------");
		tree.delete(40);
		tree.root.printInOrder(); System.out.println();
		tree.root.printPreOrder(); System.out.println();

	}

}
