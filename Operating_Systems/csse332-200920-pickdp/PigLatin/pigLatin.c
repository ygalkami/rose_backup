/* This is the shell you must fill in or replace in order to complete
   homework 4.  Do not forget to include your name in the initial
   comments of this file.
*/
//Writenn by David Pick, 11/7/08
#include <stdio.h>
#include <string.h>

int main (int argc, char *argv[]) {
  //declare variables
  char sent[500], *temp, word[32];
  int c;
  int count = 0;
  printf("Enter a sentance to translate to piglatin: ");
  
  //read in sentance to be translated, and pass each word to the translate function
  while ((c = getchar()) != '\n') {
    if (count == 0) {
      printf("The translated sentance is: ");
      count++;
    }
    ungetc(c, stdin);
    scanf("%s", &word);
    //translate and print each word
    translate(word);
  }  
  return 0;
}

int translate (char *word) {
    char ch;
    char piglatin[32];
    char append[] = "h";
    
    //store first letter of word
    ch = *word;
    
    //remove first letter from word by moving pointer
    word++;
    //copy word without first letter to new variable
    strcpy(piglatin, word);
    append[0] = ch;
    //add first letter to end of word
    strcat(piglatin, append);
    //add ay to end of word
    strcat(piglatin, "ay");
    //print translated word
    printf("%s ", piglatin);
}