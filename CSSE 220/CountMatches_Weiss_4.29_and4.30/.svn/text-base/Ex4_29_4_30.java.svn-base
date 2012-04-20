// Author:  Your name here: David Pick

   // In this exercise you are to solve Weiss exercises 4.29 and 4.30


public class Ex4_29_4_30 {
   

  public static int countMatches(int[] a, Matchable t) {
    int matches = 0;
    for (int i = 0; i < a.length; i++) {
    	if (t.match(a[i])) {
    		matches++;
    	}
    }
     return matches;
  }

}

// Interface for the function objects.
interface Matchable {
  boolean match(int lhs) 
  	throws ClassCastException;
}

class EqualsZero implements Matchable {
	public boolean match(int lhs) throws ClassCastException {
		if (lhs == 0)
			return true;
		else
			return false;
	}
}

class IsPositive implements Matchable {
   public boolean match(int lhs) throws ClassCastException {
	   if (lhs > 0)
		   return true;
	   else
		   return false;
   }
}

class EqualsK implements Matchable {
   protected int k;
   public boolean match (int lhs) throws ClassCastException {
	   if (lhs == k)
		   return true;
	   else
		   return false;
   }
   
   public EqualsK (int k) {
	   this.k = k;
   }
}
