/* This is the shell you must fill in or replace in order to complete
   homework 7.  Do not forget to include your name in the initial
   comments of this file.
   Written by David Pick 12/14/08
*/
#include <stdio.h>
#include <stdlib.h>
#include "queue.h"

void deleteQueue(Queue *Aqueue) {
  Node* curr = Aqueue->head;
  
  if(queueSize(*Aqueue) != 0) {
    while(curr->next != NULL) {
      Node* temp = curr->next;
      
      free(curr);
      
      curr = temp;
    }
  }
  Aqueue->head = NULL;
  Aqueue->tail = NULL;
  //free(Aqueue);
}

Node* makeNode(int processId, int arrivalTime, int serviceTime, int remainingTime, Node* next) {
  Node* node = (Node*)malloc(sizeof(Node));
  node->processId = processId;
  node->arrivalTime = arrivalTime;
  node->serviceTime = serviceTime;
  node->remainingTime = remainingTime;
  node->next = next;
  
  return node;
}

Bool enqueue(Queue *Aqueue, int processId, int arrivalTime, int serviceTime, int remainingTime) {
  Node* newNode = makeNode(processId, arrivalTime, serviceTime, remainingTime, NULL);
  
  if (Aqueue->head == NULL) {
    Aqueue->head = newNode;
  } else {
    Aqueue->tail->next = newNode;
  }
  
  Aqueue->tail = newNode;
  
  return TRUE;
}

int printQueue(Queue Aqueue) {
  Node* curr = Aqueue.head;
  int count = 0;
  printf("Process ID\tArrival Time\tService Time\tRemaining Time\n");
  while(curr != NULL) {
    printf("%d\t\t%d\t\t%d\t\t%d\n", curr->processId, curr->arrivalTime, curr->serviceTime, curr->remainingTime);
    count++;
    curr = curr->next;
  }
  printf("\n");
  return count;
}

int queueSize(Queue Aqueue) {
  Node* curr = Aqueue.head;
  int count = 0;
  
  while(curr != NULL) {
    count++;
    curr = curr->next;
  }

  return count;
}

Node dequeue(Queue *Aqueue) {
  if (Aqueue->head != NULL) {  
    Node* curr = Aqueue->head;
    Node temp;
    temp.processId = curr->processId;
    temp.arrivalTime = curr->arrivalTime;
    temp.serviceTime = curr->serviceTime;
    temp.remainingTime = curr->remainingTime;
    Aqueue->head = curr->next;
    
    free(curr);

    return temp;
    
  } else {
    Node temp;
    temp.processId = -1;
    temp.arrivalTime = -1;
    temp.serviceTime = -1;
    temp.remainingTime = -1;
    temp.next = NULL;
    
    return temp;
  }  
}