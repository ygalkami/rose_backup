import java.util.Arrays;

/**
 * Represents a date on the Gregorian calendar
 */
public class Date220 implements Comparable<Date220>{
   
   /**
    * array of month names
    */
   public static final String[] monthName = {"January", "February", "March",
                                             "April", "May", "June",
                                             "July", "August", "September",
                                             "October", "November", "December"};
   
   /**
    * array of month lengths (February's length is for a non-leap-year)
    */
   public static final int [] monthLength = {31, 28, 31, 30, 31, 30,
                                             31, 31, 30, 31, 30, 31};
   // instance variables
   private int month, day, year;
   
   /**
    * Construct a date from three numeric components.  
    * @param month  The month of the year.  1 = Jan, 2 = Feb, etc.
    * @param day    The day of the month.  Must be in the correct range for that month
    * @param year   The (4-digit) year
    * @throws IllegalArgumentException if given an improper month or day number
    */
   public Date220(int month, int day, int year) throws IllegalArgumentException {
      // Note that the input month is in the "human friendly" 1-12 range, 
      // but the subscripts of the two arrays I gave you are 0-11. 
     this.month = month - 1;

     if (monthLength[this.month] < day) {
    	 System.out.println(isLeapYear(year));
    	 if (isLeapYear(year) == false)
    		throw new IllegalArgumentException("Not a real day");
    	 else if (this.month == 1 && this.day > 29)
    		 throw new IllegalArgumentException("Not a real day");
    	 else
    		 throw new IllegalArgumentException("Not a real day");
     }
     
     this.day = day;
     this.year = year;
     
   }
   
   /**
    * Construct a date from month name, day, and year
    * 
    * @param mName Name of month.  Must be one of the strings from monthName.
    * @param day  Day of month.  Same constarints as other constructor
    * @param year 4-didig year number
    * @throws IllegalArgumentException if <i>mName</i> is not a valid month name or day is not legal for given month and year
    */
   public Date220(String mName, int day, int year)throws IllegalArgumentException {
     this.month = -1; 
     for (int i = 0; i < 12; i++) {
    	 if (monthName[i] == mName) {
    		 this.month = i;
    	 }
     }
     if (this.month == -1) {
		 throw new IllegalArgumentException("Not a month");
	 }
     if (monthLength[this.month] < this.day) {
    	 throw new IllegalArgumentException("Not a real day");
     }
     this.day = day;
     this.year = year;
     
     //System.out.println(this.month + ", " + this.day + ", " + this.year);
   }
   
   /**
    * returns a String representing this date in the form "December 6, 2005"<br />
    * Name of month comes from the <i>monthName</i> array, there will be exactly one space after the month name and after the comma
    */
   public String toString() {
      String date = this.monthName[this.month] + " " + this.day + ", " + this.year;
      return date;
   }
   
   /**
    * Returns true if a given year is a leap year, false otherwise
    * 
    * @param year  4-digit year number
    * @return true if <i>year</i> is a leap year, false otherwise
    */
   public static boolean isLeapYear(int year) {
      if (year % 4 != 0)
         return false;
      if (year % 100 == 0)
         return year%400 == 0;
      return true;
   }
   
   /**
    * Returns true if this day is the last day of its month, false otherwise
    * 
    * @return true if this day is the last day of its month, false otherwise
    */
   public boolean isLastDayOfMonth() {
      int lastday = this.monthLength[this.month];

      if (this.day == lastday && isLeapYear(this.year) == false){
    	  return true;
      }
      else if (this.day == lastday + 1 && isLeapYear(this.year) == true) {
    	  return true;
      }
      else
    	  return false;
   }
   
   /**
    * Is this date the same as <i>other</i>?
    */
   @Override
   public boolean equals(Object other){
      if (! (other instanceof Date220))
            return false;
      Date220 oth = (Date220)other;
      return this.month == oth.month &&
             this.day == oth.day &&
             this.month == oth.month;
   }
   
   /**
    * returns a number that is negative, zero, or positive, according as this date is before, the same as, or after <i>other</i>
    */
   public int compareTo (Date220 other) {
	   if (this.year + this.monthLength[this.month] + this.day > other.year + other.month + other.day) {
		   if (this.month > other.month) {
			   return 1;
		   }
		   return -1;
	   }
	   else if (this.year + this.monthLength[this.month] + this.day < other.year + other.month + other.day) {
		   if (this.month < other.month) {
			   return -1;
		   }
		   return 1;
	   }
	return 0;
   }
   
   /**
    * moves this date to the next calendar day
    */
   public void advanceDay() {
	   if (isLeapYear(this.year) == false) {
		   if (this.day != monthLength[this.month]) {
			   this.day = this.day + 1;
		   }
		   else if (this.month != 11) { 
			   this.month = this.month + 1;
			   this.day = 1;
		   }
		   else {
			   this.month = 0;
			   this.day = 1;
			   this.year = this.year + 1;
		   }
	   }
	   else {
		   if(this.month == 1 && this.day == 28) {
			   this.day = 29;
		   }
		   else if(this.month == 1 && this.day == 29) {
			   this.day = 1;
			   this.month = this.month + 1;
		   }
		   else {
			   if (this.day != monthLength[this.month]) {
				   this.day = this.day + 1;
			   }
			   else if (this.month != 11) { 
				   this.month = this.month + 1;
				   this.day = 1;
			   }
			   else {
				   this.month = 0;
				   this.day = 1;
				   this.year = this.year + 1;
			   }
		   }
	   }
	   
   }
}
