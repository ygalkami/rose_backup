/* File: queue.h
   Author: Archana Chidanandan (4 Dec 2005)
   Modified by Delvin Defoe, May 13, 2008
   This header file creates a struct to be used 
   in the scheduling project. It also contains the
   prototpyes of the functions used to access the
   queue implemented in queue.c */

struct node {
    int processId;
    int arrivalTime;
    int serviceTime;
    int remainingTime;
    struct node *next; //points to the next node
    struct node *prev; //points to the previous node
};

typedef struct node llnode;

/****************************************************
 * Function: freeList
 * Remove all the items from the list. Also, free the
 * space allocated to each node. The head pointer must
 * be set to NULL. The tail pointer must be set to NULL.
 ****************************************************/
void freeList(llnode **head,llnode **tail);  

/************************************************************
 * Function: enqueue
 * Add an item to the list. The  space for the item will
 * allocated on the heap. The item will be added to the end
 * of the list. The head pointer will continue pointing to the 
 * beginning of the list. The tail pointer will point to the
 * last item on the queue.
 ************************************************************/

void enqueue(llnode **head, llnode **tail, int processId, 
	int arrivalTime, int serviceTime, int remainingTime);

/***************************************************
 * Function: displayList
 * Displays the value of each item in the list. 
 * Starts at the head.
 * Also, returns the number of items in the list.
 ***************************************************/
int displayList(llnode *head);

/****************************************************
 * Function: numOfItems 
 * Returns the number of items in the list.
 ***************************************************/
int numOfItems(llnode *head);

/***************************************************
 * Function: dequeue
 * Removes an item from the head of the list and returns it.
 * Also, the space on the heap occupied by the node is freed.
 * The head pointer is updated to point to the next
 * item. If there are no items in the queue, then 
 * return an item with process id = -1.
 ***************************************************/
llnode dequeue(llnode **head, llnode **tail);  


/***************************************************
 * Function: peek
 * Makes a copy of an item at the head of the list and returns it.
 * The item is NOT removed from the queue. If there are no items 
 * in the queue, then return an item with process id = -1.
 ***************************************************/
llnode peek(llnode **head, llnode **tail);  
