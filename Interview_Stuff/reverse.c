#include <stdio.h>

int main() {
  int x = 3;
  int y = 5;
  
  swap(&x, &´y);
  
  printf("The value of x is %d, the value of y is %d\n", x, y);
}

void swap(int *px, int *py) {
  int temp;
  
  temp = *px;
  *px = *py;
  *py = temp;
}