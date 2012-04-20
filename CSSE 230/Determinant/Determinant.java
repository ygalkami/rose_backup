import java.util.ArrayList;


public class Determinant {
	public static int ignorecol2 = 0;
	
	
	public static int det(int[][] a) throws IllegalArgumentException {
		if (a == null)
			throw new IllegalArgumentException("Can't be null");
		for (int i = 0; i < a.length; i++) {
			if (a.length != a[i].length)
				throw new IllegalArgumentException ("Must be a square matrix");
		}
		return determinant(a, a.length);
	}
	
	public static int determinant(int[][] a, int n )
	{
	    int i, j, j1, j2;
	    int sum = 0;
	    int[][] m = new int[6][6];

	    if (n == 2)                                // terminate recursion
	    {
	        sum = a[0][0]*a[1][1] - a[1][0]*a[0][1];
	    }
	    if (n == 1)
	    	sum = a[0][0];
	    else 
	    {
	        sum = 0;
	        for (j1 = 0; j1 < n; j1++ )            // do each column
	        {
	            for (i = 1; i < n; i++)            // create minor
	            {
	                j2 = 0;
	                for (j = 0; j < n; j++)
	                {
	                    if (j == j1) 
	                    	continue;
	                    m[i-1][j2] = a[i][j];
	                    j2++;
	                }
	            }
	            
	            // sum (+/-)cofactor * minor  
	            sum = (int) (sum + Math.pow(-1.0, j1) * a[0][j1] * determinant(m, n-1));
	        }
	    }

	    return sum;
	}


	public static void main(String[] args) {
		int[][] test = new int[4][4];
		test[0][0] = 100;
		test[0][1] = 300;
		test[0][2] = 500;
		test[0][3] = 700;
		test[1][0] = 150;
		test[1][1] = 375;
		test[1][2] = 550;
		test[1][3] = 750;
		test[2][0] = 200;
		test[2][1] = 400;
		test[2][2] = 600;
		test[2][3] = 800;
		test[3][0] = 250;
		test[3][1] = 450;
		test[3][2] = 650;
		test[3][3] = 875;
		
		int[][] test2 = new int[3][3];
		test2[0][0] = 1;
		test2[0][1] = 3;
		test2[0][2] = 5;
		test2[1][0] = 2;
		test2[1][1] = 5;
		test2[1][2] = 6;
		test2[2][0] = 3;
		test2[2][1] = 5;
		test2[2][2] = 9;
		
		int[][] test3 = new int[1][1];
		test3[0][0] = 5;
//		System.out.println(Determinant.det(test3));
//		System.out.println(test.length);
	}

}
