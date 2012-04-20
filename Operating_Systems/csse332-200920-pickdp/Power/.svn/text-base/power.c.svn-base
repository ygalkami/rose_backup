//Pow written by David Pick
#include <math.h>
#include <stdio.h>

int main() {
  //declare variables for use later
  float x, sum = 0;
  int y, count = 0;
  
  //ask user for x and y values
  printf("Enter and float and an integer\n");
  scanf("%f %d", &x, &y);
  sum = x;
  
  //calculate pow without math.h
  for (count = 1; count < y; count++) {
    sum = sum * x;
  }
  if ( y == 0) {
    sum = 1;
  }
  
  //print my pow and math.h pow
  printf("Mine: %lf^%d = %.2f\n", x, y, sum);
  printf("Math.h: %lf^%d = %.2f\n", x, y, pow(x, y));
  return 0;
}