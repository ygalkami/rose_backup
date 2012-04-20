import java.util.ArrayList;
import java.util.Queue;


public class FixedLengthQueue {
	int length;
	int position = 0;
	ArrayList<String> array = new ArrayList<String>();
//	Queue<String> queue = new Queue<String>();
	
	public FixedLengthQueue (int length) {
		this.length = length;
	}
	
	public void add (String stringtoadd) {
//		System.out.println(array.size() + " " + this.length);
		if (array.size() < this.length) {
			array.add(stringtoadd);
		}
		else {
			array.set(position, stringtoadd);
			if (this.length > 1) {
				if (position < array.size() - 1) {
					position++;
				}
				else
					position = 0;
				}
			else
				position = 0;
		}
	}
	
	public String toString () {
		String toprint = "";
		String toprint2 = "";
		for (int i = position; i < array.size(); i++) {
			toprint += (" " + array.get(i));
		}
		
		for (int i = 0; i < position; i++) {
			toprint += (" " + array.get(i));
		}
		
		for (int i = 0; i < toprint.length(); i++) {
			if (!(i == 0)) {
				toprint2 += toprint.charAt(i);
			}
		}
		return toprint2;
	}
}
