#include <stdio.h>

int main(int argc, char *argv[]){
  int *ptr, j; // j is not a pointer.

 /* initialize ptr before using it 
   *ptr = 4 does NOT initialize ptr */
  ptr = &j;  
  
  *ptr = 4;   /* j <- 4 */
  
  j = *ptr+1; /* j <- ??? */
  
  return 0;
}
