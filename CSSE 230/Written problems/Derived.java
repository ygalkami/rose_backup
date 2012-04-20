class Derived extends Base
{
    public void foo( Base x )
    {
        System.out.println( "Derived.Base " );
    }
    
    public void foo( Derived x )
    {
        System.out.println( "Derived.Derived " );
    }
}