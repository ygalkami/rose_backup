
#include "shared_memory.h"

extern key_t SH_MEM_KEY;


/***************************************************************************
 *
 * Function void get_shared_memory_child( int* ShmID, int** ShmPTR )
 *
 * The call to this function will attach to the a block of memory attached to
 * using get_shared_memory_parent provided the same key is used.  
 * memory and return by reference the same ID and pointer.
 *
 ***************************************************************************/
void
get_shared_memory_child(int *ShmID, sharedMemoryStruct **ShmPTR)
{
  printf("\n\n\nThe client process is attaching to the shared memory\n");

  //Request a shared memory space
  *ShmID = shmget(SH_MEM_KEY, 0, 0);
  if (*ShmID < 0)
    {
      perror("*** shmget error (server) ***\n");
      exit(1);
    }

  //Assign a pointer to the shared memory space.  
  *ShmPTR = (sharedMemoryStruct *) shmat(*ShmID, NULL, 0);
  if ((int) *ShmPTR == -1)
    {
      perror("*** shmat error (server) ***\n");
      exit(1);
    }
}

/***************************************************************************
 *
 * Function void get_shared_memory_parent( int* ShmID, int** ShmPTR )
 *
 * The call to this function will create a block of shared memory,
 * attach to it, and return by reference the ID of the block and a pointer
 * to its first word.  Subsequent calls will attach to the same block of
 * memory and return by reference the same ID and pointer.
 *
 ***************************************************************************/
void
get_shared_memory_parent(int* ShmID, sharedMemoryStruct ** ShmPTR)
{
  //Request a shared memory space
  *ShmID = shmget(SH_MEM_KEY, sizeof(sharedMemoryStruct), IPC_CREAT | 0666);
  if (*ShmID < 0)
    {
      perror("*** shmget error (server) ***\n");
      exit(1);
    }
     
  //Assign a pointer to the shared memory space.
  *ShmPTR = (sharedMemoryStruct *) shmat(*ShmID, NULL, 0);
  if ((int) *ShmPTR == -1)
    {
      perror("*** shmat error (server) ***\n");
      exit(1);
    }
}
