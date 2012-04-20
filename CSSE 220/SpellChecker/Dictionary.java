import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Scanner;

public class Dictionary {
	//input file.  
	String inputfile;

	//Hash set of the dictionary.  
	HashSet<String> dictionary = new HashSet<String>();

	//Hash map of the suggested words.  
	HashMap<String, ArrayList<String>> cachedSuggestedList = new HashMap<String, ArrayList<String>>();

	//list of suggestions for misspelled words.  
	ArrayList<String> returnList;

	/**
	 * Constructs the dictionary.
	 * 
	 * @param filename
	 *            of the dictionary.
	 */
	public Dictionary(String filename) {
		this.inputfile = filename;
	}

	/**
	 * Constructs the dictionary.
	 * 
	 * @param inputFileName
	 *            of the dictionary.
	 */
	public void setInputFileName(String inputFileName) {
		this.inputfile = inputFileName;
	}

	/**
	 * Loads the dictionary
	 * 
	 * @throws FileNotFoundException
	 *             if the dictionary file is not found.
	 */
	public void loadDictionary() throws FileNotFoundException {
		Scanner sc = new Scanner(new File(this.inputfile));
		String nextLine;
		while (sc.hasNextLine()) {
			nextLine = sc.nextLine();
			
			this.dictionary.add(nextLine.toLowerCase().trim());
		}
	}
	
	/**
	 * Loads the dictionary
	 * 
	 * @param filename
	 *            of the dictionary file.
	 * @throws FileNotFoundException
	 *             if the dictionary file is not found.
	 */
	public void loadDictionary(String filename) throws FileNotFoundException {
		this.inputfile = filename;
		this.loadDictionary();
	}

	/**
	 * Checks if words are in the dictionary.
	 * 
	 * @param word
	 *            for the dictionary to contain.
	 * @return true if the word is in the dictionary.
	 */
	public boolean contains(String word) {
		if (dictionary.contains(word.trim())) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Finds the minimum of three integer values
	 * 
	 * @param a
	 * @param b
	 * @param c
	 * @return
	 */
	public static int min(int a, int b, int c) {
		int min = a;

		if (b < min)
			min = b;
		if (c < min)
			min = c;

		return min;
	}

	/**
	 * Finds the difference between strings to provide good suggestions.
	 * 
	 * @param s first string
	 * @param t second string
	 * @return
	 */
	public static int Distance(String s, String t) {
		int d[][];
		int n;
		int m;
		char s_i; //current char from string s
		char t_j; //current char from string t
		int cost;

		n = s.length();
		m = t.length();
		if (n == 0) {
			return m;
		}
		if (m == 0) {
			return n;
		}
		d = new int[n + 1][m + 1];
		for (int i = 0; i <= n; i++) {
			d[i][0] = i;
		}
		for (int j = 0; j <= m; j++) {
			d[0][j] = j;
		}
		//compare each char from s and t and then determine the distance between the strings
		for (int i = 1; i <= n; i++) {
			s_i = s.charAt(i - 1);
			for (int j = 1; j <= m; j++) {
				t_j = t.charAt(j - 1);
				if (s_i == t_j) {
					cost = 0;
				} else {
					cost = 1;
				}
				d[i][j] = min(d[i - 1][j] + 1, d[i][j - 1] + 1, d[i - 1][j - 1]
						+ cost);
			}
		}
		return d[n][m];
	}

	/**
	 * adds words to the dictionary.
	 * 
	 * @param str
	 *            word to add to the dictionary.
	 */
	public void add(String str) {
		this.dictionary.add(str);
	}

	/**
	 * Generates an arraylist of suggestions for the misspelled words.  
	 * @param str is the misspelled word.  
	 * @return the list of suggestions.  
	 */
	public ArrayList<String> generateSuggestions(String str) {
		returnList = new ArrayList<String>();

		if (this.cachedSuggestedList.containsKey(str)) {
			return this.cachedSuggestedList.get(str);
		}

		int distance = 1;

		while (returnList.size() <= 3) {
			for (String s : dictionary) {
				if (Distance(str, s) < distance) {
					if(!this.returnList.contains(s)){
						returnList.add(s);
					}
				}
				if(returnList.size() > 10){
					break;
				}
			}
			distance++;
		}
		//System.out.println("Corrections for " + str + ":");
		//System.out.println("distance of: " + distance);
		//System.out.println(returnList);

		this.cachedSuggestedList.put(str, returnList);

		return returnList;
	}
}
