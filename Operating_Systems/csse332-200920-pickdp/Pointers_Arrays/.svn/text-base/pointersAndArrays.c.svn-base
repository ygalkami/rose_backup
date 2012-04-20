/*
 * Example using arrays and pointers.
 * by Delvin Defoe, CSSE 332, Dec. 2, 2007. 
 * modified by David Pick, 12/9/08.
 */
#include <stdio.h>
/* Initialize a fixed size array of integers with random numbers */
void fillArray(int a[], int size);

/* Print an array of integers when the array is passed as a parameter */
void printArray(int a[], int size);

/* Print an array of integers when a pointer to the array is passed as 
 * a parameter*/
void printArrayWithPointers(int *ap, int size);
 
 
/* Initialize a fixed size array of integers with random numbers */
void fillArray(int a[], int size){
  int index;
  for(index = 0; index < size; index++){
    a[index] = rand() % 100;
  }
}
 
/* Print an array of integers when the array is passed as a parameter */
void printArray(int a[], int size){
  int index;
  printf("\nprintArray:  Printing the array of integers on a single line.\n");
  for(index = 0; index < size; index++){
    printf("scores[%d]=%d \n", index, a[index]);
  }
  printf("\n");
}

// Print an array of integers when the array is passed as a pointer
void printArrayWithPointers(int *ap, int size) {
  int index;
  printf("\nprintArrayWithPointers: Printing the array of integers.\n");
  for (index = 0; index < size; index++) {
    printf("scores[%d] = %d\n", index, *(ap + index));
  }
}

 
int main(){
  int aSIZE;
  printf("Enter an integer for the size of an integer array\n");
  
  // Flushes (writes) any data from internal buffers to the console
  fflush(stdout);  
  scanf("%d", &aSIZE);
  int scores[aSIZE];
  fillArray(scores, aSIZE);
  printArray(scores, aSIZE);
  printArrayWithPointers(&scores, aSIZE);
  return 0;
}
