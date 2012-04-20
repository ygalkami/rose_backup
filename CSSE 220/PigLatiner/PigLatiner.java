/**
 * This class contains a method used to translate English to PigLatin. 
 * I use it simply to demonstrate the process of unit testing.
 *
 * @author Matt Boutell.
 *         Created Sep 1, 2006.
 */
    public class PigLatiner {
   
   /**
    * This method finds the pig latin anslationtray of a word.
    *
    * @param s
    * @return The pig latin anslationtray of a word.
    */
       public static String transform(String s) {
         if (null == s || s.length() == 0) {
            return s;
         }
      
         int i = 0;
         while (!PigLatiner.isVowel(s.charAt(i))) {
            if (s.length() == 1 ){
               return s + "ay";
            }
            i++;
         }
      
         if (i == 0 ) {
            return s + "way";
         } 
         else {
            return s.substring(i, s.length()) + s.substring(0, i) + "ay";
         }
      }
   
       private static boolean isVowel(char c) {
         return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
      }
   
   }
