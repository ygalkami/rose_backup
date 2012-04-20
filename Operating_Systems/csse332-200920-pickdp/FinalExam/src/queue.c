/*************************************************************
 * Program: queue.c
 * Author: Archana Chidanandan (Dec.4, 2005)
 * Modified by Delvin Defoe, May 13, 2008
 * This program implements a queue (i.e. FIFO). It has been 
 * created for use in the scheduling project for CSSE 332.
 * It uses a doubly-linked list.
 *
 * Description:
 * Every node in the list has a pointer to the next item on the list
 * and a pointer to the previous item on the list. 
 * There is a head pointer that always points to the beginning of
 * the list. There is a tail pointer that points to the last item
 * in the list. When the list is empty, the head and tail pointers 
 * point to NULL.
 * 
 ************************************************************/
 
#include <stdio.h>
#include <stdlib.h>
#include "queue.h"


/************************************************************
 * Function: enqueue
 * Add an item to the list. The  space for the item will
 * created on the heap. The item will be added to the end
 * of the list. The head pointer will continue pointing to the 
 * beginning of the list. The tail pointer will point to the
 * last item added.
 ************************************************************/

void enqueue(llnode **head, llnode **tail, int processId, int arrivalTime,
        int serviceTime, int remainingTime){
  llnode *tmp;
  int numItems;

  if ((tmp = (llnode*)malloc(sizeof(llnode))) == NULL){
    printf("Unable to allocate space for an item!\n");
    (void)exit(EXIT_FAILURE);
  }
  
  tmp->processId = processId;
  tmp->arrivalTime = arrivalTime;
  tmp->serviceTime = serviceTime;
  tmp->remainingTime = remainingTime;
  tmp->next = NULL;
  tmp->prev = NULL;
  
  /*If the queue is empty, both tail and head point to
    the added item. */
  if (*tail == NULL){ 
    *tail = tmp;
    *head = tmp;
      return;
    }
  
  /*If the queue is not empty, then make the last item's next pointer
    point to new item.  Make the tail pointer point to the new item. */
  tmp->prev = (*tail);
  (*tail)->next = tmp;
  *tail = tmp;
}
 

/****************************************************
 * Function: freeList
 * Remove all the items from the list. Also, free the
 * space allocated for each node. The head pointer must
 * be set to NULL. The tail pointer must be set to NULL.
 ****************************************************/

void freeList(llnode **head,llnode **tail){
  llnode *tmp;

  if (*head == NULL){
    return;
  }

  while (*head != NULL){
    tmp = (*head)->next; //Get a pointer to the next item 
    free(*head);         //Free the previous item
    *head = tmp;         //Make head point to the next item
  }
  
  *head = NULL;
  *tail = NULL;
}


/****************************************************
 * Function: numOfItems 
 * Returns the number of items in the list.
 ***************************************************/

int numOfItems(llnode *head){
  int count = 0;
  llnode *tmp;
  
  if (head == NULL) {//No items
    return 0;
  }
  
  //There is at least one item    
  count++;
  tmp = head;
  
  //If there are more 
  while (tmp->next != NULL){
    count++;
    tmp = tmp->next;
  }
  
  return count;
}


/***************************************************
 * Function: displayList
 * Displays the value of each item in the list. 
 * Starts at the head.
 * Also, returns the number of items in the list.
 ***************************************************/
    
int displayList(llnode *head){
  int count = 0;
  llnode *tmp;
  
  if (head == NULL){
    return 0;
  }
  
  count++;
  tmp = head;
  printf("Process id\tArrival Time\tSerivce Time\t Remaining Time\n");
  printf("\t%d\t\t%d\t\t%d\t\t%d\n", tmp->processId, tmp->arrivalTime,
         tmp->serviceTime, tmp->remainingTime);
  while (tmp->next != NULL){
    count++;
    tmp = tmp->next;
    printf("\t%d\t\t%d\t\t%d\t\t%d\n", tmp->processId, tmp->arrivalTime,
	   tmp->serviceTime, tmp->remainingTime);
  }

  return count;
}


/***************************************************
 * Function: dequeue
 * Removes an item from the head of the list. Also,
 * the space on the heap occupied by the node is freed.
 * The head pointer is updated to point to the next
 * item. Return an item with processId = -1 for an 
 * empty queue.
 ***************************************************/
       
llnode dequeue(llnode **head,llnode **tail){
  llnode *tmp;
  llnode itemRemoved;
  
  if (*head == NULL){
    itemRemoved.processId = -1;
    return itemRemoved;
  }
  
  itemRemoved.processId = (*head)->processId;
  itemRemoved.arrivalTime = (*head)->arrivalTime;
  itemRemoved.serviceTime = (*head)->serviceTime;
  itemRemoved.remainingTime = (*head)->remainingTime;
  
  //Moving the head pointer to the next node.
  tmp = (*head)->next;
  free(*head);
  *head = tmp;
  if (*head != NULL){
    (*head)->prev = NULL;
  }
  
  if (*head == NULL){
    (*tail) = NULL;
  }
 
  return itemRemoved;
} 



/***************************************************
Function: peek
 * Makes a copy of an item at the head of the list and returns it.
 * The item is NOT removed from the queue. If there are no items
 * in the queue, then return an item with process id = -1.
 ***************************************************/
llnode peek(llnode **head,llnode **tail){
  llnode *tmp;
  llnode firstItem;
  
  //If the queue is empty.
  if (*head == NULL){
    firstItem.processId = -1;
    return firstItem;
  }
  
  //Queue is not empty
  firstItem.processId = (*head)->processId;
  firstItem.arrivalTime = (*head)->arrivalTime;
  firstItem.serviceTime = (*head)->serviceTime;
  firstItem.remainingTime = (*head)->remainingTime;
  
  return firstItem;
}


