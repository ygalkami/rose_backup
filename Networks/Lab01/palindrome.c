/* This program sees if a word is a palindrome
Written by David Pick 3/12/09 */

#include <stdio.h>
#include <string.h>

int main () {
  char word[50];
  int len, i;
  
  while (1) {
    printf("Enter a word to check if it is a palindrome: ");
    scanf("%s", word);
    
    if (strcmp(word, ".") == 0) {
      break;
    } else {
      isPalindrome(word);
    }
  }
  
  return 0;
}

int isPalindrome (char *word) {
  char reversed[50];
  int len, i; 
 
  len = strlen(word);
  
  //printf("%d\n", len);
  
  for(i = 0; i < len; i++) {
    reversed[len - i - 1] = word[i];
  }
  
  reversed[len] = '\0';
  
  //printf("|%s| - |%s|\n", word, reversed);
  
  if (strcmp(word, reversed) == 0) {
    printf("The word is a palindrome\n");
  } else {
    printf("The word is not a palindrome\n");
  }
  
  return 1;
}
