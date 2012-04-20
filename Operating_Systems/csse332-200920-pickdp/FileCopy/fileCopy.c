/* Implement your solution to the File Copy problem here.
   by David Pick, 12/6/08
*/

#include <stdio.h>

int main(int argc, char *argv[]) {
  //declare variables
  int chars = 0;
  char array[500];
  
  //check for correct number of files being passed
  if (argc < 2) {
    printf("You must pass two file names");
  }
  
  //read from file
  chars = ReadFromFile(argv[1], array);
  //printf("there are %d characters", chars);
  //Write to file
  WriteToFile(argv[2], array, chars);
  
}

int ReadFromFile (char *filename, char a[]) {
  FILE *inFile = fopen(filename, "r");
  char readChar;
  int count = 0;
  
  //check if file exists
  if (inFile == NULL) {
    printf("You must pass a valid file");
    exit(1);
  }
  //read char by char into array
  fscanf(inFile, "%c", &readChar);
  a[count] = readChar;
  while(feof(inFile) == 0) {
    count++;
    fscanf(inFile, "%c", &readChar);
    a[count] = readChar;
  }
  //return number of chars read
  return count;
}

int WriteToFile (char *outFileName, char a[], int numChars) {
  int count;
  FILE *outFile = fopen(outFileName, "w");
  
  //check if file exists
  if (outFile == NULL) {
    printf("You must pass a valid file");
    exit(1);
  }
  
  //check contents of array to out file
  for(count = 0; count < numChars; count++) {
    fprintf(outFile, "%c", a[count]);
  }
  
  return 0;
}