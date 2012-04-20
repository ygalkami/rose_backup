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
    String.format("(%13s %13s %13s %7b %6b)", 
      element,
        (left==null ? "null" : left.element.toString()),
        (right==null ? "null" : right.element.toString()),
        isLeftThread, isRightThread) ;
  }
  
  // Returns the next inOrder node of the threaded tree
  // in which this node lives.
  public ThreadedBinaryNode<T> inOrderSuccessor() {
	  ThreadedBinaryNode t;
	  
	  	if (!this.isRightThread){
	  		t = this.right;
	  	  while(!t.isLeftThread)
			  t = t.left;
	  	  return t;
	  	}
	  	else return this.right;
	  	  	
  }
 
  // Returns the previous inOrder node of the threaded tree
  // in which this node lives.

  public ThreadedBinaryNode<T> inOrderPredecessor() {
	  ThreadedBinaryNode t;
	  
	  	if (!this.isLeftThread){
	  		t = this.left;
	  	  while(!t.isRightThread)
			  t = t.right;
	  	  return t;
	  	}
	  	else return this.left;
	  	
  }	
}