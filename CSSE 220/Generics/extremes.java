import java.util.ArrayList;

class extremes<AnyType extends Comparable<? super AnyType>> {

	public AnyType min(AnyType a, AnyType b) {
		if (a.compareTo(b) < 0) {
			return a;
		} else
			return b;
	}

	public AnyType max(AnyType a, AnyType b) {
		if (a.compareTo(b) > 0) {
			return a;
		} else
			return b;
	}

	public AnyType min2(ArrayList<AnyType> a) {
		AnyType temp = a.get(0);
		for (int i = 0; i < a.size(); i++) {
			if (temp.compareTo(a.get(i)) > 0) {
				temp = a.get(i);
			}
		}
		return temp;
	}

	public ArrayList<AnyType> max2(ArrayList<AnyType> a) {
		AnyType temp = a.get(0);
		ArrayList<AnyType> returnstuff = new ArrayList<AnyType>();

		int position = 0;
		for (int i = 0; i < a.size(); i++) {
			if (temp.compareTo(a.get(i)) < 0) {
				temp = a.get(i);
				position = i;
			}
		}
		returnstuff.add(a.get(position));
		temp = a.get(0);
			
			for (int i = 0; i < a.size(); i++) {
				if (i != position) {
					if (temp.compareTo(a.get(i)) < 0) {
						temp = a.get(i);
					}
				}
			}
			returnstuff.add(temp);
			return returnstuff;
		}
		
	
	public static void main(String[] args) {
		ArrayList<String> array = new ArrayList<String>();
		array.add("a");
		array.add("b");
		array.add("c");
		
		extremes<String> test = new extremes<String>();
		System.out.println(test.max("a", "b"));
		System.out.println(test.min2(array));
		System.out.println(test.max2(array));
	}
}
