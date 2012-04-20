import java.util.ArrayList;

class extremes<AnyType extends Comparable<? super AnyType>>	{
	public AnyType min(AnyType a, AnyType b){
		if (a.compareTo(b) < 0) {
			return a;
		}
		else
			return b;
	}
	
	public AnyType max(AnyType a, AnyType b) {
		if (a.compareTo(b) > 0) {
			return a;
		}
		else
			return b;
	}
	
	public AnyType min2(ArrayList<AnyType> a) {
		AnyType temp = a.get(0);
		for(int i = 0; i < a.size(); i++) {
			if (temp.compareTo(a.get(i)) > 0)	{
				temp = a.get(i);
			}
		}
		return temp;
	}
	
	public ArrayList<AnyType> max2(ArrayList<AnyType> a) {
		AnyType temp = a.get(0);
		ArrayList<AnyType> returnstuff = new ArrayList<AnyType>();
		
		int pos = 0;
		for (int i = 0; i < a.size(); i++) {
			if (temp.compareTo(a.get(i)) < 0) {
				temp = a.get(i);
				pos = i;
			}
		}
		
		returnstuff.add(a.get(pos));
		temp = a.get(0);
		
		for (int i = 0; i < a.size(); i++) {
			if (i != pos) {
				if (temp.compareTo(a.get(i)) < 0) {
					temp = a.get(i);
				}
			}
		}
		returnstuff.add(temp);
		return returnstuff;
	}
}