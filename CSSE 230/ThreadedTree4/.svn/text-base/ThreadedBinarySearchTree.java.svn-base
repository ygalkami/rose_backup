// Put your name here.

public class ThreadedBinarySearchTree<T extends Comparable<? super T>> {

  ThreadedBinaryNode<T> root;  // The only instance variable; do not add others.

  //Constructor
  ThreadedBinarySearchTree() {
      root = null;
  }

  // insert a node containing x into its proper position in the tree
  // no balancing required.  Update left and right thread information properly.

  public void insert(T x) throws DuplicateItem {
  
    if (root == null)
      root = new ThreadedBinaryNode<T>( x );
    else
      insert(x, root);
  }

  void insert (T x, ThreadedBinaryNode<T> t) throws DuplicateItem {
	   if (x.compareTo(t.element) < 0)
		      if (t.isLeftThread) {
		        t.left = new ThreadedBinaryNode(x, t.left, t);
		        t.isLeftThread = false;
		      }
		      else
		        insert(x, t.left);
		    else if (x.compareTo(t.element) > 0)
		      if (t.isRightThread) {
		        t.right = new ThreadedBinaryNode(x, t, t.right);
		        t.isRightThread = false;
		      }    
		      else
		        insert(x, t.right);
		    else
		      throw new DuplicateItem("attempt to insert duplicateitem");
	   }

  // Print in inorder (forward and backwards) without using a stack, 
  // recursion or extra storage space for more than a constant number
  // of node contents.

  public void printTree()   {
  
    ThreadedBinaryNode<T> t = root;
    if (t == null)
        return;  // print nothing if tree is empty.

    while (!t.isLeftThread)
        t = t.left;  // We now have the first inorder node.

    System.out.println("\nFORWARD:");
    // You fill in the details here.
    while (t != null) {
        System.out.println(t);
        if (t.isRightThread)
          t = t.right;
        else {
          t = t.right;
          while (!t.isLeftThread)
            t = t.left;
        }
    }
    System.out.println("\n\nBACKWARD:");
    // You fill in the details here.
    t = root;
    while (!t.isRightThread)
      t = t.right;
 
    while (t != null)     {
      System.out.println(t);
      if (t.isLeftThread)
        t = t.left;
      else
      {
        t = t.left;
        while (!t.isRightThread)
          t = t.right;
      }
    }

  }
  
  public void traverseInOrder() {
	  ThreadedBinaryNode<T> t = firstInOrderNode();
	  while (t != null){
		  System.out.println(t);
		  t = t.inOrderSuccessor();
	  }
  }
  
  public void traverseInOrderBackwards() {
	  ThreadedBinaryNode<T> t = lastInOrderNode();
	  while (t != null){
		  System.out.println(t);
		  t = t.inOrderPredecessor();
	  }
  }
  
  public ThreadedBinaryNode<T> firstInOrderNode() {
	  ThreadedBinaryNode<T> t = this.root;
	  if (t == null)
		  return null;
      while (!t.isLeftThread)
            t = t.left;
      return t;
  }
  
  public ThreadedBinaryNode<T> lastInOrderNode() {
	  ThreadedBinaryNode<T> t = this.root;
	  if (t == null)
		  return null;
      while (!t.isRightThread)
            t = t.right;
      return t;
  }


// You don't really need to do anything with the following code.
// It is simply here to give you some insight into working with
// threaded binary trees.

  public  T find(T x) throws ItemNotFound  {
    if (root == null)
      throw new ItemNotFound("Empty Tree");
    else
      return find(x, root).element;
  }

  public ThreadedBinaryNode<T> find(T x, ThreadedBinaryNode<T> t)
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
  
  public String preOrderTraversal() {
	  return preOrderTraversal(this.root);
  }
  
  private String preOrderTraversal(ThreadedBinaryNode<T> t) {
	  String leftString = "", rightString = "";
	  if (!t.isLeftThread)
		  leftString = preOrderTraversal(t.left);
	  if (!t.isRightThread)
		  rightString = preOrderTraversal(t.right);
	  return t.element + " " + leftString + rightString;
  }

}
