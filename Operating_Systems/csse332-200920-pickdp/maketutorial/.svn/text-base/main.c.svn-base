/* Name: gdbexample.c 
 * Author: Archana Chidanandan, December 3, 2007
 *         Modified by Delvin Defoe, December 11, 2008
 * Description: This program is meant to be used with a tutorial on 
 * gdb. It is also used with a tutorial on Make.  The accompanying make
 * file describes the use of the make utility to compile programs.
 */

#include <stdio.h>
#include <stdlib.h>
#include "author.h"


int main(int argc, char *argv[]){
  
  Author *ptr;       /* Used to show how pointers and their pointees
			 can be examined using gdb */
  
  Author one;         /* Used to show how a struct can be examined 
			 using gdb, */
  
  /* The following is included to show how command line arguments must
     be specified when running the program */
  if(argc < 2){
    printf("Error: incorrect number of arguments\n");
    printf("<exec-name> num_of_times_to_display_info\n");
    return 1;
  }
  
  int count = atoi(argv[1]);
  
  strcpy(one.name,"J. K. Rowling");
  one.book_count = 4;
  strcpy(one.book_name[0],"Harry Potter and the Philosopher's Stone");
  strcpy(one.book_name[1],"Harry Potter and the Chamber of Secrets");
  strcpy(one.book_name[2],"Harry Potter and the Prisoner of Azkaban");
  
  ptr = &one;

  int i = 0;
  for(i = 0; i < count; i++){
    display_author_details(one);  
  }

  return 0;
}

        	



          

		 

	

	
