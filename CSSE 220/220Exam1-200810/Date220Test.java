import junit.framework.TestCase;

// Note that some of the JUnit tests for methods that you are to write will currently 
// pass by virtue of  everything having default (null or zero) values.  
// You will not get any credit for simply passing those tests.  In general, to 
// get credit for a particular kind of test, your code must pass ALL of 
// the tests of that feature.  

public class Date220Test extends TestCase {
   
   Date220 [] dateList= {new Date220(12, 20, 2007), // 0
                         new Date220(1, 31, 2005),  // 1
                         new Date220(2, 28, 1900),  // 2
                         new Date220(2, 28, 2000),  // 3
                         new Date220(3, 1, 2000),   // 4
                         new Date220(12, 31, 2004), // 5
                         new Date220(1, 1, 2005),   // 6
   };

   public void testIsLeapYear1() {
      assertFalse(Date220.isLeapYear(1903));
   }
   
   public void testIsLeapYear2() {
       assertTrue(Date220.isLeapYear(1904));
   }
  
   public void testIsLeapYear3() {
      assertFalse(Date220.isLeapYear(1900));
  }
   
   public void testIsLeapYear4() {
      assertTrue(Date220.isLeapYear(2000));
  }
   
   
   public void testIsLastDayOfMonth1() {
      assertFalse(dateList[0].isLastDayOfMonth());
  }
   
   public void testIsLastDayOfMonth2() {
      assertTrue(dateList[1].isLastDayOfMonth());
  }
   
   public void testIsLastDayOfMonth3() {
      assertTrue(dateList[2].isLastDayOfMonth());
  }
   
   public void testIsLastDayOfMonth4() {
      assertFalse(dateList[3].isLastDayOfMonth());
  }
 
   public void testToString1() {
      assertEquals("January 31, 2005", dateList[1].toString());
  }
   
   public void testToString2() {
      assertEquals("March 1, 2000", dateList[4].toString());
  }
   
   public void testCompare1() {
      assertEquals(true, dateList[6].compareTo(dateList[1]) < 0);
   }
   
   public void testCompare2() {
      assertEquals(true, dateList[6].compareTo(dateList[1]) < 0);
   }
   
   public void testCompare3() {
      assertEquals(true, dateList[4].compareTo(dateList[3]) > 0);
   }
   
   public void testAdvance1() {
      dateList[0].advanceDay();
      assertEquals("December 21, 2007", dateList[0].toString());
   }
   
   public void testAdvance2() {
      dateList[5].advanceDay();
      assertEquals(dateList[5], dateList[6]);
   }

   public void testAdvance3() {
      dateList[3].advanceDay();
      assertFalse(dateList[3].equals(dateList[4]));
      dateList[3].advanceDay();
      assertTrue(dateList[3].equals(dateList[4]));
   }
   
   public void test2ndConstructor1() {
      assertEquals(dateList[4], new Date220("March", 1, 2000));
   }

   public void test2ndConstructor2() {
      assertEquals(dateList[6], new Date220("January", 1, 2005));
   }
   
   public void test2ndConstructor3() {
      assertEquals("January 1, 2005", 
                   new Date220("January", 1, 2005).toString());
   }
   
   public void testIllegalDate1() {
      try {
         new Date220(4, 31, 2008);
         fail("There is no April 31");
      } catch (IllegalArgumentException e) {

      }
   }
   
   public void testIllegalDate2() {
      try {
         new Date220(2, 29, 1900);
         fail("1900 was not a leap year");
      } catch (IllegalArgumentException e) {

      }
   } 
   
   public void testIllegalDate3() {
      try {
         new Date220("Semptembuary", 29, 1900);
         fail("Illegal month name");
      } catch (IllegalArgumentException e) {

      }
   }   

}
