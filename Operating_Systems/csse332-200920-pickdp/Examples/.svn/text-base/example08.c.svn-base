#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
  /* Declare a file pointer */
  FILE *inFile=NULL; 

  /* open file for writing*/
  inFile = fopen("test.txt", "w");
  /* need to do explicit ERROR CHECKING */
  if (inFile == NULL){
    exit(1);
  }
  /* write some data into the file */
  fprintf(inFile, "Hello there\n");

  /* don't forget to release file pointer */
  fclose(inFile); 

  return 0;
}
