//Written by David Pick and Jacob Wise

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;


public class Markov {
	static ArrayList<String> prefixArray = new ArrayList<String>();

	static String[] temp;
	static Prefix prefix;
	int maxWordsGen;
	int maxCharsPerLine;
	static int n;
	HashMap<String, MultiSet> prefixsuffix = new HashMap<String, MultiSet>();
	MultiSet suffixes = new MultiSet();
	LinkedList<String> output = new LinkedList<String>();
	String inputfile;
	int random = 0;
	ArrayList<Integer> rands = new ArrayList<Integer>();

	public Markov(String inputfile, int n, int maxWordsGen, int maxCharsPerLine) {
		this.prefix = new Prefix(n);
		this.maxWordsGen = maxWordsGen;
		this.maxCharsPerLine = maxCharsPerLine + 1;
		this.n = n;
		this.inputfile = inputfile;
		this.getPrefixes();
	}

	public void getPrefixes() {
		BufferedReader in = null;
		int temp;
		int count = 0;
		String tempword = "";
		
		try {
			in = new BufferedReader(new FileReader(inputfile));
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			while ((temp = in.read()) != -1) {
//				System.out.println((char) temp);
				if (Character.isWhitespace(temp) == false){
					tempword += (char) temp;
				}
				else {
					if (tempword != "") {
						prefixArray.add(tempword);
						tempword = "";
					}
				}
			}
			if (tempword != "") {
				prefixArray.add(tempword);
			}
			prefixArray.add("NONWORD");
//			System.out.println(prefixArray);
			for (int i = 0; i < prefixArray.size(); i++) {
				
				if (prefixsuffix.containsKey(prefix.toString())) {
					prefixsuffix.get(prefix.toString()).add(prefixArray.get(i));
//					System.out.println(prefix.toString());
				}
				else if (i < prefixArray.size()){
					MultiSet tempMulti = new MultiSet();
					tempMulti.add(prefixArray.get(i));
//					System.out.println(prefix.toString());
					prefixsuffix.put(prefix.toString(), tempMulti);
				}
				
				prefix.add(prefixArray.get(i));
			}
			Prefix currentPrefix = new Prefix(this.n);
			int kth = 0;
			MultiSet currentMulti = new MultiSet();
			
			for (int i = 0; i < this.maxWordsGen; i++) {
				String currentString = "";
				currentString = currentPrefix.toString();
				currentMulti = prefixsuffix.get(currentString);
				kth = (int) Math.floor(Math.random() * currentMulti.size());
				if (currentMulti.findKth(kth) == "NONWORD") {
//					System.out.println("NONWORD");
					break;
				}
//				System.out.println	(i + " " + currentString + " " + currentMulti.findKth(kth));
//				System.out.println(currentMulti.findKth(kth));
				output.add(currentMulti.findKth(kth).toString());
				currentPrefix.add(currentMulti.findKth(kth).toString());
			}
//			System.out.println(output.toString());
			Justify();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void Justify() {
		int count = 0;
		int numspaces = 0;
		LinkedList<String> templist = new LinkedList<String>();
//		System.out.println(output.size());
		for (int i = 0; i < output.size(); i++) {
			count += output.get(i).length();
			if (count < this.maxCharsPerLine) {
				if (i != output.size() - 1 && count + output.get(i + 1).length() < this.maxCharsPerLine) {
					if (output.get(i).endsWith(".") || output.get(i).endsWith("?") || output.get(i).endsWith("!")) {
						templist.add(output.get(i) + "  ");
						count += 2;
					}
					else {
						templist.add(output.get(i) + " ");
						count += 1;
					}
				}
				else {
					templist.add(output.get(i) + " ");
					count += 1;
				}
					
			}
			else {
				numspaces = spacestoadd(templist);
//				System.out.println(numspaces);
				lineJustify(templist, numspaces);
				templist = new LinkedList<String>();
				count = 0;
				numspaces = 0;
				i = i - 1;
			}
		}
		printline(templist);
	}
	
	public int spacestoadd(LinkedList<String> list) {
		int count = 0;
		for (int i = 0; i < list.size(); i++) {
			count += list.get(i).length();
		}
		count = this.maxCharsPerLine - count;
//		System.out.println(count);
		return count;
	}
	
	public void lineJustify(LinkedList<String> list, int numspaces) {
		if (numspaces == 0) {
			printline(list);
		}
		else if (list.size() - 1 == numspaces) {
			for (int i = 0; i < list.size() - 1; i++) {
				list.set(i, (list.get(i) + " "));
			}
			printline(list);
		}
		else if (list.size() - 1 < numspaces){
			for (int i = 0; i < list.size() - 1; i++) {
				list.set(i, (list.get(i) + " "));
			}
			numspaces = numspaces - (list.size() - 1);
			lineJustify(list, numspaces);
		}
		else {
//			System.out.println("list size: " + list.size());
			while (rands.size() < numspaces) {
				random = (int) Math.floor(Math.random() * (list.size() - 1));
				if(!rands.contains(random)) {
					rands.add(random);
//					System.out.println(rands + " " + numspaces);
				}
			}
			if (list.get(list.size() - 1).endsWith(".  ")) {
				while (rands.size() < numspaces + 1) {
					random = (int) Math.floor(Math.random() * (list.size() - 1));
					if(!rands.contains(random)) {
						rands.add(random);
					}
				}
			}
			
			for (int i = 0; i < rands.size(); i++) {
				list.set(rands.get(i), (list.get(rands.get(i)) + " "));
			}
			printline(list);
		}
		
		rands = new ArrayList<Integer>();
	}
	
	public void printline(LinkedList<String> list) {
		for (int i = 0; i < list.size(); i++) {
			if (i == list.size() - 1) {
				if (list.get(i).endsWith(".  ")) {
//					System.out.println("here");
//					System.out.print(" ");
					System.out.print(list.get(i).substring(0, list.get(i).length() - 2));
				}
				else {
					System.out.print(list.get(i).substring(0, list.get(i).length() - 1));
				}
			}
			else {
				System.out.print(list.get(i));
			}
		}
		System.out.println("");
	}
}