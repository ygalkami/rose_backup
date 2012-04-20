
public class GreetingThreadTester{
   
   public static void main(String[] args){
      
      // Create the two Runnable objects
      GreetingRunnable r1 = new GreetingRunnable("Hello, World!");
      GreetingRunnable r2 = new GreetingRunnable("Goodbye, World!");
      
      // Create the threads from the Runnable objects
      Thread t1 = new Thread(r1);
      Thread t2 = new Thread(r2);
      
      // Start the threads running
      t1.start();
      t2.start();
   }
}

