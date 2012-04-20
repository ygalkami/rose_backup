#include <stdio.h>
#include <ctype.h>
#include <string.h>

struct tnode {
  int value;
  struct tnode *left;
  struct tnode *right;
};

struct tnode *addtree(struct tnode *p, int value)
{  
  if (p == NULL) {
    p = (struct tnode *) malloc(sizeof(struct tnode));
    p->value = value;
    p->left = p->right = NULL;
  } else if (value < p->value) {
    p->left = addtree(p->left, value);
  } else {
    p->right = addtree(p->right, value);
  }
  return p;
}

void printinorder(struct tnode *p)
{
  if (p != NULL) {
    printinorder(p->left);
    printf("%d ", p->value);
    printinorder(p->right);
  }
}

int height(struct tnode *p)
{
	if (p == NULL) {
		return 0;
	} else {
		return 1 + max(height(p->left), height(p->right));
	}
}

int max( int a, int b) {
	if (a >= b)
		return a;
	else
		return b;
}

int main () {
  struct tnode *root;
  root = addtree(NULL, 5);
  root = addtree(root, 3);
  root = addtree(root, 7);
	root = addtree(root, 1);
	root = addtree(root, 4);
	printf("Height = %d\n", height(root));
  printinorder(root);
}
