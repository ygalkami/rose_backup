/* This is where you implement the core solution.
   by David Pick, 11/03/08
*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "inv.h"

int main (int argc, char *argv[]) {
  //Variable Declarations
  char c[100];
  char *num, *quantity, *price, *date1, *date2, *date3;
  FILE *inFile = NULL;
  FILE *outFile = NULL;
  struct Inventory array[100];
  int count = 0;
  
  //check for correct number of aruguments
  if (argc < 2 ) {
    printf("You must pass two file names");
  } else {
    //open files for reading and writing
    inFile = fopen(argv[1], "r");
    outFile = fopen(argv[2], "w");
    
    if (inFile == NULL || outFile == NULL) {
      exit(1);
    }
    
    //loop through input file, till reach eof
    while (fgets(c, sizeof(c), inFile)) {
        //break each line into a struct
        num = strtok(c, " ");
        quantity = strtok(NULL, " ");
        price = strtok(NULL, " ");
        date1 = strtok(NULL, " ");
        date2 = strtok(date1, "/");
        date3 = strtok(NULL, "/");
        
        //put information in array
        array[count].price = atof(price);
        array[count].number = atoi(num);
        array[count].quantity = atoi(quantity);
        array[count].Date.month = atoi(date2);
        array[count].Date.year = atoi(date3);
                
        //write lines with dates past december/2004 to outfile
        if (array[count].Date.year == 2004) {
          if (array[count].Date.month == 12) {
            fprintf(outFile, "%d %d %g %d/%d\n", array[count].number, array[count].quantity, array[count].price, array[count].Date.month, array[count].Date.year);
          }
        } else if (array[count].Date.year > 2004) {
            fprintf(outFile, "%d %d %g %d/%d\n", array[count].number, array[count].quantity, array[count].price, array[count].Date.month, array[count].Date.year);
        }
        count++;
    }
    //close files / write info to them
    fclose(inFile);
    fclose(outFile);
    
  }
  return 0;

}