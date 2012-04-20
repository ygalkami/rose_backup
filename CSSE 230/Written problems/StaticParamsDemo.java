class StaticParamsDemo
{
    public static void whichFoo( Base arg1, Base arg2 )
    {
        arg1.foo( arg2 );
    }

    public static void main( String [ ] args )
    {
        Base b = new Base( );
        Derived d = new Derived( );

        whichFoo( b, b );  // 1
        whichFoo( b, d );  // 2
        whichFoo( d, b );  // 3
        whichFoo( d, d );  // 4
    }
}