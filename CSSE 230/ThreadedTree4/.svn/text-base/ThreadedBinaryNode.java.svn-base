class ThreadedBinaryNode<T> {
    
  T element;
  ThreadedBinaryNode<T> left, right;
  boolean isLeftThread, isRightThread;
  // When isLeftThread is true, it means that the left reference
  // is a thread; it points to the node's inorder predecessor.
  // When isRightThread is true, it means that the right reference
  // is a thread; it points to the node's inorder successor.
  
  // NOTE:  You are not allowed to add any additional fields to this class.

  ThreadedBinaryNode(T theElement) {
    this(theElement, null, null, true, true);
  }

   ThreadedBinaryNode(T theElement, ThreadedBinaryNode<T> lt,
                      ThreadedBinaryNode<T> rt) {
    this(theElement, lt, rt, true, true);
  }

  ThreadedBinaryNode(T theElement, ThreadedBinaryNode<T> lt,
                     ThreadedBinaryNode<T> rt, boolean rThread, boolean lThread) {
    element = theElement;
    left = lt;
    right = rt;
    isLeftThread = lThread;
    isRightThread = rThread;
  }

// Written the way it is to facilitate debugging.
  public String toString()  {
    return
    String.format("(%13s %13s %13s %7b %6b %13s)", 
      element,
        (left==null ? "null" : left.element.toString()),
        (right==null ? "null" : right.element.toString()),
        isLeftThread, isRightThread,
        (getParent()==null ? "null" : getParent().element.toString()));
  }
  
  public ThreadedBinaryNode<T> inOrderSuccessor() {
     if (this.isRightThread)
         return this.right;
     ThreadedBinaryNode<T> t  = this.right;
     while (!t.isLeftThread)
         t = t.left;
     return t;
  }
  
  public ThreadedBinaryNode<T> inOrderPredecessor() {
	 if (this.isLeftThread)
	   return this.left;
	 ThreadedBinaryNode<T> t  = this.left;
	 while (!t.isRightThread)
	    t = t.right;
	 return t;
  }
  
  // If you cannot get to the parent by following left pointers (and a single left thread), 
  // you can get to it by following right pointers (and a single right thread).
  public ThreadedBinaryNode<T> getParent() {
	  ThreadedBinaryNode<T> t = this;
	  while (!t.isLeftThread)
		  t = t.left;
	  if (t.left != null && t.left.right == this)
		  return t.left;
	  for (t=this; !t.isRightThread; t = t.right);
	  return t.right;
  }
  
  public  ThreadedBinaryNode<T> preOrderSuccessor() {
      // TODO: Fill in the details of this method. It should
	  // return the next node in a preorder traversal of the tree that this node lives in.
	  // If this is the last preorder node, it should return null.
	  // You are not allowed to add any fields to this or any other class.
	  // Your code must run in time that is proportional to the height of the tree.
		  if (this == null) return null;

		  if (!this.isLeftThread) return this.left;
		  if (!this.isRightThread) return this.right;

		  ThreadedBinaryNode temp = this;
		  while (temp != null && temp.isRightThread ) {
			  temp = temp.right;
		  }
		  
		  return temp.right;
 }
  


}



