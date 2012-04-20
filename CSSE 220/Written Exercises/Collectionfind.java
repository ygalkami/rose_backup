import java.util.ArrayList;
import java.util.Collection;


public class Collectionfind {
	public static int count (Collection<Collection<String>> c, String str) {
		int count = 0;
		Collection<String> current;
		String current2;

		for (Collection<String> s : c) {
			for (String sr : s) {
				if (sr.compareTo(str) == 0)
					count++;
			}
		}
		return count;
	}
	
	public static void main (String[] args) {
		Collection<Collection<String>> a = new ArrayList<Collection<String>>();

		  String[][] arrays = {{"abc", "def", "ghi"},
		                       {"xyz", "uvw", "abc", "abc"},
		                       {"a", "ab", "abc", "xyz", "abc"}};

		  for (String[] sArray : arrays){
		    Collection<String> a1 = new ArrayList<String>();
		    for (String s: sArray)
		      a1.add(s);
		    a.add(a1);
		  }
		  System.out.println(count(a, "abc"));
	}
}
