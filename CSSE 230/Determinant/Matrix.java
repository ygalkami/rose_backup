/**
 * This class implements a nxm matrix. The matrix elements are double values.
 *
 * @author   Holger Schmid
 * @version  12.07.99
 */
public class Matrix
{
   int n, m;     // number of rows and columns in matrix
   double M[][]; // matrix values
   
	/** Constructs an empty nxm matrix.
    *  @param   rows   number of rows
    *  @param   columns   number of columns
    */
	public Matrix(int rows, int columns)
   {
      n = rows;
      m = columns;
      M = new double[n][m];
      return;
   }
	
	public Matrix(double[][] test) {
		this.M = test;
	}
	
	/** Constructs a new matrix by copying an other one
	/*  @param   mat   the matrix to be copyied
	 */
	public Matrix(Matrix mat)
   {
   	int i, j;
   	
      n = mat.getRows();
      m = mat.getColumns();
      M = new double[n][m];
   	
   	for (i=0; i<n; i++)
   		for (j=0; j<m; j++)
   		   M[i][j] = mat.getElement(i, j);
   	return;
   }
   
   /** Returns the number of rows of the matrix
    *  @return   number of rows
    */
   public int getRows()
   {
   	return n;
   }
   	
   /** Returns the number of columns of the matrix
    *  @return   number of columns
    */
   public int getColumns()
   {
      return m;
   }
   
	/** Returns the value of a matrix element.
    *  @param   row   row of element
    *  @param   column   column of element
	 */
   public double getElement(int row, int column)
   {
      return M[row][column];
   }
   
   /** Sets the value of a matrix element.
    *  @param   row   row of element
    *  @param   column   column of element
    *  @param   value   value to be set
    */
	public void setElement(int row, int column, double value)
   {
      M[row][column]=value;
      return;
   }

	/** Returns a string represantation of the matrix. The string consists of the 
	 *  matrix element values, seperated by tabs. The rows of the matrix are seperated
	 *  by newlines.
	 *  @return   a string with the values of the matrix
	 */
   public String toString()
   {
   	String result="";
      int i, j;
      for (i=0; i<n; i++)
      {//rows
         for (j=0; j<m; j++)
         {//columns
         	result+=(formatOutput(M[i][j])+"\t");
         }
         result+="\n";
      }
      return result;
   }
   
	/** Exchanges two rows of the matrix.
	 *  @param   row1   the one row to be exchanged
	 *  @param   row2   the other row to be exchanged
	 */
   public void exchangeRows(int row1, int row2)
   {
      int i;
      double temp;
      for (i=0; i<m; i++)
      {
         temp=M[row1][i];
         M[row1][i]=M[row2][i];
         M[row2][i]=temp;
      }
      return;
   }
   
	/** Calculates the determinant of the matrix
	 *  @exception   RuntimeException   "Not a square matrix". Determinants can only be calculated
	 *     on square matrices.
	 *  @return   the determinant of the matrix
	 */
   public double getDeterminant() 
   {
      int i;
      double d=0, sign=1;
      Matrix tempM;

      if (n==m)
      {// only square matrices possible
         if (n==1)
         {
            return M[0][0];
         }
/*      	
      	if (n==2)
         {// abort recursion at 2x2 matrix
            return M[0][0]*M[1][1]-M[0][1]*M[1][0];
         }
*/
         else
         {// recursion on first row
            for (i=0; i<m; i++)
            {
               tempM = subMatrix(0,i);
               d+=sign*M[0][i]*tempM.getDeterminant();
               sign *= -1; // swap sign
            }
         }
         return d;
      }
      else
      {
         throw new RuntimeException("Matrix.getDeterminant: Not a square matrix.");
      }
   }
   
   /** Calculates the permanent of the matrix
    *  @exception   RuntimeException   "Not a square matrix". Permanents can only be calculated
    *     on square matrices.
    *  @return   the permanent of the matrix
    */
	public double getPermanent()
   {
      int i;
      double p=0;
      Matrix tempM;

      if (n==m)
      {// only square matrices possible
         if (n==1)
         {
         	return M[0][0];
         }
         else
         {// recursion on first row
         	for (i=0; i<m; i++)
            {
               tempM = subMatrix(0,i);
               p+=M[0][i]*tempM.getPermanent();
            }
         }
         return p;
      }
      else
      {
         throw new RuntimeException("Matrix.getPermanent: Not a square matrix.");
      }
   }
   
   /** Builds a sub matrix by deleting one row and one column.
    *  @result  the new matrix
    *  @param   row   row to be eliminated
    *  @param   column   column to be eliminated
    */
	public Matrix subMatrix (int row, int column)
   {
      int nR, nW, mR, mW;
      Matrix subM = new Matrix (n-1, m-1);
      
      for (nR=0, nW=0; nR<n; nR++)
      {// loop over all rows
         if (nR!=row)
         {// ignore the row to be deleted
            for (mR=0, mW=0; mR<m; mR++)
            {// loop over all columns
               if (mR!=column)
               {// ignore column to be deleted
                  subM.setElement(nW, mW, M[nR][mR]);
                  mW++;
               }
            }
            nW++;
         }
      }
      return subM;
   }           

   /** Formats a double value for output
    *  @result   the formated value as string
    *  @param    x   the double value to format
    */
   private String formatOutput(double x)
   {
      Integer temp = new Integer((int) x);
      return temp.toString();
   }

}