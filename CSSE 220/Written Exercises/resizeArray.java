
public class resizeArray {
	public static String [] split(String str, String tokens) {
		String[] tokens2 = str.split(tokens);
		
		return tokens2;
	}
	
	public void main (String[] args){
		String[] array = split("this is a test", " ");
		System.out.print(array[0]);
	}
}
