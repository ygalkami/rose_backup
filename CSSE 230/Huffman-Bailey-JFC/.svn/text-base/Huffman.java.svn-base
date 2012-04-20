/* File compression using  Huffman tree.
   Based on code by Duane Bailey.
   Rewritten and adapted by Claude Anderson, 5/5/08.
   This program reads text from standard input, constructs a
   Huffman tree based on the frequency of characters, and prints
   out a table of characters, frequencies, and codes.
*/
import java.util.HashMap; import java.io.*;import java.util.PriorityQueue;
public class Huffman { 
    public static void main(String args[]) throws Exception {
      BufferedReader r = new BufferedReader(                                new InputStreamReader(System.in));      HashMap<Character, Integer> freq = new HashMap<Character,Integer>();  // List of characters and their
                                           // frequencies in the message
                                           // that we are encoding.
      String oneLine;  // current input line.
      // First read the data and count characters
      // Go through the input line, one character at a time.
      while ((oneLine = r.readLine()) != null) {
        for (int i = 0; i<oneLine.length(); i++) {
          char c = oneLine.charAt(i);
           if (freq.containsKey(c))        	  freq.put(c, freq.get(c)+1);
          else // first time we've seen c        	  freq.put(c, 1);
        }
      }
      // Now the table of frequencies of each character is complete.
      // insert each character into a single-node Huffman tree
      PriorityQueue<HuffmanTree> treeQueue = new  PriorityQueue<HuffmanTree>();
      for (char c : freq.keySet()) 
        treeQueue.add(new HuffmanTree(new Leaf(c, freq.get(c))));
            HuffmanTree smallest, secondSmallest;
      // merge trees in pairs until only one tree remains
      while (true) {
        smallest = treeQueue.poll();
        secondSmallest = treeQueue.poll();        if (secondSmallest == null)         	break;
        // add bigger tree containing both to the sorted list.
        treeQueue.add(new HuffmanTree(smallest, secondSmallest));
      }      
      // print the only tree left in the list of Huffman trees.
      smallest.print();
    }
}  // End of Huffman class definition.
/*
C:\Personal\Courses\CS-220\java-source\HuffmanTrees>java Huffman
If a woodchuck could chuck woodEncoding of o is 00 (frequency was 5, length of code is 2)Encoding of u is 010 (frequency was 3, length of code is 3)Encoding of I is 01100 (frequency was 1, length of code is 5)Encoding of a is 01101 (frequency was 1, length of code is 5)Encoding of f is 01110 (frequency was 1, length of code is 5)Encoding of l is 01111 (frequency was 1, length of code is 5)Encoding of w is 1000 (frequency was 2, length of code is 4)Encoding of k is 1001 (frequency was 2, length of code is 4)Encoding of c is 101 (frequency was 5, length of code is 3)Encoding of   is 110 (frequency was 5, length of code is 3)Encoding of h is 1110 (frequency was 2, length of code is 4)Encoding of d is 1111 (frequency was 3, length of code is 4)Total bits required for message: 105
*/
