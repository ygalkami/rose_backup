#include <stdio.h>
#include <ctype.h>
#include <string.h>

struct node {
	int value;
	struct node *next;
};

struct node *addEl(struct node *p, int value) {
	if (p == NULL) {
		p = (struct node *) malloc(sizeof(struct node));
		p->value = value;
		p->next = NULL;
	} else {
		p->next = addEl(p->next, value);
	}

	return p;
}

void print(struct node *p) {
	if (p != NULL) {
		printf("%d ", p->value);
		print(p->next);
	}
}

void delete(struct node *p, int value) {
	struct node *prev = p;

	while(p) {
		if (p->value == value) {
			prev->next = p->next;
			free(p);
		}
		prev = p;
		p = p->next;
	}
}

void reverse(struct node *p)
{
	struct node *next = p->next;
	struct node *current = p;
	struct node *last = p;

	while(next != NULL) {
		current = next;
		next = current->next;
		current->next = last;

		last = current;
	}
}

int main() {
	struct node *head;
	struct node *tail;

	head = addEl(NULL, 1);
	tail = addEl(head, 2);
	tail = addEl(tail, 3);
	tail = addEl(tail, 4);
	print(head);
	printf("\n");
	delete(head, 4);
	print(head);

}
