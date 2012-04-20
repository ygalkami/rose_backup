/* File compression using  Huffman tree.
   Based on code by Duane Bailey.
   Rewritten and adapted by Claude Anderson, 5/5/08.
   This program reads text from standard input, constructs a
   Huffman tree based on the frequency of characters, and prints
   out a table of characters, frequencies, and codes.
*/
import java.util.HashMap; 
public class Huffman { 
    public static void main(String args[]) throws Exception {
      BufferedReader r = new BufferedReader(
                                           // frequencies in the message
                                           // that we are encoding.
      String oneLine;  // current input line.
      // First read the data and count characters
      // Go through the input line, one character at a time.
      while ((oneLine = r.readLine()) != null) {
        for (int i = 0; i<oneLine.length(); i++) {
          char c = oneLine.charAt(i);
           if (freq.containsKey(c))
          else // first time we've seen c
        }
      }
      // Now the table of frequencies of each character is complete.
      // insert each character into a single-node Huffman tree
      PriorityQueue<HuffmanTree> treeQueue = new  PriorityQueue<HuffmanTree>();
      for (char c : freq.keySet()) 
        treeQueue.add(new HuffmanTree(new Leaf(c, freq.get(c))));

      // merge trees in pairs until only one tree remains
      while (true) {
        smallest = treeQueue.poll();
        secondSmallest = treeQueue.poll();
        // add bigger tree containing both to the sorted list.
        treeQueue.add(new HuffmanTree(smallest, secondSmallest));
      }
      // print the only tree left in the list of Huffman trees.
      smallest.print();
    }
}  // End of Huffman class definition.

C:\Personal\Courses\CS-220\java-source\HuffmanTrees>java Huffman
If a woodchuck could chuck wood
*/