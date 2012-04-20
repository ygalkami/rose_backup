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


//You don't really need to do anything with the following code.
//It is simply here to give you some insight into working with
//threaded binary trees.

 public  T find(T x) throws ItemNotFound  {
   if (root == null)
     throw new ItemNotFound("Empty Tree");
   else
     return find (x, root);
 }

 private T find(T x, ThreadedBinaryNode<T> t)
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
     return t.element;
 }

  
  // The following two methods are only here to show how the 
  // four methods you are to write could be used.
  
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
  
  // Returns a reference to the first node in an inOrder traversal of this tree.
  public ThreadedBinaryNode<T> firstInOrderNode() {
		ThreadedBinaryNode t = root;
		if( t == null)
			return t;
		
		
		while(!t.isLeftThread)
			t = t.left;
		return t;
  }
 
  // Returns a reference to the first node in an inOrder traversal of this tree.
  public ThreadedBinaryNode<T> lastInOrderNode() {
		ThreadedBinaryNode t = root;
		
		
		if( t == null)
			return t;
		while(!t.isRightThread)
			t = t.right;
		return t;
  }
}

