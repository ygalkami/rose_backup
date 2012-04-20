
#include  <stdio.h>
#include  <stdlib.h>
#include  <sys/types.h>
#include  <sys/ipc.h>
#include  <sys/shm.h>
#include  <string.h>
#include  <unistd.h>
#include <semaphore.h>


/******************/
/*** Prototypes ***/
/******************/

void child1();
void child2();
void getSharedMemory();


/* A struct is not really needed here. However, if the shared memory segment 
   is to hold variables of different types, then a struct must be used to
   specify the type and the number of variables to be stored in the shared
   memory segment.
*/
typedef struct {
  int message;
  sem_t s;
  sem_t t;
} sharedMemoryStruct;

