/***********************************************************************
 * CSSE 120 Final Exam
 * Rose-Hulman Institute of Technology
 * Nov. 9, 2007
 ***********************************************************************/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define REPORT_WIDTH 60

/**************************************************************************
 * YOUR CODE BEGINS HERE -- YOUR CODE BEGINS HERE -- YOUR CODE BEGINS HERE
 *************************************************************************/

void printCharRange(char start, char end) {
	int i;

	for (i=start; i <= end; i++){
		printf("%c", i);
	}
}

int isvowel(char c) {
	int i;
	if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u')
		return 1;
	else if (c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U')
		return 1;
	else
		return 0;
			 
}

int countvowels(char *str) {
	int i, j;
	j = 0;
	int len = strlen(str);
	for (i=0; i < len; i++){
		if (str[i] == 'a' || str[i] == 'e' || str[i] == 'i' || str[i] == 'o' || str[i] == 'u')
			j++;
		else if (str[i] == 'A' || str[i] == 'E' || str[i] == 'I' || str[i] == 'O' || str[i] == 'U')
			j++;
	}
	return j;		
}

void printHourGlass(int n) {
	int i, j, k;
	for (i=0; i<n; i = i + 2){
		printf("|");
		for (k=0; k<i/2; k++)
			printf(" ");
		for (j=0; j<n - i; j++)
			printf("*");
		for (k=0; k<i/2; k++)
			printf(" ");
		printf("|\n");
	}
	for (i=1; i<=n-1; i = i + 2){
		printf("|");
		for (k=0; k<(n - i)/2-1; k++)
			printf(" ");
		for (j=0; j<=i+1; j++)
			printf("*");
		for (k=0; k<(n - i)/2-1; k++)
			printf(" ");
		printf("|\n");
	}
}

typedef struct {
	int x1;
	int x2;
	int y1;
	int y2;
} Rectangle;

Rectangle makeRect(int x1, int y1, int x2, int y2) {
	Rectangle answer;
	answer.x1 = x1;
	answer.x2 = x2;
	answer.y1 = y1;
	answer.y2 = y2;

	return answer;
}

int getLeft(Rectangle r) {
	if (r.x1 < r.x2)
		return r.x1;
	else
		return r.x2;
}

int getRight(Rectangle r) {
	if (r.x1 > r.x2)
		return r.x1;
	else
		return r.x2;
}

int getTop(Rectangle r) {
	if (r.y1 > r.y2)
		return r.y1;
	else
		return r.y2;
}

int getBottom(Rectangle r) {
	if (r.y1 < r.y2)
		return r.y1;
	else
		return r.y2;
}

int areIntersecting(Rectangle q, Rectangle r) {
	/*if (getTop(q) <= getTop(r))
		return 1;
	else if (getBottom(q) >= getBottom(r))
		return 1;
	else if (getRight(q) <= getRight(r))
		return 1;
	else if (getLeft(q) >= getLeft(r))
		return 1;
	else if (getTop(r) <= getTop(q))
		return 1;
	else if (getBottom(r) >= getBottom(q))
		return 1;
	else if (getRight(r) <= getRight(q))
		return 1;
	else if (getLeft(r) >= getLeft(q))
		return 1;
	else
		return 0;*/
	
	if (getTop(q) <= getTop(r) && getTop(q) >= getBottom(r))
		return 1;
	else if (getRight(q) <= getRight(r) && getRight(q) >= getLeft(r))
		return 1;
	else if (getTop(r) <= getTop(q) && getTop(r) >= getBottom(q))
		return 1;
	else if (getRight(r) <= getRight(q) && getRight(r) >= getLeft(q))
		return 1;
	else if (getBottom(q) <= getBottom(r) && getBottom(q) >= getTop(r))
		return 1;
	else if (getLeft(q) <= getLeft(r) && getLeft(q) >= getRight(r))
		return 1;
	else if (getBottom(r) <= getBottom(q) && getBottom(r) >= getTop(q))
		return 1;
	else if (getLeft(r) <= getLeft(q) && getLeft(r) >= getRight(q))
		return 1;
	else
		return 0;
		
		
	
}

Rectangle intersect(Rectangle q, Rectangle r) {
	int x1, x2, y1, y2;
	if (getRight(q) >= getRight(r))
		x2 = getRight(r);
	if (getRight(r) >= getRight(q))
		x2 = getRight(q);
	if (getLeft(q) >= getLeft(r))
		x1 = getLeft(q);
	if (getLeft(r) >= getLeft(q))
		x1 = getLeft(r);
	if (getTop(q) >= getTop(r))
		y1 = getTop(r);
	if (getTop(r) >= getTop(q))
		y1 = getTop(q);
	if (getBottom(q) >= getBottom(r))
		y2 = getBottom(q);
	if (getBottom(r) >= getBottom(q))
		y2 = getBottom(r);
	
	printf("x1: %d, x2: %d, y1: %d, y2: %d\n", x1, x2, y1, y2);
	return makeRect(x1, y1, x2, y2);
}

/**************************************************************************
 * YOUR CODE ENDS HERE -- YOUR CODE ENDS HERE -- YOUR CODE ENDS HERE
 *************************************************************************/


/**************************************************************************
 * Testing helper functions
 *************************************************************************/
void printTestHeader(char *testName) {
	int i;
	printf("\n\n");
	for (i=0; i<REPORT_WIDTH; i++)
		putchar('-');
	putchar('\n');
	printf("Testing ");
	printf("%s", testName);
	printf(":\n");
	for (i=0; i<REPORT_WIDTH; i++)
		putchar('-');
	putchar('\n');
}

void printTestFooter(char *label, int passed, int tested) {
	int barLen = REPORT_WIDTH - strlen(label) - 17;
	int i;
	for (i=0; i<barLen; i++)
		putchar('=');
	
	printf("> %s result: %5.1f%%\n", label, 100.0 * passed / tested);	
}

void testIsvowel() {
	char *trueTests = "aeiouAEIOU";
	char *falseTests = "bcxyzDFGVW";
	char *p;
	int passed = 0;
	int tested = 0;
	for (p=trueTests; *p != '\0'; p++) {
		tested++;
		if (isvowel(*p)) {
			printf("test case passed: %c\n", *p);
			passed++;
		} else {
			printf("TEST CASE DID NOT PASS: %c\n", *p);
		}
	}
	for (p=falseTests; *p != '\0'; p++) {
		tested++;
		if (isvowel(*p)) {
			printf("TEST CASE DID NOT PASS: %c\n", *p);
		} else {
			printf("test case passed: %c\n", *p);
			passed++;
		}
	}
	printTestFooter("isvowel()", passed, tested);
}

void testCountvowels() {
	int testCount = 5;
	char *strs[] = {"aeiou", "My dog has fleas", "Rose-Hulman", "Klngn", "" };
	int expectedValues[] = {5, 4, 4, 0, 0};
	int passed = 0;
	int tested = 0;
	int i;
	for (i=0; i<testCount; i++) {
		tested++;
		int ans = countvowels(strs[i]);
		if (ans == expectedValues[i]) {
			printf("test case passed: '%s', got %d\n", strs[i], ans);
			passed++;
		} else {
			printf("TEST CASE DID NOT PASS: '%s', expected %d, got %d\n", strs[i],
						expectedValues[i], ans);
		}
	}
	printTestFooter("countvowels()", passed, tested);
}

void testAccessor(char *label, int actual, int expected, int *pc, int *tc) {
	(*tc)++;
	if (actual == expected) {
		(*pc)++;
		printf("test case passed %s\n", label);
	} else {
			printf("TEST CASE DID NOT PASS '%s', expected %d, got %d\n", label, 
						expected, actual);
	}
}

void testAreIntersectingTrue(char *rLabel, char *sLabel, 
								Rectangle r, Rectangle s,
								int *pc, int *tc) {
	(*tc)++;
	if (areIntersecting(r, s)) {
		(*pc)++;
		printf("test case passed %s and %s\n", rLabel, sLabel);
	} else {
		printf("TEST CASE DID NOT PASS %s and %s\n", rLabel, sLabel);
	}
}

void testAreIntersectingFalse(char *rLabel, char *sLabel, 
								Rectangle r, Rectangle s,
								int *pc, int *tc) {
	(*tc)++;
	if (areIntersecting(r, s)) {
		printf("TEST CASE DID NOT PASS %s and %s\n", rLabel, sLabel);
	} else {
		(*pc)++;
		printf("test case passed %s and %s\n", rLabel, sLabel);
	}
}

void testEqualRect(char *label, Rectangle r, Rectangle s, int *pc, int *tc) {
	(*tc)++;
	int areEqual = getTop(r) == getTop(s) && getLeft(r) == getLeft(s)
			&& getBottom(r) == getBottom(s) && getRight(r) == getRight(s); 
	if (areEqual) {
		(*pc)++;
		printf("test case passed %s\n", label);
	} else {
		printf("TEST CASE DID NOT PASS %s\n", label);
	}
}

int main() {
	/* Question 1:  Testing function printCharRange */
	printTestHeader("printCharRange()");
	printf("printCharRange('a','z') ==> ");
	printCharRange('a','z');
	printf("\nprintCharRange('l','p') ==> ");
	printCharRange('l','p');
	printf("\nprintCharRange('c','a') ==> ");
	printCharRange('c','a');
	printf("\nprintCharRange('1','9') ==> ");
	printCharRange('1','9');
	
	/* Question 2a:  Testing function isvowel */	
	printTestHeader("isvowel()");
	testIsvowel();
	
	/* Question 2b:  Testing function countvowels */
	printTestHeader("countvowels()");
	testCountvowels();
	
	/* Question 3:  Testing function printHourGlass */
	printTestHeader("printHourGlass()");
	printf("printHourGlass(5)\n");
	printHourGlass(5);
	printf("\nprintHourGlass(7)\n");
	printHourGlass(7);
	printf("\nprintHourGlass(1)\n");
	printHourGlass(1);
	printf("\nprintHourGlass(17)\n");
	printHourGlass(17);
	putchar('\n');
	
	/* Question 4a:  Testing function makeRect */		
	printTestHeader("makeRect()");
	printf("\nRECALL: r1, r2, r3, and r4 are from the figure on the exam.\n\n"); 
	printf("Making r1\n");
	Rectangle r1 = makeRect(-3, 3, 5, -2);
	printf("Making r2\n");
	Rectangle r2 = makeRect(6, 1, 2, 8);
	printf("Making r3\n");
	Rectangle r3 = makeRect(10, 7, 6, 4);
	printf("Making r4\n");
	Rectangle r4 = makeRect(2, 1, 5, 3);
	
	int passed, tested;
	
	/* Question 4b:  Testing function getLeft */
	printTestHeader("getLeft()");
	printf("\nRECALL: r1, r2, r3, and r4 are from the figure on the exam.\n\n"); 
	passed = 0;
	tested = 0;
	testAccessor("r1", getLeft(r1), -3, &passed, &tested);
	testAccessor("r2", getLeft(r2), 2, &passed, &tested);
	testAccessor("r3", getLeft(r3), 6, &passed, &tested);
	testAccessor("r4", getLeft(r4), 2, &passed, &tested);
	printTestFooter("getLeft()", passed, tested);
	
	/* Question 4c:  Testing function getRight */
	printTestHeader("getRight()");
	printf("\nRECALL: r1, r2, r3, and r4 are from the figure on the exam.\n\n"); 
	passed = 0;
	tested = 0;
	testAccessor("r1", getRight(r1), 5, &passed, &tested);
	testAccessor("r2", getRight(r2), 6, &passed, &tested);
	testAccessor("r3", getRight(r3), 10, &passed, &tested);
	testAccessor("r4", getRight(r4), 5, &passed, &tested);
	printTestFooter("getRight()", passed, tested);
	
	/* Question 4d:  Testing function getTop */
	printTestHeader("getTop()");
	printf("\nRECALL: r1, r2, r3, and r4 are from the figure on the exam.\n\n"); 
	passed = 0;
	tested = 0;
	testAccessor("r1", getTop(r1), 3, &passed, &tested);
	testAccessor("r2", getTop(r2), 8, &passed, &tested);
	testAccessor("r3", getTop(r3), 7, &passed, &tested);
	testAccessor("r4", getTop(r4), 3, &passed, &tested);
	printTestFooter("getTop()", passed, tested);
	
	/* Question 4e:  Testing function getBottom */
	printTestHeader("getBottom()");
	printf("\nRECALL: r1, r2, r3, and r4 are from the figure on the exam.\n\n"); 
	passed = 0;
	tested = 0;
	testAccessor("r1", getBottom(r1), -2, &passed, &tested);
	testAccessor("r2", getBottom(r2), 1, &passed, &tested);
	testAccessor("r3", getBottom(r3), 4, &passed, &tested);
	testAccessor("r4", getBottom(r4), 1, &passed, &tested);
	printTestFooter("getBottom()", passed, tested);
	
	/* Question 4f:  Testing function areIntersecting */
	printTestHeader("areIntersecting()");
	printf("\nRECALL: r1, r2, r3, and r4 are from the figure on the exam.\n\n"); 
	passed = 0;
	tested = 0;
	testAreIntersectingTrue("r1", "r2", r1, r2, &passed, &tested);
	testAreIntersectingTrue("r2", "r1", r2, r1, &passed, &tested);
	testAreIntersectingFalse("r1", "r3", r1, r3, &passed, &tested);
	testAreIntersectingFalse("r3", "r1", r3, r1, &passed, &tested);
	testAreIntersectingTrue("r1", "r4", r1, r4, &passed, &tested);
	testAreIntersectingTrue("r4", "r1", r4, r1, &passed, &tested);
	testAreIntersectingTrue("r2", "r3", r2, r3, &passed, &tested);
	testAreIntersectingTrue("r3", "r2", r3, r2, &passed, &tested);
	testAreIntersectingTrue("r2", "r4", r2, r4, &passed, &tested);
	testAreIntersectingTrue("r4", "r2", r4, r2, &passed, &tested);
	testAreIntersectingFalse("r3", "r4", r3, r4, &passed, &tested);
	testAreIntersectingFalse("r4", "r3", r4, r3, &passed, &tested);
	printTestFooter("areIntersecting()", passed, tested);
	
	/* Question 4g:  Testing function intersect */
	printTestHeader("intersect()");
	printf("Creating intersecting rectangles\n");
	Rectangle r12 = intersect(r1, r2);
	Rectangle r21 = intersect(r2, r1);
	Rectangle r14 = intersect(r1, r4);
	Rectangle r41 = intersect(r4, r1);
	Rectangle r23 = intersect(r2, r3);
	Rectangle r32 = intersect(r3, r2);
	Rectangle r24 = intersect(r2, r4);
	Rectangle r42 = intersect(r4, r2);
	
	printf("Testing intersection results\n");
	printf("\nRECALL: r1, r2, r3, and r4 are from the figure on the exam.\n\n"); 
	passed = 0;
	tested = 0;
	Rectangle line = makeRect(6,4,6,7);
	testEqualRect("intersect(r1, r2)", r12, r4, &passed, &tested);
	testEqualRect("intersect(r2, r1)", r21, r4, &passed, &tested);
	testEqualRect("intersect(r1, r4)", r14, r4, &passed, &tested);
	testEqualRect("intersect(r4, r1)", r41, r4, &passed, &tested);
	testEqualRect("intersect(r2, r3)", r23, line, &passed, &tested);
	testEqualRect("intersect(r3, r2)", r32, line, &passed, &tested);
	testEqualRect("intersect(r2, r4)", r24, r4, &passed, &tested);
	testEqualRect("intersect(r4, r2)", r42, r4, &passed, &tested);
	printTestFooter("intersect()", passed, tested);
	
	return 0;
}
