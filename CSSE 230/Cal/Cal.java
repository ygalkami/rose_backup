import java.util.ArrayList;


public class Cal {
	private static final int SUNDAY = 0;  
	private static final int SATURDAY = 6;
	private static final int JANUARY = 0;
	private static final int DAYS_PER_WEEK = 7;
	private static final int WEEKS_PER_MONTH = 6;
	private static final int WIDTH_PER_DAY = 3;
	private static final int MONTHS_PER_YEAR = 12;
		 
	private static final String MONTH_SEPARATOR = "  ";
	private static final String WEEK_HEADER = " S  M Tu  W Th  F  S  ";
	private static final String[] MONTH_NAME={"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
	private static int[] DAYS_PER_MONTH = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	private static ArrayList<Integer> currentDay = new ArrayList<Integer>();
	private int[] first_days = new int[12];
	private boolean[] month_done = {false, false, false, false, false, false, false, false, false, false, false, false};
	private static boolean isLeapYear;
	private static int Months_Per_Row;
	private static int year;
	private static String strYear;
	
	public Cal(String year, int num) {
		this.strYear = year;
		this.year = Integer.parseInt(year);
		if (this.isleapyear(this.year))
			DAYS_PER_MONTH[1] = 29;
		this.Months_Per_Row = num;
		
		for (int i = 0; i < this.Months_Per_Row; i++) {
			currentDay.add(1);
		}
		
		for (int i = 0; i < this.MONTHS_PER_YEAR; i++) {
			this.first_days[i] = this.findFirstDayofMonth(this.findFirstDay(this.year), i);
			if (this.first_days[i] > 7)
				this.first_days[i] = this.first_days[i] % 7;
		}
	}
	
	public boolean isleapyear (int year) {
		if (year % 100 == 0 && year % 400 != 0)
			return false;
		else if (year % 4 == 0)
			return true;
		return false;
	}
	
	public int findFirstDay(int year) {
		int yeardiff = year - 1800;
		int firstday = 3;
		for (int i = 0; i < yeardiff; i++) {
			if (firstday == 6)
				firstday = 0;
			firstday++;
		}
		if (this.isleapyear(year))
			firstday++;
		return firstday;
//		firstday = 1 + 2 * 13 + (3 * (13+1)/5) + this.year + (this.year/4) - (this.year/100) + (this.year/400) + 2;
//		firstday = firstday % 7;
//		return firstday;
	}
	
	public int findFirstDayofMonth(int firstdayofyear, int month) {
		int firstday = 0;
		firstday += this.findFirstDay(this.year);
		for (int i = 0; i < month; i++) {
			firstday += this.DAYS_PER_MONTH[i] % 7;
		}
		return firstday;
	}
	
	public void printYear() {
		int startprint = (WEEK_HEADER.length() * this.Months_Per_Row) / 2;
		startprint = startprint - (this.strYear.length() / 2);
		if (this.Months_Per_Row % 2 == 1)
			startprint += 1;
		for (int i = 0; i < startprint; i++) {
			System.out.print(" ");
		}
		System.out.println(this.year);
		System.out.println("");
	}
	
	public void printMonthNames(int startmonth) {
		int startprint = WEEK_HEADER.length() * this.Months_Per_Row;
		startprint = (startprint / this.Months_Per_Row) - this.WEEK_HEADER.length() / 2 - 2;
		for (int j = startmonth; j < this.Months_Per_Row + startmonth; j++) {
			if (j != startmonth)
				startprint = this.WEEK_HEADER.length() - 3;
			for (int i = 0; i < startprint; i++) {
				System.out.print(" ");
			}
			if (j == this.Months_Per_Row + startmonth - 1)
				System.out.println(this.MONTH_NAME[j]);
			else
				System.out.print(this.MONTH_NAME[j] + " ");
		}
	}
	
	public void printLine(boolean firstline, boolean lastline, int firstmonth) {
		int spacestoadd = 0;
		int currentmonth = 0;
		System.out.println("");
		int count = 0;
		int countdays = 0;
		int countspaces = 0;
		for (int j = firstmonth; j < this.Months_Per_Row + firstmonth; j++) {
			if (this.month_done[j]) {
				spacestoadd++;
				continue;
			}
			if (j != firstmonth) {
				System.out.print("  ");
			}
			if (spacestoadd > 0) {
				spacestoadd = spacestoadd * (this.WEEK_HEADER.length() - 1 * spacestoadd);
				if (countspaces == 1)
					spacestoadd += 6;
				if (this.Months_Per_Row == 6 || this.Months_Per_Row == 12)
					spacestoadd -= 11;
				for (int i = 0; i < spacestoadd; i++) {
					System.out.print(" ");
				}
				countspaces++;
			}
			for (int i = this.currentDay.get(j - firstmonth); countdays < this.DAYS_PER_WEEK; i++) {
				if (i == 1) {
					for (int k = 0; k < this.first_days[j] * this.WIDTH_PER_DAY; k++) {
						if (this.first_days[j] != 7) {
							System.out.print(" ");
						}
					}
					if (this.first_days[j] != 7)
						countdays += this.first_days[j];
				}
				if (i - 1 >= this.DAYS_PER_MONTH[j]) {
					for (int k = 0; k < (7 - countdays) * 3; k++) {
						System.out.print(" ");
					}
					this.month_done[currentmonth] = true;
					break;
				}
				if (i < 10) {
					System.out.print(" " + i + " ");
					count += 3;
				}
				else {
					System.out.print(i + " ");
					count += 2;
				}
				countdays++;
			}
			currentmonth++;
			spacestoadd = 0;
			if (firstline && !lastline) {
				if (this.first_days[j] == 7)
					this.currentDay.set(j - firstmonth, this.currentDay.get(j - firstmonth) + 7);
				this.currentDay.set(j - firstmonth, this.currentDay.get(j - firstmonth) + 7 - this.first_days[j]);
			} else if (!firstline && !lastline)
				this.currentDay.set(j - firstmonth, this.currentDay.get(j - firstmonth) + 7);
			countdays = 0;
			count = 0;
		}
	}
	
	public void printMonth(int startmonth) {
		for (int i = 0; i < this.WEEKS_PER_MONTH; i++) {
			if (i == 0)
				this.printLine(true, false, startmonth);
			else if (i != this.WEEKS_PER_MONTH)
				this.printLine(false, false, startmonth);
			else
				this.printLine(false, true, startmonth);
			
		}
		System.out.println("");
	}
	
	public void printWeekHeader() {
		for (int i = 0; i < this.Months_Per_Row; i++) {
			if (i > 0)
				System.out.print(" " + this.WEEK_HEADER);
			else
				System.out.print(this.WEEK_HEADER);
		}
		
	}
	
	public void printall() {
		System.out.println("");
		System.out.println("");
		System.out.println("");
		this.printYear();
		int month = 0;
		for (int i = 0; i < Math.ceil(12 / this.Months_Per_Row); i++) {
			this.printMonthNames(month);
			this.printWeekHeader();
			this.printMonth(month);
			month += this.Months_Per_Row;
			for (int j = 0; j < this.Months_Per_Row; j++) {
				this.currentDay.set(j, 1);
			}
		}
		System.out.println("");
		System.out.println("");
		System.out.println("");
	}
	
	public static void main(String[] args) {
		Cal test;
		if (args.length == 2) {
			test = new Cal(args[0], Integer.parseInt(args[1]));
		}
		else {
			test = new Cal(args[0], 3);
		}
		test.printall();
	}

}
