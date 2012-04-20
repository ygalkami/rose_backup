import junit.framework.TestCase;
import java.math.BigInteger;


public class BigRationalTest extends TestCase {
	BigInteger numer = new BigInteger("6");
	BigInteger denom = new BigInteger("8");
	BigRational value = new BigRational(numer, denom);
	
	public void testzero() {
		BigInteger testnumer = new BigInteger("7");
		BigInteger testdenom = new BigInteger("0");
		try{
			BigRational testvalue = new BigRational(testnumer, testdenom);
		}
		catch(ArithmeticException e){
			return;
		}
		fail("You Fail");

	}
	
	public void testToString() {
	assertEquals("6/8", value.toString());
	}

	public void testReduce() {
		//BigRational test = new BigRational(numer, denom);
		assertEquals("3/4", value.reduce().toString());
	}
	
	public void testequals() {
		BigInteger testnumer = new BigInteger("7");
		BigRational test = new BigRational(numer, denom);
		BigRational falsetest = new BigRational(testnumer, denom);
		assertEquals(true, value.equals(test));
		assertEquals(false, value.equals(falsetest));
	}
	
	public void testCompareTo() {
		BigInteger testnumer = new BigInteger("7");
		BigInteger testdenom = new BigInteger("8");
		BigRational testvalue = new BigRational(testnumer, testdenom);
		
		assertEquals(-1, value.compareTo(testvalue));
		assertEquals(1, testvalue.compareTo(value));
		assertEquals(0, value.compareTo(value));
	}
	
	public void testabs() {
		BigInteger testnumer = new BigInteger("-7");
		BigInteger testdenom = new BigInteger("8");
		BigRational testvalue = new BigRational(testnumer, testdenom);
		BigRational testvalue2 = new BigRational(testdenom, testnumer);
		
		assertEquals("7/8", testvalue.abs().toString());
		assertEquals("8/7", testvalue2.abs().toString());
	}
	
	public void testadd() {
		BigInteger testnumer = new BigInteger("3");
		BigInteger testdenom = new BigInteger("4");
		BigRational test = new BigRational(testnumer, testdenom);
		
		assertEquals("3/2", test.add(value).toString());
	}
	
	public void testdivide() {
		BigInteger testnumer = new BigInteger("3");
		BigInteger testdenom = new BigInteger("4");
		BigRational test = new BigRational(testnumer, testdenom);
		
		assertEquals("1/1", value.divide(test).toString());
	}
	
	public void testMultiply() {
		BigInteger testnumer = new BigInteger("3");
		BigInteger testdenom = new BigInteger("4");
		BigRational test = new BigRational(testnumer, testdenom);
		
		assertEquals("9/16", value.multiply(test).toString());
	}
	
	public void testNegate() {
		BigInteger testnumer = new BigInteger("-3");
		BigInteger testdenom = new BigInteger("4");
		BigRational test = new BigRational(testnumer, testdenom);
		
		assertEquals("-3/4", test.negate().toString());
	}
	
	public void testsubtract(){
		BigInteger testnumer = new BigInteger("2");
		BigInteger testdenom = new BigInteger("4");
		BigRational test = new BigRational(testnumer, testdenom);
		
		assertEquals("1/4", value.subtract(test).toString());
	}
	
	public void testpower() {
		assertEquals("9/16", value.power(2).toString());
	}
	
	public void testreciprocal() {
		assertEquals("4/3", value.reciprocal().toString());
	}
	
	public void testremainder() {
		assertEquals("6", value.remainder().toString());
	}
	
}
