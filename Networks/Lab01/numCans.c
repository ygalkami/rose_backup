/* Program to calculate the number of cans of paint needed
to paint a swimming pool
Written by David Pick 3/12/09 */

#include <stdio.h>
#include <math.h>

int main() {
  float height, width, depth, total;
  float numCans;
  
  printf("Enter the height, width, and depth, seperated by commas: ");
  scanf("%f, %f, %f", &height, &width, & depth);
  
  total = (width * depth) + (height * depth) * 2 + (height * width) * 2;
  numCans = total / 200;

  printf("The area to cover is %2.2f\n", total);  
  printf("The number of cans needed is %1.0f", ceilf(numCans));

  return 0;
}