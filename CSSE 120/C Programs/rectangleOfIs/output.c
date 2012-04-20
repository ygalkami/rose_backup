#include <stdio.h>

void rectangleOfIs(int numRows, int numCols)
	{
		int i, j;
		for (i=1; i<= numRows; i++)
			{
				for(j=1; j<=numCols; j++)
					{
						printf ("%d", i);
					}
				printf ("\n");
			}
	}

int main()
	{
		rectangleOfIs(3, 8);
	}
	