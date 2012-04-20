import java.util.Scanner;


public class Reverser {

	public static String wordreverse (String word) {
		String reversed = "";
		int len = word.length() - 1;
		for (int i=0; i<=len; i++){
			reversed += word.charAt(len-i);
		}
		return reversed;
	}
	
	public static String sentance (String testString){
		String reversed = "";
		String stringarray[] = testString.split(" ");
		int len = stringarray.length - 1;
	
		for (int i = 0; i<=len; i++) {
			if (i != len) {
				reversed = reversed + wordreverse(stringarray[i]) + " ";
			}
			else {
				reversed = reversed + wordreverse(stringarray[i]);
			}
		}
		return reversed;
	}
	public static void main(String[] args) {
		while(true) {
			Scanner sc = new Scanner(System.in);
			String input = sc.nextLine();
	
			String reverse = sentance(input);
			System.out.println(wordreverse(input));
			System.out.println(reverse);
		}

	}

}
