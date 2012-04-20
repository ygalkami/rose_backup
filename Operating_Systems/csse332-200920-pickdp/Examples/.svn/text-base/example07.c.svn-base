#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
  int count = 0;
  if (argc < 2){
    printf("Must enter at least one argument\n");
    printf("Example: ./a.out this is program 7\n");
    exit(1);
  }

  printf(" The number of arguments is %d\n", argc);
  printf("And they are:\n");

  while (count < argc){
    printf("argv[%d]: %s\n", count, argv[count]);
    count++;
  }
  
  printf("\n");
  return 0;
}
