/*
 * Template file for ints, doubles, and perfect numbers.
 * Template by Curt Clifton, Oct. 24, 2007.
 * TODO: Add your name and the date below
 * Completed by David Pick, 10/26/07.
 */
#include <stdio.h>
#include <float.h>
/* The constant DBL_MAX comes from float.h */

void doublingInt() {
	int i;
	for (i = 1; i > 0; i *= 2)
		printf("%12d\n", i);
	printf("Overflowed!\n");
	printf("%12d\n", i);
}

void doublingDouble() {
	double d;
	int count;
	count = 0;
	for (d = 1.0; d < DBL_MAX; d *= 2.0)
	{
		printf("%5.3e\n", d);
		count++;
	}
	printf("%d", count);
		
}

int isperfect(int n)
{
	int sum, i;
	sum = 0;
	for (i=1; i<n; i++)
	{
		if (n % i == 0)
			sum = sum + i;
	}
	if (sum == n)
	{
		printf("%d is a perfect number\n", n);
		return n;
	}
	else
	{
		printf("%d is not a perfect number\n", n);
		return 0;
	}
}

int main() {
	//doublingInt();
	//doublingDouble(); 
	int i, n, j, input, perfect;
	n = 1;
	j = 0;
	i = 29;
	while(n)
	{
		printf("Enter an integer (negitive to quit): ");
		fflush(stdout);
		scanf("%d", &input);
		if (input >= 0)
			isperfect(input);
		else
		{
			while (j < 2)
			{
				perfect = isperfect(i);
				if (perfect == 0){
				}
				else
				{
					j++;
				}
				i++;
			}
			break;
		}
	}
	return 0;
}
