#include <stdio.h>

char *mystrcat(char*, char*);
int main()
{
    char *p1 = "testblah";
    char *p2 = "blah";

    printf("%d", mystrend( p1, p2 ));

    return 0;
}


char *mystrcat(char *str1, char *str2)
{
  char *p = str1;
  while( *str1 ) str1++;
  while( *str1++ = *str2++ );
  return p;
}

int mystrend(char *str1, char *str2)
{
	int len = mystrlen(str2);
	int count = len;

	while(count >= 0) 
	{
		if (*(str1 + len) != *str2++)
		{
			return 1;
		}
		*str1++;
		count--;
	}

	return 0;
}

int mystrlen(char *str)
{
	int i = 0;

	while(*str++) {
		i++;
	}
	
	return i;
}