#include <stdio.h>

int leg(n, x) {
  if (n == 0) { return 1; }
  else if (n == 1) { return x; }
  else if (n == 2) { return ((3*x*x - 1) / 2); }
  else {
    return ((2 * n - 1) * x * leg(n - 1, x) - (n - 1) * leg(n - 2, x)) / n;
  }
}

int main () {
  printf("%d", leg(2, 2));
  
  return 0;
}