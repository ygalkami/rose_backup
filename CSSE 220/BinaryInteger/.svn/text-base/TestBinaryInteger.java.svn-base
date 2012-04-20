import junit.framework.TestCase;


public class TestBinaryInteger extends TestCase {
   
   public void testPlus1() {
      assertEquals("0011", BinaryIntegerADT.plus("101", "111"));
   }
   
   public void testPlus2() {
      assertEquals("0011", BinaryIntegerADT.plus("111", "101"));
   }
   
   public void testPlus3() {
      assertEquals("100101", BinaryIntegerADT.plus("101", "001001"));
   }
   
   public void testPlus4() {
      assertEquals("100101", BinaryIntegerADT.plus("001001", "101"));
   }
   
   public void testPlus5() {
      assertEquals("0011", BinaryIntegerADT.plus("001", "0001"));
   }
   
   public void testPlus6() {
      assertEquals("0011", BinaryIntegerADT.plus("0001", "001"));
   }
   
   public void testPlus7() {
      assertEquals("11000001", BinaryIntegerADT.plus("111", "0011111"));
   }
   
   public void testPlus8() {
      assertEquals("11111111010101010101", BinaryIntegerADT.plus("1010101", "01010101010101010101"));
   }   
   
   public void testPlus9() {
      assertEquals("0001", BinaryIntegerADT.plus("0", "0001"));
   }
   
   public void testPlus10() {
      assertEquals("1000000001", BinaryIntegerADT.plus("111111111", "01"));
   }
   
   public void testPlus11() {
      assertEquals("0111110001", BinaryIntegerADT.plus("111111111", "111111"));
   } 
   
   public void testPlus12() {
      assertEquals("0111110001", BinaryIntegerADT.plus("111111", "111111111"));
   }  

}
