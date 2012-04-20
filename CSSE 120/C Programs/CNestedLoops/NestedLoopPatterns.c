#include <stdio.h>
//David Pick
/* Your job is to fill in the bodies of the functions so they behave as specified in the homework assignment.

 * It prints the character c, n times. */
void printMultiples(char c, int n) {
	int i;
	for (i=1; i<=n; i++)
		printf("%c", c);
}

/* print a rectangle of numRows rows of numCols stars each */
void rectangleOfStars(int numRows, int numCols) { 
	int i, j;
    for (i=1; i<=numRows; i++) {
       for (j =1; j<=numCols; j++)
          printf("*");	
       printf("\n");
    }
}	

/*  print a triangle of stars  */
void triangleOfStars(int numRows) {
	char s;
	int i;
	int j;
	s = '*';
	for (i=1; i<=numRows; i++)
		{
			for (j=1; j<=i; j++)
				printf("%c", s);
			printf("\n");
		}
}

/*  Print triangle of numRows rows of numbers 
# each number in each row is its row number */
void triangleSameNumEachRow(numRows) {
	int i;
	int j;
	
	for (i=1; i<=numRows; i++)
	{
		for (j=1; j<=i; j++)
			printf("%d", i);
		printf("\n");
	}

}
    
/*  Print triangle of numRows rows  of numbers, each number 
    in each row containing its column number */
void triangleAllNumsEachRow(int numRows) {
	int i;
	int j;
	
	for (i=1; i<=numRows; i++)
	{
		for (j=1; j<=i; j++)
			printf("%d", j);
		printf("\n");
	}
}	


/* Now the right sides of the output lines should be alligned. */        
void triangleNumsRightJustified(int numRows){
	int i;
	int j;
	
	for (i=1; i<=numRows; i++)
	{
		for (j=1; j<=(numRows - i); j++)
			printf(" ");
		for (j=1; j<=i; j++)
			printf("%d", i);
		printf("\n");
	}
}

/* The rows should be centered, as in the eaxkmple on the assignment page. */    
void triangleNumsCentered(int numRows) {
	int i;
	int j;
	
	for (i=1; i<=numRows; i++)
	{
		for (j=1; j<=(numRows - i); j++)
			printf(" ");
		for (j=1; j<=i; j++)
		{
			printf("%d", i);
			printf(" ");
		}
		printf("\n");
	}
}

/* The rows should be centered, and the whole thing should be boxed,
 * as in the example on the assignment page. */
    
void triangleOfStarsInBox(int numRows) {
	int i;
	int j;
	
	for (i=1; i<=(numRows * 2) + 2; i++)
		printf("-");
	printf("\n");
	for (i=1; i<=numRows; i++)
	{
		printf("|");
		for (j=1; j<=(numRows - i); j++)
			printf(" ");
		for (j=1; j<=i; j++)
		{
			printf("*");
			printf(" ");
		}
		for (j=1; j<=(numRows - i); j++)
			printf(" ");
		printf("|");
		printf("\n");
	}
	for (i=1; i<=(numRows * 2) + 2; i++)
		printf("-");
}	


/* As described in the example on the assignment page. */
void numbersIncreasingForward(rows, nums){
	int i;
	int j;
	int k;
	
	for (i=1; i<=rows; i++)
	{
		for (j=1; j<=nums; j++)
		{
			for (k=1; k<=j; k++)
				printf("%d", j);
		}
		printf("\n");
	}
}
   
 
 /* Do not modify the remainder of this code. */
 
 void printTestNumber(int count, char* message) {
 	printf("\n\nTest %d  %s\n\n", count, message);
 }

int main(){
	int testCount = 0;  /* Notice how this variable lets us avoid hard-coding test numbers */
	
	printTestNumber(testCount++, "rectangleOfStars(4, 11)");
	rectangleOfStars(4, 11);
    
	printTestNumber(testCount++, "rectangleOfStars(3, 5)");
	rectangleOfStars(3, 5);
    
	printTestNumber(testCount++, "triangleOfStars(6)");
    triangleOfStars(6);

	printTestNumber(testCount++, "triangleOfStars(1)");
    triangleOfStars(1);

    printTestNumber(testCount++, "triangleOfStars(4)");
    triangleOfStars(4);

    printTestNumber(testCount++, "triangleSameNumEachRow(7)");
    triangleSameNumEachRow(7);

    printTestNumber(testCount++, "triangleSameNumEachRow(5)");
    triangleSameNumEachRow(5);

    printTestNumber(testCount++, "triangleAllNumsEachRow(6)");
    triangleAllNumsEachRow(6);

    printTestNumber(testCount++, "triangleNumsRightJustified(4)");
    triangleNumsRightJustified(4);
 
   printTestNumber(testCount++, "triangleNumsRightJustified(8)");
    triangleNumsRightJustified(8);

    printTestNumber(testCount++, "triangleNumsCentered(9)");
    triangleNumsCentered(9);

    printTestNumber(testCount++, "triangleOfStarsInBox(18)");
    triangleOfStarsInBox(18);

    printTestNumber(testCount++, "triangleOfStarsInBox(3)");
    triangleOfStarsInBox(3);

    printTestNumber(testCount++, "triangleOfStarsInBox(1)");
    triangleOfStarsInBox(1);

    printTestNumber(testCount++, "numbersIncreasingForward(5, 6)");
    numbersIncreasingForward(5, 6);

    printTestNumber(testCount++, "numbersIncreasingForward(4, 8)");
    numbersIncreasingForward(4, 8);
    
    return 0;
}

    
