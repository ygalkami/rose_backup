/***************************************************************************
 *
 * PROGRAM  coordinator.c                                  
 *
 * Written by Archana Chidanandan, December 2008
 *
 *
 *
 * Description:
 * The coordinator process reads in the image data from a file.
 * It finds a shared memory segment and writes the image data to thes
 * shared memory segment. It also initializes all the histogram array values
 * in shared memory to 0.  
 * It creates "num_workers" child processes. Each child process's 
 * image is over-written with that of the "worker" process. After creating 
 * all child processes, the process waits for each child process to finish.
 * When all child processes are done, it will display the non-zero contents 
 * of the histogram.
 * It will then detach from the shared memory segment and release the space.
 *
 * 
 ***************************************************************************/

#include  <stdio.h>
#include  <stdlib.h>
#include  <sys/types.h>
#include  <sys/ipc.h>
#include  <sys/shm.h>
#include  <string.h>
#include  <unistd.h>
#include "shared_memory.h"



key_t SH_MEM_KEY = 1234; //Common key used to access the shared memory segment.
//If you change this key, you must also change it in the "worker.c" file.



/******************/
/*** Prototypes ***/
/******************/


/***************************************************************************
 *
 * Function int main ( int argc, char *argv[] )
 *
 * The main function forks "num_workers" child processes, waits until each
 * child exits and then prints the output of the histogram. It also populates
 * the 32 x 32 image in shared memory and initializes the histogram array values
 * to zero.
 * It takes two inputs: input file name and output file name.
 *
 ***************************************************************************/

int
main(int argc, char *argv[])
{
  int ShmID;
  sharedMemoryStruct* ShmPTR;

  /****************************/
  /*** Input error checking ***/
  /****************************/
   if(argc != 3){
	printf(" ./coordinator <input_file_name> <output_file_name>");
	exit(0);
   }

  /****************************/
  /*** Find and attach shared memory ***/
  /****************************/
  get_shared_memory_parent(&ShmID, &ShmPTR);


  /*****************************/
  /*** Populate the image array*/
  /**** in shared memory  *****/
  /*****************************/
 
  

  /*****************************/
  /** Initialize the histogram */
  /* values to zero in shared  */
  /* memory.                   */
  /*****************************/  


 
  /*****************************/
  /** Create workers  processes */
  /*****************************/ 
 



  
  

			
  /**************************************/
  /*** Wait for all  children to exit ***/
  /*                                    */        
  /**************************************/
  


  /**************************************/
  /*** Write the histogram data to the  */
  /*    output file.                    */        
  /**************************************/
  



    

  /*************************************/
  /*** Detach shared memory and exit ***/
  /*************************************/

  shmdt((void *) ShmPTR);
  printf("Parent has detached its shared memory...\n");
  shmctl(ShmID, IPC_RMID, NULL);
  printf("Parent has removed the shared memory...\n");

  printf("Parent exits...\n");
  exit(0);
}


