// This class is simply here to facilitate writing test code.  You do not need to do anything with it.

public class BuildTree {
  private static CharSequence contentString;
  private static CharSequence shapeString;
  private static int    positionInStrings;
  

 public static BinaryTree preOrderBuild(CharSequence chars, 
		                                CharSequence children) {
	 BinaryTree t = new BinaryTree();
	 t.root = buildTree(chars, children);
	 return t;
	 
 }
 // returns a reference to the root of the tree that it builds.
  private static BinaryNode buildTree(CharSequence contents, 
                                      CharSequence shape) {
  contentString =  contents;
  shapeString = shape;
  positionInStrings = 0;
  return buildTree();
}

private static BinaryNode buildTree (){
  BinaryNode right=null, left=null;
  String element = "" + contentString.charAt(positionInStrings);
      
      switch (shapeString.charAt(positionInStrings++)) {
        case 'L':
          left = buildTree();
          break;
        case '2':
          left = buildTree();  // Notice that there is no "break" here.
        case 'R':
          right = buildTree();
        case '0':
      }
      return new BinaryNode(element, left, right);
  }
}
