import java.io.*;

/* MyClass.java
   Enters an infinite loop
 */

public abstract class Keywords {
    public static void main(String args[]) {
	return;
    }

    // Implement this nice abstract method please
    protected abstract int doThing(float x);
    // but leave this alone
    private char getThing(double y) {
	Integer g = new Integer(5);
	int n = 5;
	if(n == 4) {
	    switch(n) {
	    case 1:
	    case 2:
	    default:
		break;
	    }
	} else {
	    if(g instanceof Integer) {
		while(true) {
		    do {
			continue;
		    } while(false);
		}		   
	    }
	}
	return 42;
    }    
}


