/* ----------------------------------------------------------------- 
 * PROGRAM  client.c                                                 
 * The client process uses a key (shared by the server process) to  
 * access the shared memory space.			             
 * It attaches the shared memory to its own address space and then   
 * modifies some of the values. 
 * ----------------------------------------------------------------- */

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>


int SH_MEM_KEY = 1234;


typedef struct {
  int int1;
  int int2;
  int int3;
  int int4;
} sharedMemoryStruct;


void getSharedMemory(int *ShmID, sharedMemoryStruct **ShmPTR);


int main(int argc, char *argv[]){
  int ShmID;                         //ID of shared memory space 
  sharedMemoryStruct *ShmPTR;        //Pointer to shared memory space 
  pid_t pid;
  int status;
     
  getSharedMemory(&ShmID, &ShmPTR);

  printf("Child has accessed %d   %d %d %d in shared memory...\n",
         ShmPTR->int1, ShmPTR->int2, ShmPTR->int3, ShmPTR->int4);
            
  //Modify values in the shared memory space.
  ShmPTR->int2 = 325;
  ShmPTR->int3  = 256;

  //Detach the shared memory from the process's address space.  
  shmdt((void *) ShmPTR);
  printf("Client has detached its shared memory...\n\n\n");

  //Do not release the shared memory space. The server will do that. 
  exit(0);
}

void getSharedMemory(int *ShmID, sharedMemoryStruct **ShmPTR){
  printf("\n\n\nThe client process is attaching to the shared memory\n");

  //Request a shared memory space
  *ShmID = shmget(SH_MEM_KEY, 0, 0);
  if (*ShmID < 0){
    perror("*** shmget error (client) ***\n");
    exit(1);
  }
  
  //Assign a pointer to the shared memory space.  
  *ShmPTR = (sharedMemoryStruct *) shmat(*ShmID, NULL, 0);
  if ((int) *ShmPTR == -1){
    perror("*** shmat error (client) ***\n");
    exit(1);
  }
}
