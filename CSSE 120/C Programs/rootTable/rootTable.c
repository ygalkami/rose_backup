#include <stdio.h>
#include <math.h>

void printRootTable(int n)
	{
		int i;
		for (i=1; i<=n; i++)
			{
				printf(" %2d %7.3f\n", i, sqrt(i));
			}
	}
	
int main()
	{
		printRootTable(10);
		return 0;
	}
	