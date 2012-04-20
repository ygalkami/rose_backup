

public class Anagram {
   
   /**
    * We say that two strings are anagrams if one can be transformed
    * into the other by permuting the characters (and ignoring case).
    * 
    * @param s1 first string
    * @param s2 second string
    * @return true iff s1 is an anagram of s2
    */
   
   public static boolean isAnagram(String s1, String s2) {
      int count = 0;
	   
	  s1 = s1.toLowerCase();
      s2 = s2.toLowerCase();
      
      if (s1.length() != s2.length())
    	  return false;
      
      System.out.println(s1 + " " + s2);
      for (int i = 0; i < s1.length(); i++) {
    	  for (int j = 0; j<s2.length(); j++) {
    		  if (s1.charAt(i) == s2.charAt(j)) {
    			  System.out.println(s1.charAt(i) + " " + s2.charAt(j));
    			  count++;
    			  break;
    		  }
    	  }
      }
      if (count == s1.length()) {
    	  return true;
      }
      else
    	  return false;
   }
   
}
