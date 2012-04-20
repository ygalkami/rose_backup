 /**
 * This class, provided by the instructor, tests the FixedLengthQueue class.
 * 
 * @author Curt Clifton. Created Nov 28, 2007.
 */
public class TestFixedLengthQueue {

	/**
	 * Starts the test.
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		// Tests standard behavior
		FixedLengthQueue q = new FixedLengthQueue(3);
		String testString = "I heard it through the grapevine.";
		String[] splitString = testString.split(" ");
      System.out.println("\n---------- Queue length = 4");
      for (int i = 0; i < splitString.length; i++) {
			q.add(splitString[i]);
			System.out.println(q);
		}
      
      System.out.println("\n---------- Queue length = 4");
      
      q = new FixedLengthQueue(4);
      testString = "I saw her again last night.";
      //Trivia question:  Name the four people who sang that 1960's hit song.
      splitString = testString.split(" ");
      for (int i = 0; i < splitString.length; i++) {
         q.add(splitString[i]);
         System.out.println(q);
      }
		
		// Tests undersized queue
		try {
			q = new FixedLengthQueue(0);
		} catch (IllegalArgumentException e) {
			System.out.println("\nException occurred as expected.");
		}
	}
}
