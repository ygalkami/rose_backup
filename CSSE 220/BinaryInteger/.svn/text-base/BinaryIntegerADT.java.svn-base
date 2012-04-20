
public class BinaryIntegerADT {
   
   // Don't forget that these integers are written least-significant bit first.

   static String plus(String s1, String s2) {
     String result = "";
     char carryout = '0';
     int changelength = Math.max(s1.length(), s2.length()) - Math.min(s1.length(), s2.length());
     System.out.println("changelength " + changelength);
     
     if (s1.length() > s2.length()) {
    	 for (int i = 0; i < changelength; i++) {
    		 s2 += 0;
    	 }
     }
     else {
    	 for (int i = 0; i < changelength; i++) {
    		 s1 += 0;
    	 }
     }
     System.out.println(s1);
     System.out.println(s2);
     
     for (int i = 0; i < Math.min(s1.length(), s1.length()); i++) {
    	 System.out.println(s1.charAt(i) + " " + s2.charAt(i) + " " + carryout);
    	 if (s1.charAt(i) == '0' && s2.charAt(i) == '0' && carryout == '0') {
    		 result += '0';
    	 }
    	 else if (s1.charAt(i) == '1' && s2.charAt(i) == '1' && carryout == '0') {
    		 result += '0';
    	 }
    	 else if (s1.charAt(i) == '0' && s2.charAt(i) == '0' && carryout == '1') {
    		 result += '1';
    	 }
    	 else if (s1.charAt(i) == '1' && s2.charAt(i) == '1' && carryout == '1') {
    		 result += '1';
    	 }
    	 else if (s1.charAt(i) == '1' || s2.charAt(i) == '1') {
    		 if (carryout == '1') {
    			 result += '0';
    		 }
    		 else {
    			 result += '1';
    		 }
    	 }
    	 
    	 if (i == Math.min(s1.length(), s1.length()) - 1) {
    		 if (carryout == '1')
    			 result += '1';
    	 }
    	 carryout = carry(s1.charAt(i), s2.charAt(i), carryout);
    	 System.out.println(result);
     }
     if (carryout == 0) {
	     if (Math.max(s1.length(), s2.length()) == s1.length() && changelength != 0) {
	    	 result += s2.substring(changelength);
	     }
	     else if (Math.max(s1.length(), s2.length()) == s2.length() && changelength != 0) {
	    	 result += s1.substring(changelength);
	     }
     }
     else {
    	 
     }
      return result;
   }
   
   static char carry(char a, char b, char carry) {
	   String returnedcarry;
	   
	   if (a == '1' && b == '1' && carry == '0') {	
		   return '1';
	   }
	   else if (a == '1' && b == '1' && carry == '1') {
		   return '1';
	   }
	   else if (a == '0' && b == '0' && carry == '1') {
		   return '0';
	   }
	   else if (a == '0' && b == '1' && carry == '1') {
		   return '1';
	   }
	   else if (a == '1' && b == '0' && carry == '1') {
		   return '1';
	   }
	   else {
		   return '0';
	   }
   }
    
   static String addOne(String s) {
      if (s.isEmpty())
         return "1";
      if (s.charAt(0) == '0')
         return "1" + s.substring(1);
      return "0" + addOne(s.substring(1));
   }
   

}
