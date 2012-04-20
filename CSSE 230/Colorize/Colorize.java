import java.io.*;
import java.util.Scanner;


public class Colorize {
	int currentstate = 0;
	int previousstate = 0;
	int nextstate = 0;
	boolean readyToPrint = false;
	String toprint = "";
	String green = "<font color = 'green'>";
	String red = "<font color = 'red'>";
	String blue = "<font color = 'blue'>";
	String currentword = "";
	char previousinput = ' ';
	String [] keyWords = {
			  "abstract", "double", "int", "strictfp", "boolean",
			  "else", "interface", "super", "break", "extends",
			  "long", "switch", "byte", "final", "native",
			  "synchronized", "case", "finally", "new", "this", "catch",
			  "float", "package", "throw", "char", "for", "private",
			  "throws", "class", "goto", "protected", "transient",
			  "const", "if", "public", "try", "continue", "implements",
			  "return", "void", "default", "import", "short", "volatile",
			  "do", "instanceof", "static", "while", "enum"
			  };
	boolean mightbekeywork = false;
	String previousword = "";
	
	public Colorize() {
		this.currentstate = 0;
		this.nextstate = 0;
		this.previousstate = 0;
	}
	//Implement finite state machine, using single character input
	public void nextstate(int currentstate, char input, boolean newline) {
		switch (currentstate) {
			//look for comments and quotes
			case 0:
				if (input == '/')
					this.nextstate = 1;
				else if (input == '\'')
					this.nextstate = 6;
				else if (input == '"')
					this.nextstate = 2;
				else 
					this.nextstate = 0;
				break;
			//saw-slash
			case 1:
				if (input == '*')
					this.nextstate = 3;
				else if (input == '/')
					this.nextstate = 5;
				else
					this.nextstate = 0;
				break;
			//saw quote
			case 2:
				if (input == '"')
					this.nextstate = 0;
				else
					this.nextstate = 2;
				break;
			//read until end of comment
			case 3:
				if (input == '*')
					this.nextstate = 4;
				else
					this.nextstate = 3;
				break;
			//saw star, check to see if comment done
			case 4:
				if (input == '*')
					this.nextstate = 4;
				else if (input == '/')
					this.nextstate = 0;
				else
					this.nextstate = 3;
				break;
			//look for new line
			case 5:
				if (input == '\n' || input == '\r' || newline)
					this.nextstate = 0;
				else
					this.nextstate = 5;
				break;
			//check for single quotes
			case 6:
				if (input == '\'')
					this.nextstate = 0;
				else
					this.nextstate = 6;
		}
	}
	
	public void StringtoPrint(char input, boolean newline) {
		//find next state
		this.nextstate(this.currentstate, input, newline);
		
		System.out.println(this.toprint + "-" + this.previousstate + "-" + this.currentstate + "-" + this.nextstate);
		//comment ended turn text green
		if (this.currentstate == 5 && this.nextstate == 0) {
//			this.toprint = this.toprint.substring(1);
			System.out.println(this.toprint);
			this.toprint = this.green + this.toprint + input + "</font>";
			this.readyToPrint = true;
		}
		//quote ended, turn text red
		else if (this.currentstate == 2 && this.nextstate == 0) {
			this.toprint = this.red + this.toprint + input + "</font>";
			this.readyToPrint = true;
		}
		//comment ended, turn text green
		else if (this.currentstate == 4 && this.nextstate == 0) {
//			this.toprint = this.toprint.substring(1);
			System.out.println(this.toprint);
			this.toprint = this.green + this.toprint + input + "</font>";
			this.readyToPrint = true;
		}
		else if (input == ' ' && this.currentstate == 0 && this.nextstate == 0) {
			this.toprint += input;
			this.readyToPrint = true;
		}
		//turn first / in comment green *special case
		else if (input == '/' && this.currentstate == 0 && this.nextstate == 1) {
			System.out.println(this.nextstate);
			this.toprint += this.green + input + "</font>";
			this.readyToPrint = true;
		}
		//turn first " red *special case
		else if (input == '"' && this.currentstate == 0) {
			this.toprint += this.red + input + "</font>";
			this.readyToPrint = true;
		}
		
		else {
			//properlly display < and > signs with html code
			if (input == '>') {
				this.toprint += "&gt;";
			}
			else if (input == '<')
				this.toprint += "&lt;";
			else if (input == '&')
				this.toprint += "&amp;";
			else
				this.toprint = this.toprint + input;
			this.readyToPrint = false;
		}
		
		//look for keywords
		this.keyword(input);
		
		this.previousinput = input;
		this.previousstate = this.currentstate;
		this.currentstate = this.nextstate;
	}
	
	public void keyword(char input) {
		//check to see if current word is a keyword, and not inside another word
		//turn it blue if it is
		if(this.currentstate == 0) {
			//System.out.println(this.currentword + "-" + input);
			if (input != ' ' && input != '[' && input != '.' && input != '(' && input != '	' && input != '\n' && input != '/' && input != '"')
				currentword += input;
			else {
				this.isKeyword(this.currentword);
				this.readyToPrint = true;
				currentword = "";
			}
		}
	}
	
	//helper method for finding keywords
	public void isKeyword(String word) {
		String temp = "";
		for (int i = 0; i < this.keyWords.length; i++) {
			if (this.keyWords[i].equals(word)) {
				temp = this.toprint.substring(this.toprint.length() - 1);
				this.toprint = this.blue + this.toprint.substring(0, this.toprint.length() - 1) + "</font>";
				this.toprint += temp;
			}
		}
	}

	public static void main(String[] args) {
		//open input and output files
		File inputfilename = new File(args[0] + ".java");
		String outputfilename = args[0] + ".html";
		int i = 0;
		char c = 'a';
		
		try {
			FileReader sc = new FileReader(inputfilename);
			PrintWriter out = new PrintWriter(new FileWriter(outputfilename));
			Colorize test = new Colorize();
			
			out.print("<html>\n");
			out.print("<body>\n");
			out.print("<pre>\n");
			out.print("<font color = 'black'>");
			//read file in char by char
			while(i != -1) {
				i = sc.read();
				c = (char) i;
				test.StringtoPrint((char) i, false);
				//check to see if ready to print
				
				//if ready print correct output
				if (test.readyToPrint || (char) i == '\n' && test.currentstate != 3) {
					out.print(test.toprint);
					test.toprint = "";
				}
			}
			out.print("</font>\n");
			out.print("</pre>\n");
			out.print("</body>\n");
			out.print("</html>\n");
			out.close();
		} catch (IOException e)	{
			e.printStackTrace();
		}
	}

}
