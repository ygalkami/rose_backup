
public class Split {
	public static String [] split(String str, String tokens){
		int k = 0;
		String[] array = new String [str.length()];
		
		for (int i=0; i<str.length(); i++){
			if (str.charAt(i) == tokens.charAt(0)){
				for(int j=0; j<tokens.length(); j++){
					if (str.charAt(i + j) == tokens.charAt(j)){
						if (array[k] == null)
							array[k] = str.charAt(j) + "";
						else
							array[k] += str.charAt(j);
					}
					else
					{
						break;
					}
				}
				k++;
			}
			
		}
		return array;
	}

	public static void main(String[] args) {
		String[] array;
		array = split("this is a test", "is");
		System.out.println(array[0]);
	}

}