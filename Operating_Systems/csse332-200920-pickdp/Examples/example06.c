#include <stdio.h>

struct birthday{
  int month;
  int day;
  int year;
};                      //Note the semi-colon

int main(){
  struct birthday mybday;	/* - no new needed ! */
	                        /* then, it's just like Java ! */

  mybday.day = 1;
  mybday.month = 1;
  mybday.year = 1977;
	
  printf("I was born on %d/%d/%d\n", mybday.day, mybday.month, mybday.year);
}
