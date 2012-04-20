// this is the class you should modify for probalem 1.


import java.util.Map;
import java.util.Set;

public class Ex4_29_4_30 {
   
   // JUnit tests are in the file TestCountMatches.

  public static int countMatches(int[] a, Matchable t) {
    int count = 0;
      for (int i = 0; i < a.length; i++)
      if (t.test(a[i]))
        count++;
    return count;
  }
}
 
// Interface for the function objects.
interface Matchable {
  boolean test(int i);
}

class EqualsZero implements Matchable {
  public boolean test(int i) {
    return i == 0;
  }
}

class IsPositive implements Matchable {
  public boolean test(int i) {
    return i > 0;
  }
}

class EqualsK implements Matchable {
  private int storedK;

  public EqualsK(int kToStore) {
    storedK = kToStore;
  }

  public boolean test(int i) {
    return i == storedK;
  }
}
  
class MemberOf implements Matchable {
	private Set<Integer> set;
	
	public MemberOf(Set<Integer> set) {
		this.set = set;
	}
	
	public boolean test(int i) {
		if (set.contains(i))
			return true;
		return false;
	}
}

class MapsTo implements Matchable {
	private int k;
	private Map<Integer, Integer> map;
	
	public MapsTo(Map<Integer, Integer> map, int k) {
		this.k = k;
		this.map = map;
	}
	
	public boolean test(int i) {
		if (map.get(i).equals(this.k))
			return true;
		return false;
	}
}


/*
 * TODO: Add the definitions of the MemberOf and MapsTo classes.
 */
