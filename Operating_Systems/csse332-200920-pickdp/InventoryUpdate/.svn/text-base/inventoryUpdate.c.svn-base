/* This is the shell you must fill in or replace in order to complete
   homework 5.  Do not forget to include your name in the initial
   comments of this file.
   Written by David Pick, 12/10/08
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "inv.h"

int main (int argc, char *argv[]) {
  Inventory *inv;
  //inv = (Inventory *) malloc(sizeof(Inventory[2]));
  inv = malloc(sizeof(Inventory)*2);
  int entries, entriesAftDel;
  //printf("%d", (int) *inv.number);
  
  if (argc < 2) {
    printf("You must pass two arguments");
  } else {
   
    printf("With Expired Items: \n");
    entries = PopulateArray(argv[1], &inv, 2);
    PrintInventory(&inv, entries);
    entriesAftDel = DeleteExpiredItems(&inv, entries);
    SaveInventory(&inv, entriesAftDel, argv[2]);
    printf("Without Expired Items: \n");
    PrintInventory(&inv, entriesAftDel);

  }
  return 0;
}

//Populate the array with the data from the text file passed
int PopulateArray (char* file, Inventory **inv, int size) {
  FILE *inFile = fopen(file, "r");
  char b[500];
  int count = 0;
  
  //check for valid file
  if (inFile == NULL) {
    printf("You must pass a valid file");
    exit(1);
  }
  
  //use fgets to read file line by line
  while(fgets(b, sizeof(b), inFile)) {
    //check to see if close to size of array, if so make the array bigger
    if (count >= size) {
      //make the array bigger and redefine size
      *inv =  (Inventory*)realloc(*inv, 2 * size * sizeof(Inventory));
      size = size * 2;
    }
    //read the contents of the file into the array
    sscanf(b, "%d %d %f %d/%d", &(*inv+count)->number, &(*inv+count)->quantity, &(*inv+count)->price, &(*inv+count)->Date.month, &(*inv+count)->Date.year);
    
    count++;
  }
  
  fclose(inFile);
  return count;
}

//print the array in the correct format
int PrintInventory (Inventory **inv, int size) {
  int count = 0;
  printf("Item Number\tQuantity\tPrice\tExpiration Date\n");
  for (count = 0; count < size; count++) {
    printf("%d\t\t%d\t\t%g\t%d/%d\n", (*(*inv+count)).number, (*(*inv+count)).quantity, (*(*inv+count)).price, (*(*inv+count)).Date.month, (*(*inv+count)).Date.year);
  }
  
  return 0;
}

//Delete the expired items from the array
int DeleteExpiredItems (Inventory **inv, int size) {
  int count = 0;
  int remove = 0, returnvalue = 0;
  returnvalue = size;
  
  //loop through array looking for expired items
  for (count = 0; count < returnvalue; count++) {
    if ((*inv)[count].Date.year < 2005) {
      //if the item is expired remove the item by shifting the contents of the rest of the array
      for (remove = count + 1; remove < size; remove++) {
        (*inv)[remove - 1] = (*inv)[remove];
      }
      count--;
      returnvalue--;
    }
  }
  //free the now unused memory
  *inv = (Inventory*)realloc(*inv, returnvalue * sizeof(Inventory));
  
  return returnvalue;
}

//write contents of the array to the output file
void SaveInventory (Inventory **inv, int size, char* file) {
  FILE *outFile = fopen(file, "w");
  int count = 0;
  
  fprintf(outFile, "Item Number\tQuantity\tPrice\tExpiration Date\n");
  for (count = 0; count < size; count++) {
    fprintf(outFile, "%d\t\t%d\t\t%g\t%d/%d\n", (*inv)[count].number, (*inv)[count].quantity, (*inv)[count].price, (*inv)[count].Date.month, (*inv)[count].Date.year);
  }
  
  fclose(outFile);
}