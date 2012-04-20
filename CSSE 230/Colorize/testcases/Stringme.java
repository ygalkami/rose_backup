/*
  This file checks "quotes" seen
  in 'HTML' and text that should be
  <font color="blue">green</font> and not blue!

  If anything <b>works</b> here it's NOT extra credit, but still required

  <a href="http://google.com">Is this underlined? Shouldn't be</a>
  Is 5 &lt; 7? and-ell-tee-semicolon is what we should see here

  This is a test of brackets
  // <><><>
  // ><><><
  // <><><>
  &copy; MC Escher.


 */

public class Stringme 
{
    // I really like the word "transmogrify"
    String transmogrify( char[] c ) 
    {
        return new String( c );
        /* even when it's kinda /*silly*/
        // /*tee hee*/ wakka wakka wakka
    }

    String transmogrify( Object o )
    {
        /* muahahaha // */ String ret = ""+o;
        System.out.println(
	   "Careful! <b> <font color=blue> This should be red </font> </b>");
        return ret;
    }
}
