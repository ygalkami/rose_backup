
/**
 * 
 * @author anderson.
 *         Created Feb 13, 2007.
 */
public class TestTreeToCircularList {

   /**
    * TODO Put here a description of what this method does.
    *
    * @param args
    */
   // Test program
   public static void main( String [ ] args )
   {
      int [][] numLists = {
            {2, 3, 5 },
            {5, 3, 2},
            {4},
            {3, 12, 20, 73, 16, 24, 18, 4, 2, 83, 15, 11, 13, 44, 
             43, 42, 41, 56, 80, 96, 7, 1, 0, 55},
            {},
      };
      
      for (int[] nums : numLists) {
         
         BinarySearchTree<Integer> t = new BinarySearchTree<Integer>();
         for (int i : nums)
            t.insert(i);
         // For each tree, the three lines of output should be identical.
         System.out.println("Tree:     " + t.printTreeInOrder());
         t.turnTreeIntoCircularList();
         System.out.println("Forward:  " + t.printListForward());
         System.out.println("Backward: " + t.printListBackward());
         System.out.println();
      }
   }

}
