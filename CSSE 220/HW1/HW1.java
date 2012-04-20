
public class HW1 {

	public static void main(String[] args) {
		int max, months;
		months = monthsToReach(30000, 500, 0.05);
		max = maxOfThree(5, 5, 4);
		System.out.println("The maximum is " + max);
		System.out.println("Number of Months is " + months);

	}
	public static int maxOfThree (int a, int b, int c) 
	{
		if (a >= b && a >= c)
			return a;
		else if (b >= a && b >= c)
			return b;
		else
			return c;
		
	}
	public static int monthsToReach(double target, double monthlyDeposit, double annualInterestRate)
	{
		double balance = 0;
		int j = 0;
		while(balance < target)
		{
			balance = balance + balance * (annualInterestRate / 12);
			balance = balance + monthlyDeposit;
			j++;
		}
		
		return j;
	}
}
	