/************************************************************
 * Program: driver.c
 * Author: Archana Chidanandan (May 10, 2005)
 * Modified: Alex Hanson (December, 13, 2006)
 * Delvin Defoe, March 17, 2008
 *
 * This program is a test driver for the queue implementation.
 *
 ************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "queue.h"

#define NUM_ITEMS 5


int main(int argc, char *argv[]){
  Queue myQueue;
  
  myQueue.head = NULL;
  myQueue.tail = NULL;

  int numItems;
  int processId = 2;
  int arrivalTime = 0;
  int serviceTime = 10;
    
  //Remove a node from an empty queue.
  printf("About to remove a node from an empty queue...\n");
  Node node = dequeue(&myQueue);
  printf("Done removing a node from an empty queue. \n\n");

  //Add NUM_ITEMS nodes to the queue
  //The remaining time is initially equal to the service time
  printf("About to add %d nodes to the queue...\n", NUM_ITEMS);
  for (numItems = 0; numItems < NUM_ITEMS; numItems++){
    enqueue(&myQueue, processId+numItems, arrivalTime+numItems,
	    serviceTime+numItems, serviceTime+numItems);
  }
  printf("Done adding nodes to the queue. \n\n");

  //Test numOfItems.
  printf("The number of nodes in the queue is %d\n\n", queueSize(myQueue));
  
  //Print values of nodes in myQueue.
  printf("About to print values in nodes in the queue...\n");
  printQueue(myQueue);
  printf("Done printing values in nodes in the queue. \n\n");

  //Remove a node from the queue. It will be removed from the head
  //of the queue.
  printf("About to removing a node from the queue...\n");
  node = dequeue(&myQueue);
  printf("Done removing a node from the queue. \n\n");
 
 //Print values of nodes in myQueue.
  printf("About to print values in nodes in the queue...\n");
  printQueue(myQueue);
  printf("Done printing values in nodes in the queue. \n\n");


  //Remove another node from the queue. 
  printf("About to removing another node from the queue...\n");
  node = dequeue(&myQueue);
  printf("Done removing another node from the queue. \n\n");
 
  
 //Print values of nodes in myQueue.
  printf("About to print values in nodes in the queue...\n");
  printQueue(myQueue);
  printf("Done printing values in nodes in the queue. \n\n");


  //Remove remaining nodes from the queue.
  printf("About to remove the remaining nodes from the queue...\n");
  for (numItems = 0; numItems < NUM_ITEMS - 2; numItems++){
    node = dequeue(&myQueue);
  }
  printf("Done removing the remaining nodes from the queue.\n\n");
  

  //Print values of nodes in myQueue.
  printf("About to print values in nodes in the queue...\n");
  printQueue(myQueue);
  printf("Done printing values in nodes in the queue. \n\n");
  
  
  //Free any space created for the queue
  printf("About to free space allocated for the queue...\n");
  deleteQueue(&myQueue);
  printf("Done freeing space allocated for the queue.\n\n");


 //Print values of nodes in myQueue.
  printf("About to print values in nodes in the queue...\n");
  printQueue(myQueue);
  printf("Done printing values in nodes in the queue. \n\n");

  
  //Remove a node from an empty queue.
  printf("About to remove a node from an empty queue...\n");
  node = dequeue(&myQueue);
  printf("Done removing a node from an empty queue.\n\n");
  
  //Add a node to the queue
  printf("About to adding a node to the queue...\n");
  enqueue(&myQueue, 5, 4, 3, 1);
  printf("Done adding a node to the queue.\n\n");

 //Print values of nodes in myQueue.
  printf("About to print values in nodes in the queue...\n");
  printQueue(myQueue);
  printf("Done printing values in nodes in the queue. \n\n");

  return 0;
}
