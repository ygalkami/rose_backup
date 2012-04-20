// You must not change this file.

import junit.framework.TestCase;

public class AnagramTests extends TestCase {
   
   public static int totalPoints = 0;
   
   public void testAnagram1() {
      assertFalse(Anagram.isAnagram("a", "b"));
      assertTrue(Anagram.isAnagram("a", "a"));
      totalPoints += 1;
   }
   
   public void testAnagram2() {
      assertFalse(Anagram.isAnagram("a", "b"));
      assertTrue(Anagram.isAnagram("a", "A"));
      totalPoints += 1;
   }
   
   public void testAnagram3() {
      assertFalse(Anagram.isAnagram("a", "b"));
      assertTrue(Anagram.isAnagram("ab", "ba"));
      totalPoints += 2;
   }

   public void testAnagram4() {
      assertFalse(Anagram.isAnagram("a", "b"));
      assertTrue(Anagram.isAnagram("abc", "cba"));
      totalPoints += 3;
   }
   
   public void testAnagram5() {
      assertFalse(Anagram.isAnagram("a", "b"));
      assertTrue(Anagram.isAnagram("abc", "bca"));
      totalPoints += 3;
   }
   
   public void testAnagram6() {
      assertFalse(Anagram.isAnagram("a", "b"));
      assertTrue(Anagram.isAnagram("Claude Anderson", "Candor Unsealed"));
      totalPoints += 3;
   }
   
   public void testAnagram7() {
      assertFalse(Anagram.isAnagram("aabb", "bbbaa"));
      assertTrue(Anagram.isAnagram("Claude Anderson", "Nuanced Ordeals"));
      totalPoints += 4;
   }
 
   public void testAnagram8() {
      assertTrue(Anagram.isAnagram("aabb", "bbaa"));
      assertFalse(Anagram.isAnagram("Claude Anderson", "Nuanced  Ordeals"));
      totalPoints += 3;
   }
   
   
   public void testTotal(){
      System.out.println("Total points = " + totalPoints);
   }
   
   
}
