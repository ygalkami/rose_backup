/*
 * Sample code for the homework of the third session on Python-like C features.
 * by Delvin Defoe, CSSE 120, Oct. 26, 2007. 
 * Modified by David Pick, on 10/31/07
 */
 
 #include <stdio.h> 
 
/* Swaps the values of x and y */ 
void swap(double *x, double *y ){
	/* TO DO:  This function should swap the values of x and y
	 * The values of these varaibles should appear swapped after
	 * this function is called. */
	 double temp;
	 temp = *y;
	 *y = *x;
	 *x = temp;
}
 
/* Test the swap function to see if it works */ 
void testSwap(double *x, double *y){
	printf("Before swapping: x = %2.2lf, y = %2.2lf\n", *x, *y);	
	swap(x, y);
	printf("After  swapping: x = %2.2lf, y = %2.2lf\n", *x, *y);
} 

/* Print the values stored in an array */
void printArray(double *h, int size){
 	int i;
   	for(i = 0 ; i < size; i++) {
    	printf("houses[%d] has a value of %2.2lf\n", 
            i, *(h + i));
  	}	
}

/* Sort array so that elements are in increasing order */
void sort(double h[], int size){
	/* TO DO: this function should sort the elements in the
	 * passed array so that the elements are in increasing order. */
	 int i;
	 int j;
	 for (i = 0; i < size; i++)
	 {
	 	for (j = 0; j < size; j++)
	 	{
	 		if (h[i] < h[j])
	 			swap(&h[i], &h[j]);
	 	}
	 }
}

/* Find and return the mean value of the passed array */
double findMean(double h[], int size){
	double mean = 0.0;
	int i;
	for (i = 0; i < size; i++)
	{
		//printf("%d\n", *(h + i));
		//printf("%f\n", mean);
		mean = mean + h[i];
	}
	mean = mean / size;
	return mean;
}

/* Find and return the median value from the passed array */
double findMedian(double h[], int size){
	double median = 0.0;
	int center;
	center = size / 2;
	sort(h, size);
	median = h[center];
	return median;
}

/* Find and display the n highest values from the passed array */
void printNHighestPrices(double h[], int size, int n){
	int i;
	sort(h, size);
	printf("The 5 most expensive 4 bedroom homes in Vigo County are: ");
	for (i=0; i<n; i++)
	{
		printf("$%2.1lf, ", h[size - i - 1]);
	}
	printf("\n");
	;
}

/* Find and display the n lowest values from the passed array */
void printNlowestPrices(double h[], int size, int n){
	int i;
	sort(h, size);
	printf("The least expensive 4 bedroom homes in Vigo Country are: ");
	for (i=0; i<n; i++)
	{
		printf("$%2.1lf, ", h[i]);
	}
	printf("\n");
	;
}
 
int main(){
	double first = 12.0; //, second = 99.33;
	/* TO DO: This is where you initialize your house prices array.
	 * The rest of the values will default to 0.0 if you do not provide enough
	 * values to fill the entire array */
	int numberOfHomes = 71; // change this value here and on the next line.
	// C does not like you to initialize a variable-sized array.
	double houses[71] = {129500.0, 129900.0, 138900.0, 159900.0, 
    44900.0, 490000.0, 89500.0, 34000.0, 82000.0, 219900.0,
    47500.0, 144900.0, 159999.0, 99900.0, 166900.0, 229900.0,
    240000.0, 89900.0, 299900.0, 49900.0, 585000.0, 275000.0,
    209900.0, 259900.0, 269900.0, 389900.0, 86500.0, 99900.0,
    79900.0, 175000.0, 54900.0, 139900.0, 129900.0, 34900.0,
    119900.0, 257700.0, 149900.0, 139900.0, 149900.0, 174900.0,
    145900.0, 189900.0, 212900.0, 48900.0, 75900.0, 330000.0,
    17500.0, 235000.0, 449900.0, 179900.0, 119900.0, 147000.0,
    155000.0, 239000.0, 219900.0, 309000.0, 131900.0, 345000.0,
    165000.0, 299900.0, 45000.0, 230000.0, 99500.0, 83500.0,
    156900.0, 289900.0, 45900.0, 185500.0, 19000.0, 124000.0,
    159900.0};
	//testSwap(&first, &houses[2]);
	sort(houses, numberOfHomes);
	//printArray(&houses[0], numberOfHomes);
	double mean, median;
	mean = findMean(houses, numberOfHomes);
	median = findMedian(houses, numberOfHomes);
	printf("The mean price of 4 bedroom houses in Vigo County is $%2.1lf\n", mean);
	printf("The median price of 4 bedroom houses in Vigo Country is $%2.1lf\n", median);
	printNHighestPrices(houses, 10, 5);
	printNlowestPrices(houses, 10, 5);
	//int a[3] = {4}, b[] = {4};
	//printf ("Array equality: %d\n", a == b);
 	return 0;
 }
