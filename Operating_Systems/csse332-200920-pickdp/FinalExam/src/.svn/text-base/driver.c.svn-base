/*************************************************************
 * Program: driver.c
 * Author: Archana Chidanandan (May 10, 2005)
 * Modified by delvin defoe, May 13, 2008
 * This program test the queue implementation.
 ************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "queue.h"

#define NUM_ITEMS 5

int main(int argc, char * argv[] ){
  
  llnode *head = NULL;
  llnode *tail = NULL;
  llnode tmp;

  int numItems;
  int processId = 1;
  int arrivalTime = 0;
  int serviceTime = 10;
  
  //Peek at the empty queue
  tmp = peek(&head, &tail);
  if (tmp.processId == -1){
    printf("Driver: No items to peek at! \n");
  }

  //Remove an item from an empty queue.
  tmp = dequeue(&head,&tail);
  if (tmp.processId == -1){
    printf("Driver: The queue is empty\n");
  }
  else{
    printf("Driver: ERROR: The queue should have been empty!!!\n");
  }
  
  //Add 5 items to the queue   
  for (numItems=0; numItems<NUM_ITEMS; numItems++){
    enqueue(&head, &tail, processId+numItems, arrivalTime+numItems,
	    serviceTime+numItems, serviceTime+numItems);
    //The remaining time is initially equal to the service time.
  }
  
  printf("Driver: The number of items in the list is %d\n", numOfItems(head));
  printf("Driver: It should be 5\n");
  
  displayList(head);
  
  //Remove an item from the queue. It will be removed from the front
  //of the queue.
  printf("Removing item #1 from the queue using dequeue\n");
  tmp =  dequeue(&head, &tail);
  if (tmp.processId == -1){
    printf("Driver: ERROR: The queue cannot be empty!!\n");
  }
  else{
    printf("Driver: Removed item %d from the queue\n", tmp.processId);
  }
  
  displayList(head);
  
  //Remove another item from the queue.
  printf("Removing item #2 from the queue using dequeue\n");
  tmp = dequeue(&head,&tail);
  if (tmp.processId == -1){
    printf("Driver: ERROR: The queue cannot be empty!!\n");
  }
  else{
    printf("Driver: Removed item %d from the queue\n", tmp.processId);
  }
  
  displayList(head);
  
  //Remove remaining items from the queue.
  for (numItems = 0; numItems < NUM_ITEMS - 2; numItems++){
    tmp =   peek(&head, &tail);
    if (tmp.processId == -1){
      printf("Driver: ERROR: The queue is empty!! No items to peek at.\n");
    }
    else{
      printf("Driver: Process id of item at the front of the queue is %d\n", tmp.processId);
    }
    
    tmp = dequeue(&head,&tail);
    if (tmp.processId == -1){
      printf("Driver: ERROR: The queue cannot be empty!!\n");
    }
    else{
      printf("Driver: Removed item %d from the queue\n", tmp.processId);
    }
  }
  
  printf("Driver: Printing the contents of the queue. "
         "There should be no items!\n");
  displayList(head);
  printf("Driver: There are %d items in the queue .... testing numItems\n",
         numOfItems(head));
  
  printf("Driver: Adding two items and then testing freeList\n");
  
  enqueue(&head, &tail, 100, 5,5,5);
  enqueue(&head, &tail, 101, 1,1,1);
  printf("Driver: Displaying the two items just enqueued\n");
  printf("Driver: If no items listed, then dequeue is not setting \n"
         "Driver: head and tail to null when last item is removed\n");
  displayList(head);
  
  //Free any space created for the queue
  printf("Driver: Removing all items using freeList\n");
  freeList(&head, &tail);
  
  printf("Driver: Printing an empty queue\n");
  displayList(head);
  
  //Try to remove an item from an empty queue
  printf("Driver: Trying to remove an item from an empty queue\n");
  tmp = dequeue(&head, &tail);
  if (tmp.processId == -1){
    printf("Driver: The queue was empty. No item to remove!!\n");
  }
  else{
    printf("Driver: ERROR - removed an item from an empty queue!!!\n");
  }
  
  //Add an item to the queue
  printf("Driver: Adding an item to a list made empty by freeList\n");
  enqueue(&head, &tail, 5, 4, 3, 1);
  
  printf("Driver: Added the following one item successfully to the queue\n");
  displayList(head);
  
  return 0;
}



