#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int *ptr;
  
  /* allocate space to hold an int */
  ptr = (int*)malloc(4 * sizeof(int)); 
  
  /* do stuff with the space */
  *ptr = 4; //ptr[0] = 4;
  
  /* free up the allocated space */
  free(ptr);
  
  return 0;
}
