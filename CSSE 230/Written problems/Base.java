class Base
{
    public void foo( Base x )
    {
        System.out.println( "Base.Base " );
    }
    
    public void foo( Derived x )
    {
        System.out.println( "Base.Derived " );
    }
}


