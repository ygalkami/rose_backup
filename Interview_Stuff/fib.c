#include <stdio.h>

int main()
{
  printf("%d", fib(4));
}

int fib(int n)
{
  if (n == 0)
    return 1;
  else
    return n*fib(n-1);
}