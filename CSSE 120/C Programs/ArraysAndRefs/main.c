/*
 * Sample code for the third session on Python-like C features.
 * by Delvin Defoe, CSSE 120, Oct. 25, 2007. 
 */
 #include <stdio.h>
 
 /* Attempt to modify the values of its parameters*/
 void downAndUp(int takeMeHeigher, int putMeDown){
 	takeMeHeigher+=1;
 	putMeDown-=1;
 }
 
 /* Actually modifies the values of the variables its parameters point to. */
 void downAndUpthatWorks(int *takeMeHeigher, int *putMeDown){
	*takeMeHeigher += 1;
	*putMeDown -= 1;
 } 
 
 /* Test the downAndUp function to see if it works as expected*/
 void testdownAndUp(int up, int down){
 	printf("testdownAndUp: Before moving down and up\n");
 	printf("----------------------------------------\n");
 	printf("OnTheRise = %d, aboutToFail = %d.\n\n", up, down); 	
 	downAndUp(up, down);
 	printf("testdownAndUp: After moving down and up\n");
 	printf("---------------------------------------\n");
 	printf("OnTheRise = %d, aboutToFail = %d.\n\n", up, down);
 }
 
 /* Test the downAndUpthatWorks function to see if it really works*/
  void testdownAndUpthatWorks(int *up, int *down){
 	printf("testdownAndUpthatWorks: Before moving down and up\n");
 	printf("-------------------------------------------------\n");
 	printf("OnTheRise = %d, aboutToFail = %d.\n\n", *up, *down); 	
 	downAndUpthatWorks(up, down);
 	printf("testdownAndUpthatWorks: After moving down and up\n");
 	printf("------------------------------------------------\n");
 	printf("OnTheRise = %d, aboutToFail = %d.\n\n", *up, *down);
 }
 
 /* Initialize a fixed size array of integers by reading values from the user */
 void readScores(int a[], int size){
	int index = 20;
	int x;
	
	printf("We are about to initialize an array with %d integers\n", size);
	printf("Enter your first integer followed by <ENTER>");
	fflush(stdout);
	scanf("%d", &x);
	a[0] = x;
	for(index = 1; index < size; index++)
	{
		printf("Enter another integer follwed by <ENTER>");
		fflush(stdout);
		scanf("%d", &x);
		a[index] = x;
	}
	printf("\nThanks, we have recieved enough integers.\n");
 }
 
 /* Print an array of integers when the array is passed as a parameter */
 void printArray(int a[], int size){
 	int index;
 	printf("\nprintArray:  Printing the array of integers on a single line.\n");
 	for(index = 0; index < size; index++){
 		printf("scores[%d]=%d ", index, a[index]);	
 	}
 	printf("\n");
 }
 
 /* Print an array of integers when a pointer to the array is passed as a parameter*/
  void printArrayWithPointers(int *ap, int size){
	int index;
	printf("\printArray With Pointers: Printing the array of integers on a single line.\n");
	for (index = 0; index < size; index++)
	{
		printf("scores[%d]=%d ", index, *(ap + index));
	}
 }
 
 int main(){ 
 	
 	int onTheRise = 5;
 	int aboutToFail = 10;
 	int numberOfScores = 4;
 	int scores[numberOfScores];
	testdownAndUp(onTheRise, aboutToFail); 
	testdownAndUpthatWorks(&onTheRise, &aboutToFail);
	readScores(scores, numberOfScores);
	printArray(scores, numberOfScores);
	printArrayWithPointers(&scores[0], numberOfScores);
 	return 0;
 }