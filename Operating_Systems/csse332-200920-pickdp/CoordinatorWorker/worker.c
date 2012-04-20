/* ----------------------------------------------------------------- */
/* PROGRAM  worker.c                                                 */
/* Written by: Archana Chidanandan, December 2008                    */
/*  The client process uses a key (shared by the server process) to  */
/* access the shared memory space.			                     */
/* It attaches the shared memory to its own address space and then   */
/* modifies some of the values.                                      */
/* It accesses the image data in shared memory using the co-ordinates*/
/* provided as command line arguments. It also reads in a copy of the*/
/* histogram array. It then updates the local copy of the histogram  */
/* based on the sub-matrix it is responsible for. It uses the        */
/* provided update_histogram_array() function to do this. It then    */
/* updates the histogram in shared memory with the new values.       */
/* ----------------------------------------------------------------- */

#include  <stdio.h>
#include  <stdlib.h>
#include  <sys/types.h>
#include  <sys/ipc.h>
#include  <sys/shm.h>
#include  <string.h>
#include  <unistd.h>
#include <time.h>
#include "shared_memory.h"
#include "update_histogram.h"


key_t SH_MEM_KEY = 1234; //key shared between all the processes that want to access the same shared memory segment.


/******************/
/*** Prototypes ***/
/******************/


/***************************************************************************
 *
 * Function int main ( int argc, char *argv[] )
 *
 * The main function determines the co-ordiantes of the 8 x 8 array. It will
 * read the values of the 8 x 8 array from shared memory. It will also read
 * the values of the histogram array from shared memory. It will then call the
 * "update_histogram_array" function to update the histogram based on the 8 x 8
 * matrix. It will then update the histogram array in shared memory.
 * It takes as command line arguments the coordiantes of the 8 x x array.
 *
 ***************************************************************************/

int
main(int argc, char *argv[])
{
  int ShmID;                         //ID of shared memory space 
  sharedMemoryStruct *ShmPTR;        //Pointer to shared memory space 
  

 /****************************/
  /*** Input error checking ***/
  /****************************/


  /****************************/
  /*** Attach shared memory ***/
  /****************************/
  get_shared_memory_child(&ShmID, &ShmPTR);  



 /*****************************/
 /* Read the values of the   **/
 /* 8 x 8 array from shared   */
 /* memory.                 ***/ 
  /****************************/


 
 /*****************************/
 /* Call the function to update**/
 /* the histogram based on the ***/
 /* values in the 8 x 8 array **/ 
  /****************************/
  update_histogram_array( .... , .....);
			
  


 /**********************************/
 /* Write the new updated histogram*/
 /* values to shared memory.       */
 /**********************************/


/**********************************/
/*  Worker process is done.       */
/*  Detach the shared memory from */ 
/*  the process's address space.  */
  shmdt((void *) ShmPTR);
  
printf("Client has detached its shared memory...\n\n\n");

  //Do not release the shared memory space. The server will do that. 
  exit(0);
}



