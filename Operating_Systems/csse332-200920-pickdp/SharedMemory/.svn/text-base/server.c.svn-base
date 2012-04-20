/* ----------------------------------------------------------------- 
 * PROGRAM  server.c                                              
 * The main function serves as the server that requests a shared      
 * memory of four integers, attaches the shared memory to its own    
 * address space, fills it with the numbers from command line, forks 
 * a client, waits until its client completes, detaches the shared   
 * memory, removes the shared memory, and finally exits.             
 *								     
 * The client process is overlaid with the image of another process  
 * that uses the common key to get the shared memory region. It then  
 * attaches the shared memory space to its own address space, accesses         
 * values in the space, and modifies the values as needed.              
 * The parent process (server) and a child process (client) can thus 
 * communicate with each other using the shared memory space.        
 *								     
 * For this program to run successfully, an executible called "client"
 * must exist in the same directory as this program.		     
 * ----------------------------------------------------------------- */

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <string.h>
#include <unistd.h>


int SH_MEM_KEY = 1234;


typedef struct {
  int int1;
  int int2;
  int int3;
  int int4;
} sharedMemoryStruct;


void getSharedMemory(int *ShmID, sharedMemoryStruct **ShmPTR);


int main(int argc, char *argv[]){
  int ShmID;	                 //Id to shared memory  
  sharedMemoryStruct *ShmPTR;  //Pointer to shared memory  
  pid_t pid;
  int status;
     
  //Accept the four input numbers that will stored in the shared memory space.
  if (argc != 5){
    printf("Use: %s #1 #2 #3 #4\n", argv[0]);
    exit(1);
  }
  
  //Request for shared memory space for 4 integers where "1234" is the
  //common key id.
  getSharedMemory( &ShmID, &ShmPTR ) ;
     
  //Write the input values to the shared memory space.
  ShmPTR->int1 = atoi(argv[1]);
  ShmPTR->int2 = atoi(argv[2]);
  ShmPTR->int3 = atoi(argv[3]);
  ShmPTR->int4 = atoi(argv[4]);
  printf("Server has filled %d %d %d %d in shared memory...\n",
         ShmPTR->int1, ShmPTR->int2, ShmPTR->int3, ShmPTR->int4);
  
  printf("Server is about to fork a child process...\n");
  pid = fork();
  if (pid < 0){
    printf("*** fork error (server) ***\n");
    exit(1);
  }
  else if (pid == 0){ //In the child process
    printf("Client process started\n");
    //Overlay the image of the child process with that of  
    //"client".  
    execlp("./client","client",NULL,NULL);
    exit(0);
  }
          
  wait(&status);        //Parent wait for child process to complete. 
  printf("Server has detected the completion of its child...\n");
  printf("Server reads %d %d %d %d from shared memory...\n",
         ShmPTR->int1, ShmPTR->int2, ShmPTR->int3, ShmPTR->int4);
  shmdt((void *) ShmPTR);
  printf("Server has detached its shared memory...\n");
  shmctl(ShmID, IPC_RMID, NULL);
  printf("Server has removed its shared memory...\n");
  printf("Server exits...\n");
  exit(0);
}


void getSharedMemory(int *ShmID, sharedMemoryStruct **ShmPTR){
  //Request a shared memory space
  *ShmID = shmget(SH_MEM_KEY, sizeof(sharedMemoryStruct), IPC_CREAT | 0666);
  if (*ShmID < 0){
    perror("*** shmget error (server) ***\n");
    exit(1);
  }
  
  //Assign a pointer to the shared memory space.  
  *ShmPTR = (sharedMemoryStruct *) shmat(*ShmID, NULL, 0);
  if ((int) *ShmPTR == -1){
    perror("*** shmat error (server) ***\n");
    exit(1);
  }
}
